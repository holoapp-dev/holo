import {
  BadRequestException,
  Injectable,
  InternalServerErrorException,
} from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { User } from '@prisma/client';
import * as bcrypt from 'bcrypt';
import { CreateUserDto } from './dto/createUser.dto';
import { PrismaClientKnownRequestError } from '@prisma/client/runtime/library';

@Injectable()
export class UsersService {
  constructor(private prisma: PrismaService) {}

  async create(
    createUserDto: CreateUserDto,
  ): Promise<Omit<User, 'passwordHash'> | undefined> {
    let user;

    try {
      user = await this.prisma.user.create({
        data: {
          username: createUserDto.username,
          passwordHash: await this.hashPassword(createUserDto.password),
          // PLEASE DO NOT CHANGE USER ROLE ID IN DB PLEASE
          roleId: 2,
        },
        omit: {
          passwordHash: true,
        },
      });
    } catch (error) {
      if (error instanceof PrismaClientKnownRequestError) {
        if (error.code === 'P2002') {
          throw new BadRequestException('username already taken');
        }
      } else {
        throw new InternalServerErrorException(
          'unknown error while adding user to db',
        );
      }
    }

    return user;
  }

  async findOneWithPasswordHash(username: string): Promise<User | null> {
    return this.prisma.user.findUnique({ where: { username } });
  }

  async findOne(username: string): Promise<Omit<User, 'passwordHash'> | null> {
    return this.prisma.user.findUnique({
      where: { username },
      omit: { passwordHash: true },
    });
  }

  async hashPassword(password: string): Promise<string> {
    return bcrypt.hash(password, 10);
  }
}
