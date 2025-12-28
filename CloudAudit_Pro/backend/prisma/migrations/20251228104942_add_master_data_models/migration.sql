/*
  Warnings:

  - The values [DEFERRED] on the enum `FindingStatus` will be removed. If these variants are still used in the database, this will fail.
  - The values [CASH_AND_BANK,ACCOUNTS_RECEIVABLE,INVENTORY,FIXED_ASSETS,ACCOUNTS_PAYABLE,REVENUE,EXPENSES,EQUITY,COMPLIANCE] on the enum `ProcedureCategory` will be removed. If these variants are still used in the database, this will fail.
  - The values [MINOR,MODERATE,SIGNIFICANT,MATERIAL] on the enum `Severity` will be removed. If these variants are still used in the database, this will fail.

*/
-- CreateEnum
CREATE TYPE "BankType" AS ENUM ('COMMERCIAL', 'INVESTMENT', 'CENTRAL', 'COOPERATIVE', 'SAVINGS', 'ISLAMIC', 'OTHER');

-- CreateEnum
CREATE TYPE "BankAccountType" AS ENUM ('CHECKING', 'SAVINGS', 'MONEY_MARKET', 'CURRENT', 'DEPOSIT', 'OTHER');

-- AlterEnum
BEGIN;
CREATE TYPE "FindingStatus_new" AS ENUM ('OPEN', 'IN_PROGRESS', 'RESOLVED', 'CLOSED');
ALTER TABLE "findings" ALTER COLUMN "status" DROP DEFAULT;
ALTER TABLE "findings" ALTER COLUMN "status" TYPE "FindingStatus_new" USING ("status"::text::"FindingStatus_new");
ALTER TYPE "FindingStatus" RENAME TO "FindingStatus_old";
ALTER TYPE "FindingStatus_new" RENAME TO "FindingStatus";
DROP TYPE "FindingStatus_old";
ALTER TABLE "findings" ALTER COLUMN "status" SET DEFAULT 'OPEN';
COMMIT;

-- AlterEnum
BEGIN;
CREATE TYPE "ProcedureCategory_new" AS ENUM ('SUBSTANTIVE_TESTING', 'COMPLIANCE_TESTING', 'ANALYTICAL_PROCEDURES', 'INTERNAL_CONTROLS', 'RISK_ASSESSMENT', 'OTHER');
ALTER TABLE "audit_procedures" ALTER COLUMN "category" TYPE "ProcedureCategory_new" USING ("category"::text::"ProcedureCategory_new");
ALTER TYPE "ProcedureCategory" RENAME TO "ProcedureCategory_old";
ALTER TYPE "ProcedureCategory_new" RENAME TO "ProcedureCategory";
DROP TYPE "ProcedureCategory_old";
COMMIT;

-- AlterEnum
BEGIN;
CREATE TYPE "Severity_new" AS ENUM ('LOW', 'MEDIUM', 'HIGH', 'CRITICAL');
ALTER TABLE "findings" ALTER COLUMN "severity" TYPE "Severity_new" USING ("severity"::text::"Severity_new");
ALTER TYPE "Severity" RENAME TO "Severity_old";
ALTER TYPE "Severity_new" RENAME TO "Severity";
DROP TYPE "Severity_old";
COMMIT;

-- AlterTable
ALTER TABLE "companies" ADD COLUMN     "countryId" TEXT,
ALTER COLUMN "currencyId" SET DATA TYPE TEXT;

