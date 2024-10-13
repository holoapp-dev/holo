import {
  Injectable,
  NotFoundException,
  UnauthorizedException,
} from '@nestjs/common';
import { UsersService } from '../users/users.service';
import { SignInDto } from './dto/signIn.dto';
import { JwtService } from '@nestjs/jwt';
import * as bcrypt from 'bcrypt';

@Injectable()
export class AuthService {
  constructor(
    private usersService: UsersService,
    private jwtService: JwtService,
  ) {}

  async signIn(signInDto: SignInDto): Promise<string> {
    const user = await this.usersService.findOneWithPasswordHash(
      signInDto.username,
    );

    if (!user) {
      throw new NotFoundException('user not found');
    }

    if (!(await bcrypt.compare(signInDto.password, user.passwordHash))) {
      throw new UnauthorizedException('wrong password');
    }

    if (signInDto.rememberMe) {
      return this.jwtService.signAsync(
        { sub: user.id, username: user.username },
        { expiresIn: '30d' },
      );
    }

    return this.jwtService.signAsync({ sub: user.id, username: user.username });
  }
}
