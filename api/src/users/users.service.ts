import {
  BadRequestException,
  Injectable,
  InternalServerErrorException,
  UnauthorizedException,
} from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { User } from '@prisma/client';
import * as bcrypt from 'bcrypt';
import { CreateUserDto } from './dto/createUser.dto';
import { PrismaClientKnownRequestError } from '@prisma/client/runtime/library';
import { UpdateUserDto } from './dto/updateUser.dto';

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

  async update(
    userJwt: any,
    updateUserDto: UpdateUserDto,
  ): Promise<Omit<User, 'passwordHash'>> {
    if (!userJwt) {
      throw new UnauthorizedException();
    }

    const passwordHash = updateUserDto.password
      ? await this.hashPassword(updateUserDto.password)
      : undefined;
    const emailExists =
      updateUserDto.email &&
      (await this.prisma.user.findFirst({
        where: { email: updateUserDto.email },
      }));
    const usernameExists =
      updateUserDto.username &&
      (await this.prisma.user.findFirst({
        where: { username: updateUserDto.username },
      }));

    if (usernameExists) {
      throw new BadRequestException('username is already in use');
    }

    if (emailExists) {
      throw new BadRequestException('email is already in use');
    }

    return this.prisma.user.update({
      where: { id: userJwt.sub },
      data: {
        username: updateUserDto.username,
        passwordHash,
        email: updateUserDto.email,
      },
      omit: {
        passwordHash: true,
      },
    });
  }

  async delete(userJwt: any): Promise<Omit<User, 'passwordHash'>> {
    if (!userJwt) {
      throw new UnauthorizedException();
    }

    return this.prisma.user.delete({
      where: { id: userJwt.sub },
      omit: { passwordHash: true },
    });
  }

  async findOneWithPasswordHash(username: string): Promise<User | null> {
    return this.prisma.user.findUnique({ where: { username } });
  }

  async findOne(id: number): Promise<Omit<User, 'passwordHash'> | null> {
    return this.prisma.user.findUnique({
      where: { id },
      omit: { passwordHash: true },
    });
  }

  async hashPassword(password: string): Promise<string> {
    return bcrypt.hash(password, 10);
  }
}
