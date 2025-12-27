import { Test, TestingModule } from '@nestjs/testing';
import { LedgerService } from './ledger.service';
import { PrismaService } from '../prisma/prisma.service';

describe('LedgerService', () => {
  let service: LedgerService;
  let prisma: PrismaService;

  const mockPrismaService = {
    ledger: {
      findMany: jest.fn(),
      findFirst: jest.fn(),
      create: jest.fn(),
      update: jest.fn(),
      deleteMany: jest.fn(),
    },
    journalEntry: {
      findUnique: jest.fn(),
    },
    accountHead: {
      findUnique: jest.fn(),
    },
    period: {
      findUnique: jest.fn(),
    },
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        LedgerService,
        {
          provide: PrismaService,
          useValue: mockPrismaService,
        },
      ],
    }).compile();

    service = module.get<LedgerService>(LedgerService);
    prisma = module.get<PrismaService>(PrismaService);
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  describe('generateLedgerFromJournal', () => {
    it('should generate ledger entries from a posted journal entry', async () => {
      const journalEntryId = 'je-1';
      const tenantId = 'tenant-1';

      const mockJournalEntry = {
        id: journalEntryId,
        companyId: 'company-1',
        periodId: 'period-1',
        journalNumber: 'JV-001',
        entryDate: new Date('2024-01-15'),
        description: 'Test journal entry',
        isPosted: true,
        postedBy: 'user-1',
        lineItems: [
          {
            id: 'li-1',
            accountId: 'acc-1',
            lineNumber: 1,
            description: 'Debit line',
            debitAmount: 1000,
            creditAmount: 0,
            reference: 'REF-001',
          },
          {
            id: 'li-2',
            accountId: 'acc-2',
            lineNumber: 2,
            description: 'Credit line',
            debitAmount: 0,
            creditAmount: 1000,
            reference: 'REF-001',
          },
        ],
      };

      const mockAccount = {
        id: 'acc-1',
        name: 'Cash',
        code: '1000',
        accountType: {
          normalBalance: 'DEBIT',
        },
        openingBalance: 5000,
      };

      mockPrismaService.journalEntry.findUnique.mockResolvedValue(mockJournalEntry);
      mockPrismaService.ledger.findFirst.mockResolvedValue(null);
      mockPrismaService.accountHead.findUnique.mockResolvedValue(mockAccount);
      mockPrismaService.ledger.create.mockImplementation((args) => 
        Promise.resolve({ id: 'ledger-1', ...args.data })
      );

      const result = await service.generateLedgerFromJournal(journalEntryId, tenantId);

      expect(result).toHaveLength(2);
      expect(mockPrismaService.ledger.create).toHaveBeenCalledTimes(2);
    });

    it('should throw error if journal entry not found', async () => {
      mockPrismaService.journalEntry.findUnique.mockResolvedValue(null);

      await expect(
        service.generateLedgerFromJournal('invalid-id', 'tenant-1')
      ).rejects.toThrow('Journal entry invalid-id not found');
    });

    it('should throw error if journal entry is not posted', async () => {
      mockPrismaService.journalEntry.findUnique.mockResolvedValue({
        id: 'je-1',
        isPosted: false,
      });

      await expect(
        service.generateLedgerFromJournal('je-1', 'tenant-1')
      ).rejects.toThrow('Journal entry must be posted before generating ledger entries');
    });
  });

  describe('getAccountLedger', () => {
    it('should retrieve ledger entries for an account', async () => {
      const query = {
        companyId: 'company-1',
        periodId: 'period-1',
        accountId: 'acc-1',
      };

      const mockLedgerEntries = [
        {
          id: 'ledger-1',
          transactionDate: new Date('2024-01-15'),
          journalNumber: 'JV-001',
          debitAmount: 1000,
          creditAmount: 0,
          runningBalance: 6000,
          sequenceNumber: 1,
          account: {
            name: 'Cash',
            accountType: { normalBalance: 'DEBIT' },
          },
          journalEntry: {},
        },
      ];

      const mockAccount = {
        id: 'acc-1',
        openingBalance: 5000,
      };

      mockPrismaService.ledger.findMany.mockResolvedValue(mockLedgerEntries);
      mockPrismaService.accountHead.findUnique.mockResolvedValue(mockAccount);

      const result = await service.getAccountLedger(query);

      expect(result.openingBalance).toBe(5000);
      expect(result.entries).toHaveLength(1);
      expect(result.closingBalance).toBe(6000);
    });
  });

  describe('recalculateRunningBalances', () => {
    it('should recalculate running balances for an account', async () => {
      const mockEntries = [
        {
          id: 'ledger-1',
          debitAmount: 1000,
          creditAmount: 0,
          runningBalance: 0,
          account: {
            openingBalance: 5000,
            accountType: { normalBalance: 'DEBIT' },
          },
        },
        {
          id: 'ledger-2',
          debitAmount: 0,
          creditAmount: 500,
          runningBalance: 0,
          account: {
            openingBalance: 5000,
            accountType: { normalBalance: 'DEBIT' },
          },
        },
      ];

      mockPrismaService.ledger.findMany.mockResolvedValue(mockEntries);
      mockPrismaService.ledger.update.mockResolvedValue({});

      const result = await service.recalculateRunningBalances(
        'company-1',
        'period-1',
        'acc-1'
      );

      expect(result.updated).toBe(2);
      expect(mockPrismaService.ledger.update).toHaveBeenCalledTimes(2);
    });
  });

  describe('deleteLedgerEntries', () => {
    it('should delete ledger entries for a journal entry', async () => {
      mockPrismaService.ledger.deleteMany.mockResolvedValue({ count: 2 });

      const result = await service.deleteLedgerEntries('je-1');

      expect(result.deleted).toBe(2);
      expect(mockPrismaService.ledger.deleteMany).toHaveBeenCalledWith({
        where: { journalEntryId: 'je-1' },
      });
    });
  });
});
