import { ApiProperty } from '@nestjs/swagger';
import {
  IsAlphanumeric,
  IsEmail,
  IsNotEmpty,
  IsOptional,
} from 'class-validator';

// todo
export class UpdateUserDto {
  @ApiProperty({
    title: 'Username',
    required: false,
    description: 'can contain only alphanumeric characters',
  })
  @IsOptional()
  @IsNotEmpty()
  @IsAlphanumeric()
  username?: string;

  @ApiProperty({
    title: 'Email',
    required: false,
    description: 'can be absent from request',
  })
  @IsOptional()
  @IsNotEmpty()
  @IsEmail()
  email?: string;

  @ApiProperty({
    title: 'Password',
    required: false,
  })
  @IsOptional()
  @IsNotEmpty()
  password?: string;
}
