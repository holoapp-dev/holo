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
import { ApiBearerAuth, ApiOperation, ApiTags } from '@nestjs/swagger';

@Controller('auth')
@ApiTags('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @HttpCode(HttpStatus.OK)
  @Post('login')
  signIn(@Body() signInDto: SignInDto) {
    return this.authService.signIn(signInDto);
  }

  @UseGuards(AuthGuard)
  @Get('current')
  @ApiBearerAuth()
  @ApiOperation({summary: "get current user"})
  getCurrentAuth(@Request() req: any) {
    return req.user;
  }
}