-- CreateTable
CREATE TABLE "currencies" (
    "id" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "symbol" TEXT,
    "decimalPlaces" INTEGER NOT NULL DEFAULT 2,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "isBaseCurrency" BOOLEAN NOT NULL DEFAULT false,
    "displayOrder" INTEGER,
    "description" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdBy" TEXT,
    "updatedBy" TEXT,

    CONSTRAINT "currencies_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "exchange_rates" (
    "id" TEXT NOT NULL,
    "baseCurrencyId" TEXT NOT NULL,
    "targetCurrencyId" TEXT NOT NULL,
    "rate" DECIMAL(18,6) NOT NULL,
    "effectiveDate" TIMESTAMP(3) NOT NULL,
    "expiryDate" TIMESTAMP(3),
    "source" TEXT,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdBy" TEXT,
    "updatedBy" TEXT,

    CONSTRAINT "exchange_rates_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "countries" (
    "id" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "officialName" TEXT,
    "alpha3Code" TEXT,
    "numericCode" TEXT,
    "region" TEXT,
    "subRegion" TEXT,
    "currencyCode" TEXT,
    "dialCode" TEXT,
    "displayOrder" INTEGER,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdBy" TEXT,
    "updatedBy" TEXT,

    CONSTRAINT "countries_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "banks" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "code" TEXT,
    "swiftCode" TEXT,
    "routingNumber" TEXT,
    "addressLine1" TEXT,
    "addressLine2" TEXT,
    "city" TEXT,
    "state" TEXT,
    "postalCode" TEXT,
    "countryId" TEXT,
    "phone" TEXT,
    "email" TEXT,
    "website" TEXT,
    "currencyId" TEXT,
    "bankType" "BankType" DEFAULT 'COMMERCIAL',
    "displayOrder" INTEGER,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "description" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdBy" TEXT,
    "updatedBy" TEXT,

    CONSTRAINT "banks_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "bank_accounts" (
    "id" TEXT NOT NULL,
    "companyId" TEXT NOT NULL,
    "bankId" TEXT NOT NULL,
    "accountNumber" TEXT NOT NULL,
    "accountName" TEXT NOT NULL,
    "accountType" "BankAccountType" NOT NULL DEFAULT 'CHECKING',
    "openingBalance" DECIMAL(15,2),
    "currentBalance" DECIMAL(15,2),
    "branchName" TEXT,
    "branchCode" TEXT,
    "iban" TEXT,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "isPrimary" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdBy" TEXT,
    "updatedBy" TEXT,

    CONSTRAINT "bank_accounts_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "currencies_code_key" ON "currencies"("code");

-- CreateIndex
CREATE UNIQUE INDEX "exchange_rates_baseCurrencyId_targetCurrencyId_effectiveDat_key" ON "exchange_rates"("baseCurrencyId", "targetCurrencyId", "effectiveDate");

-- CreateIndex
CREATE UNIQUE INDEX "countries_code_key" ON "countries"("code");

-- CreateIndex
CREATE UNIQUE INDEX "countries_alpha3Code_key" ON "countries"("alpha3Code");

-- CreateIndex
CREATE UNIQUE INDEX "banks_code_key" ON "banks"("code");

-- CreateIndex
CREATE UNIQUE INDEX "banks_swiftCode_key" ON "banks"("swiftCode");

-- CreateIndex
CREATE UNIQUE INDEX "bank_accounts_companyId_accountNumber_key" ON "bank_accounts"("companyId", "accountNumber");

-- AddForeignKey
ALTER TABLE "companies" ADD CONSTRAINT "companies_currencyId_fkey" FOREIGN KEY ("currencyId") REFERENCES "currencies"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "companies" ADD CONSTRAINT "companies_countryId_fkey" FOREIGN KEY ("countryId") REFERENCES "countries"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "exchange_rates" ADD CONSTRAINT "exchange_rates_baseCurrencyId_fkey" FOREIGN KEY ("baseCurrencyId") REFERENCES "currencies"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "exchange_rates" ADD CONSTRAINT "exchange_rates_targetCurrencyId_fkey" FOREIGN KEY ("targetCurrencyId") REFERENCES "currencies"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "banks" ADD CONSTRAINT "banks_countryId_fkey" FOREIGN KEY ("countryId") REFERENCES "countries"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "banks" ADD CONSTRAINT "banks_currencyId_fkey" FOREIGN KEY ("currencyId") REFERENCES "currencies"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bank_accounts" ADD CONSTRAINT "bank_accounts_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bank_accounts" ADD CONSTRAINT "bank_accounts_bankId_fkey" FOREIGN KEY ("bankId") REFERENCES "banks"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
