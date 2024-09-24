import {
  Body,
  Controller,
  Get,
  HttpCode,
  HttpStatus,
  Post,
  UseGuards,
  Request,
} from '@nestjs/common';
import { SignInDto } from './dto/signIn.dto';
import { AuthService } from './auth.service';
import { AuthGuard } from './auth.guard';
import {
  ApiBearerAuth,
  ApiOperation,
  ApiResponse,
  ApiTags,
} from '@nestjs/swagger';

@Controller('auth')
@ApiTags('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @HttpCode(HttpStatus.OK)
  @Post('login')
  @ApiResponse({
    status: HttpStatus.OK,
    example:
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjIsInVzZXJuYW1lIjoic3RyaW5nIiwiaWF0IjoxNzI3MTg5ODY5LCJleHAiOjE3Mjk3ODE4Njl9.TqvSSdzE9YCFownWUH38hcPgYcuEF1ztv4Wyt7nO_iI',
  })
  @ApiOperation({ summary: 'login and get jwt token' })
  signIn(@Body() signInDto: SignInDto) {
    return this.authService.signIn(signInDto);
  }

  @UseGuards(AuthGuard)
  @Get('current')
  @ApiBearerAuth()
  @ApiOperation({ summary: 'get current jwt info' })
  @ApiResponse({
    status: HttpStatus.OK,
    example: {
      sub: 2,
      username: 'string',
      iat: 1727189794,
      exp: 1729781794,
    },
  })
  getCurrentAuth(@Request() req: any) {
    return req.user;
  }
}
