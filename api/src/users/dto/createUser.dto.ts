import { ApiProperty } from '@nestjs/swagger';
import { IsAlphanumeric, IsNotEmpty } from 'class-validator';

export class CreateUserDto {
  @ApiProperty({
    title: 'Username',
    description: 'can contain only alphanumeric characters',
  })
  @IsNotEmpty()
  @IsAlphanumeric()
  username: string;

  @ApiProperty({
    title: 'Password',
  })
  @IsNotEmpty()
  password: string;
}
