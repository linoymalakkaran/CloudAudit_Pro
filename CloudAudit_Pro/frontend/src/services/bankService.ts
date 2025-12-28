import api from './api';

export enum BankType {
  COMMERCIAL = 'COMMERCIAL',
  INVESTMENT = 'INVESTMENT',
  CENTRAL = 'CENTRAL',
  COOPERATIVE = 'COOPERATIVE',
  OTHER = 'OTHER',
}

export enum BankAccountType {
  CHECKING = 'CHECKING',
  SAVINGS = 'SAVINGS',
  MONEY_MARKET = 'MONEY_MARKET',
  CREDIT_LINE = 'CREDIT_LINE',
  LOAN = 'LOAN',
  OTHER = 'OTHER',
}

export interface Bank {
  id: number;
  name: string;
  code?: string;
  type?: BankType;
  address?: string;
  contactNumber?: string;
  email?: string;
  website?: string;
  isActive: boolean;
  createdAt: string;
  updatedAt: string;
}

export interface CreateBankDto {
  name: string;
  code?: string;
  type?: BankType;
  address?: string;
  contactNumber?: string;
  email?: string;
  website?: string;
  isActive?: boolean;
}

export interface UpdateBankDto {
  name?: string;
  code?: string;
  type?: BankType;
  address?: string;
  contactNumber?: string;
  email?: string;
  website?: string;
  isActive?: boolean;
}

export interface BankAccount {
  id: number;
  companyId: number;
  bankId: number;
  accountName: string;
  accountNumber: string;
  accountType: BankAccountType;
  currencyId: number;
  branch?: string;
  iban?: string;
  notes?: string;
  isActive: boolean;
  bank: Bank;
  currency: { code: string; symbol: string };
  company: { name: string };
  createdAt: string;
  updatedAt: string;
}

export interface CreateBankAccountDto {
  companyId: number;
  bankId: number;
  accountName: string;
  accountNumber: string;
  accountType: BankAccountType;
  currencyId: number;
  branch?: string;
  iban?: string;
  notes?: string;
  isActive?: boolean;
}

export interface UpdateBankAccountDto {
  companyId?: number;
  bankId?: number;
  accountName?: string;
  accountNumber?: string;
  accountType?: BankAccountType;
  currencyId?: number;
  branch?: string;
  iban?: string;
  notes?: string;
  isActive?: boolean;
}

const bankService = {
  // Bank endpoints
  getAllBanks: (isActive?: boolean) => {
    const params = isActive !== undefined ? `?isActive=${isActive}` : '';
    return api.get<Bank[]>(`/bank${params}`);
  },

  getBankById: (id: number) => {
    return api.get<Bank>(`/bank/${id}`);
  },

  createBank: (data: CreateBankDto) => {
    return api.post<Bank>('/bank', data);
  },

  updateBank: (id: number, data: UpdateBankDto) => {
    return api.patch<Bank>(`/bank/${id}`, data);
  },

  deleteBank: (id: number) => {
    return api.delete(`/bank/${id}`);
  },

  // Bank Account endpoints
  getAllBankAccounts: (companyId?: number, bankId?: number) => {
    const params = new URLSearchParams();
    if (companyId) params.append('companyId', companyId.toString());
    if (bankId) params.append('bankId', bankId.toString());
    const queryString = params.toString();
    return api.get<BankAccount[]>(`/bank/account${queryString ? '?' + queryString : ''}`);
  },

  getBankAccountById: (id: number) => {
    return api.get<BankAccount>(`/bank/account/${id}`);
  },

  createBankAccount: (data: CreateBankAccountDto) => {
    return api.post<BankAccount>('/bank/account', data);
  },

  updateBankAccount: (id: number, data: UpdateBankAccountDto) => {
    return api.patch<BankAccount>(`/bank/account/${id}`, data);
  },

  deleteBankAccount: (id: number) => {
    return api.delete(`/bank/account/${id}`);
  },
};

export default bankService;
