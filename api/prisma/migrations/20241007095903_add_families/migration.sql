-- CreateEnum
CREATE TYPE "FamilyRole" AS ENUM ('admin', 'memeber');

-- CreateTable
CREATE TABLE "Family" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Family_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FamilyUsers" (
    "userId" INTEGER NOT NULL,
    "familyId" INTEGER NOT NULL,
    "role" "FamilyRole" NOT NULL,

    CONSTRAINT "FamilyUsers_pkey" PRIMARY KEY ("userId","familyId")
);

-- CreateIndex
CREATE UNIQUE INDEX "FamilyUsers_userId_familyId_key" ON "FamilyUsers"("userId", "familyId");

-- AddForeignKey
ALTER TABLE "FamilyUsers" ADD CONSTRAINT "FamilyUsers_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FamilyUsers" ADD CONSTRAINT "FamilyUsers_familyId_fkey" FOREIGN KEY ("familyId") REFERENCES "Family"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
