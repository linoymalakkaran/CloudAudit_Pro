/*
  Warnings:

  - You are about to drop the column `relatedReviews` on the `review_points` table. All the data in the column will be lost.

*/
-- CreateEnum
CREATE TYPE "SamplingMethod" AS ENUM ('RANDOM', 'SYSTEMATIC', 'STRATIFIED', 'MONETARY_UNIT', 'JUDGMENTAL', 'HAPHAZARD');

-- CreateEnum
CREATE TYPE "SamplingStatus" AS ENUM ('PLANNED', 'IN_PROGRESS', 'COMPLETED', 'REVIEWED');

-- CreateEnum
CREATE TYPE "TestType" AS ENUM ('VOUCHING', 'TRACING', 'RECALCULATION', 'CONFIRMATION', 'OBSERVATION', 'INSPECTION', 'ANALYTICAL_PROCEDURE', 'REPERFORMANCE');

-- CreateEnum
CREATE TYPE "TestStatus" AS ENUM ('PLANNED', 'IN_PROGRESS', 'COMPLETED', 'REVIEWED', 'EXCEPTION_NOTED');

-- CreateEnum
CREATE TYPE "ExceptionSeverity" AS ENUM ('LOW', 'MEDIUM', 'HIGH', 'CRITICAL');

-- CreateEnum
CREATE TYPE "ControlType" AS ENUM ('PREVENTIVE', 'DETECTIVE', 'CORRECTIVE', 'DIRECTIVE');

-- CreateEnum
CREATE TYPE "ControlNature" AS ENUM ('MANUAL', 'AUTOMATED', 'IT_DEPENDENT_MANUAL');

-- CreateEnum
CREATE TYPE "ControlFrequency" AS ENUM ('CONTINUOUS', 'DAILY', 'WEEKLY', 'MONTHLY', 'QUARTERLY', 'ANNUALLY', 'AD_HOC');

-- CreateEnum
CREATE TYPE "ControlEffectiveness" AS ENUM ('EFFECTIVE', 'PARTIALLY_EFFECTIVE', 'INEFFECTIVE', 'NOT_TESTED');

-- AlterTable
ALTER TABLE "review_points" DROP COLUMN "relatedReviews",
ADD COLUMN     "relatedReviewIds" TEXT[],
ALTER COLUMN "description" DROP NOT NULL;

