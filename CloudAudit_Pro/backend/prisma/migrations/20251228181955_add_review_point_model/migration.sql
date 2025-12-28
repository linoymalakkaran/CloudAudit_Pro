-- CreateEnum
CREATE TYPE "ReviewCategory" AS ENUM ('AUDIT_FINDING', 'CLIENT_QUERY', 'TECHNICAL_ISSUE', 'DOCUMENTATION', 'COMPLIANCE', 'OTHER');

-- CreateEnum
CREATE TYPE "ReviewPointStatus" AS ENUM ('OUTSTANDING', 'IN_PROGRESS', 'PENDING_CLEARANCE', 'CLEARED', 'CARRIED_FORWARD');

-- CreateTable
CREATE TABLE "review_points" (
    "id" TEXT NOT NULL,
    "companyId" TEXT NOT NULL,
    "periodId" TEXT NOT NULL,
    "procedureId" TEXT,
    "accountId" TEXT,
    "tenantId" TEXT NOT NULL,
    "reviewNumber" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "category" "ReviewCategory" NOT NULL,
    "priority" "Priority" NOT NULL,
    "status" "ReviewPointStatus" NOT NULL DEFAULT 'OUTSTANDING',
    "raisedBy" TEXT NOT NULL,
    "raisedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "assignedTo" TEXT,
    "assignedAt" TIMESTAMP(3),
    "response" TEXT,
    "clearanceNotes" TEXT,
    "clearedBy" TEXT,
    "clearedAt" TIMESTAMP(3),
    "dueDate" TIMESTAMP(3),
    "targetDate" TIMESTAMP(3),
    "impact" TEXT,
    "relatedReviews" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdBy" TEXT NOT NULL,
    "updatedBy" TEXT NOT NULL,

    CONSTRAINT "review_points_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "review_points_companyId_periodId_status_idx" ON "review_points"("companyId", "periodId", "status");

-- CreateIndex
CREATE INDEX "review_points_assignedTo_status_idx" ON "review_points"("assignedTo", "status");

-- CreateIndex
CREATE UNIQUE INDEX "review_points_companyId_periodId_reviewNumber_key" ON "review_points"("companyId", "periodId", "reviewNumber");
