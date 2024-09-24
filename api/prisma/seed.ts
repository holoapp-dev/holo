import { PrismaClient, Role } from '@prisma/client';
import * as bcrypt from 'bcrypt';
import * as dotenv from 'dotenv';

dotenv.config();

export const roles: Role[] = [
  // PLEASE DO NOT CHANGE THIS ROLE ID PLEASE
  {
    id: 1,
    name: 'admin',
  },
  // PLEASE DO NOT CHANGE THIS ROLE ID PLEASE
  {
    id: 2,
    name: 'user',
  },
];

const prisma = new PrismaClient();

async function main() {
  // todo: add first-run admin generation
  await prisma.role.createMany({ data: [...roles] });
  await prisma.user.create({
    data: {
      username: process.env.INIT_ADMIN_USERNAME || 'admin',
      roleId: 1,
      passwordHash: await bcrypt.hash(process.env.INIT_ADMIN_PASSWORD || 'password', 10),
    },
  });
}

main()
  .then(async () => {
    await prisma.$disconnect();
  })
  .catch(async (error) => {
    console.log(error);
    await prisma.$disconnect();
  });
