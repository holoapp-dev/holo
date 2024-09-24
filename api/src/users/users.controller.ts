import {
  Body,
  Controller,
  Delete,
  Get,
  HttpStatus,
  Patch,
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
import { UpdateUserDto } from './dto/updateUser.dto';

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
    return this.usersService.findOne(req.user.sub);
  }

  @Patch('crud')
  @ApiOperation({ summary: 'update currently authorized user' })
  @ApiBearerAuth()
  @UseGuards(AuthGuard)
  @ApiResponse({
    status: HttpStatus.OK,
    example: {
      id: 7,
      username: 'string',
      email: 'strinq@grqr.cqr',
      roleId: 2,
    },
  })
  async updateCurrentUser(
    @Req() req: any,
    @Body() updateUserDto: UpdateUserDto,
  ) {
    return this.usersService.update(req?.user, updateUserDto);
  }

  @Delete('crud')
  @ApiOperation({ summary: 'delete currently authorized user' })
  @ApiBearerAuth()
  @UseGuards(AuthGuard)
  @ApiResponse({
    status: HttpStatus.OK,
    example: {
      id: 6,
      username: 'string',
      email: null,
      roleId: 2,
    },
  })
  async deleteCurrentUser(@Req() req: any) {
    return this.usersService.delete(req?.user);
  }

  @ApiResponse({
    status: HttpStatus.CREATED,
    example: {
      id: 5,
      username: 'string',
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