-- CreateTable
CREATE TABLE "sampling" (
    "id" TEXT NOT NULL,
    "tenantId" TEXT NOT NULL,
    "companyId" TEXT NOT NULL,
    "periodId" TEXT NOT NULL,
    "procedureId" TEXT,
    "accountId" TEXT,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "samplingMethod" "SamplingMethod" NOT NULL,
    "status" "SamplingStatus" NOT NULL DEFAULT 'PLANNED',
    "populationSize" INTEGER NOT NULL,
    "sampleSize" INTEGER NOT NULL,
    "confidenceLevel" DOUBLE PRECISION,
    "tolerableError" DOUBLE PRECISION,
    "expectedError" DOUBLE PRECISION,
    "samplingInterval" INTEGER,
    "randomSeed" INTEGER,
    "selectionCriteria" TEXT,
    "stratificationBasis" TEXT,
    "errorsFound" INTEGER DEFAULT 0,
    "itemsTested" INTEGER DEFAULT 0,
    "conclusion" TEXT,
    "requiresProjection" BOOLEAN NOT NULL DEFAULT false,
    "projectedError" DOUBLE PRECISION,
    "createdBy" TEXT NOT NULL,
    "updatedBy" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "sampling_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "substantive_tests" (
    "id" TEXT NOT NULL,
    "tenantId" TEXT NOT NULL,
    "companyId" TEXT NOT NULL,
    "periodId" TEXT NOT NULL,
    "procedureId" TEXT,
    "accountId" TEXT,
    "samplingId" TEXT,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "testType" "TestType" NOT NULL,
    "status" "TestStatus" NOT NULL DEFAULT 'PLANNED',
    "transactionReference" TEXT,
    "transactionDate" TIMESTAMP(3),
    "transactionAmount" DOUBLE PRECISION,
    "sourceDocument" TEXT,
    "expectedResult" TEXT,
    "actualResult" TEXT,
    "proceduresPerformed" TEXT,
    "hasException" BOOLEAN NOT NULL DEFAULT false,
    "exceptionDescription" TEXT,
    "exceptionSeverity" "ExceptionSeverity",
    "exceptionAmount" DOUBLE PRECISION,
    "managementResponse" TEXT,
    "conclusion" TEXT,
    "performedBy" TEXT,
    "testDate" TIMESTAMP(3),
    "reviewedBy" TEXT,
    "reviewDate" TIMESTAMP(3),
    "createdBy" TEXT NOT NULL,
    "updatedBy" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "substantive_tests_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "internal_controls" (
    "id" TEXT NOT NULL,
    "tenantId" TEXT NOT NULL,
    "companyId" TEXT NOT NULL,
    "periodId" TEXT NOT NULL,
    "processArea" TEXT NOT NULL,
    "controlId" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "controlObjective" TEXT,
    "controlType" "ControlType" NOT NULL,
    "controlNature" "ControlNature" NOT NULL,
    "controlFrequency" "ControlFrequency" NOT NULL,
    "riskAddressed" TEXT,
    "riskLevel" "RiskLevel",
    "controlOwner" TEXT,
    "isKeyControl" BOOLEAN NOT NULL DEFAULT false,
    "testProcedures" TEXT,
    "testResult" TEXT,
    "controlEffectiveness" "ControlEffectiveness" NOT NULL DEFAULT 'NOT_TESTED',
    "deficiencyIdentified" BOOLEAN NOT NULL DEFAULT false,
    "deficiencyDescription" TEXT,
    "remediationPlan" TEXT,
    "remediationDeadline" TIMESTAMP(3),
    "managementResponse" TEXT,
    "testPerformedBy" TEXT,
    "testDate" TIMESTAMP(3),
    "reviewedBy" TEXT,
    "reviewDate" TIMESTAMP(3),
    "evidence" TEXT,
    "conclusion" TEXT,
    "createdBy" TEXT NOT NULL,
    "updatedBy" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "internal_controls_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "internal_controls_companyId_periodId_controlId_key" ON "internal_controls"("companyId", "periodId", "controlId");

-- AddForeignKey
ALTER TABLE "sampling" ADD CONSTRAINT "sampling_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "tenants"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sampling" ADD CONSTRAINT "sampling_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sampling" ADD CONSTRAINT "sampling_periodId_fkey" FOREIGN KEY ("periodId") REFERENCES "periods"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sampling" ADD CONSTRAINT "sampling_procedureId_fkey" FOREIGN KEY ("procedureId") REFERENCES "audit_procedures"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sampling" ADD CONSTRAINT "sampling_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "account_heads"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "substantive_tests" ADD CONSTRAINT "substantive_tests_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "tenants"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "substantive_tests" ADD CONSTRAINT "substantive_tests_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "substantive_tests" ADD CONSTRAINT "substantive_tests_periodId_fkey" FOREIGN KEY ("periodId") REFERENCES "periods"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "substantive_tests" ADD CONSTRAINT "substantive_tests_procedureId_fkey" FOREIGN KEY ("procedureId") REFERENCES "audit_procedures"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "substantive_tests" ADD CONSTRAINT "substantive_tests_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "account_heads"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "substantive_tests" ADD CONSTRAINT "substantive_tests_samplingId_fkey" FOREIGN KEY ("samplingId") REFERENCES "sampling"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "internal_controls" ADD CONSTRAINT "internal_controls_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "tenants"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "internal_controls" ADD CONSTRAINT "internal_controls_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "internal_controls" ADD CONSTRAINT "internal_controls_periodId_fkey" FOREIGN KEY ("periodId") REFERENCES "periods"("id") ON DELETE CASCADE ON UPDATE CASCADE;
