import {
  Body,
  Controller,
  Get,
  HttpStatus,
  Post,
  Req,
  UseGuards,
} from '@nestjs/common';
import {
  ApiBearerAuth,
  ApiOperation,
  ApiResponse,
  ApiTags,
} from '@nestjs/swagger';
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
  @ApiResponse({
    status: HttpStatus.OK,
    example: {
      id: 2,
      username: 'string',
      email: null,
      roleId: 2,
    },
  })
  async getCurrentUser(@Req() req: any) {
    return this.usersService.findOne(req.user.username);
  }

  @ApiResponse({
    status: HttpStatus.CREATED,
    example: {
      id: 5,
      username: 'strifg',
      email: null,
      roleId: 2,
    },
  })
  @Post('crud')
  @ApiOperation({ summary: 'creates a new user' })
  async create(@Body() createUserDto: CreateUserDto) {
    return this.usersService.create(createUserDto);
  }
}
