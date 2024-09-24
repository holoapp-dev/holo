import { Body, Controller, Get, Post, Req, UseGuards } from '@nestjs/common';
import { ApiBearerAuth, ApiOperation, ApiTags } from '@nestjs/swagger';
import { CreateUserDto } from './dto/createUser.dto';
import { UsersService } from './users.service';
import { AuthGuard } from '../auth/auth.guard';

@Controller('users')
@ApiTags('users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @Get('crud')
  @ApiOperation({ summary: 'get currently authorized user' })
  @ApiBearerAuth()
  @UseGuards(AuthGuard)
  async getCurrentUser(@Req() req: any) {
    return this.usersService.findOne(req.user.username);
  }

  @Post('crud')
  @ApiOperation({ summary: 'creates a new user' })
  async create(@Body() createUserDto: CreateUserDto) {
    return this.usersService.create(createUserDto);
  }
}
