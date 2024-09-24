import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty } from 'class-validator';

export class SignInDto {
  @ApiProperty({
    title: "Username",
  })
  @IsNotEmpty()
  username: string;

  @ApiProperty({
    title: "Password",
  })
  @IsNotEmpty()
  password: string;

  @ApiProperty({
    title: "Remember me"
  })
  @IsNotEmpty()
  rememberMe: boolean;
}