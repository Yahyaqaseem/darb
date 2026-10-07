import { Injectable, UnauthorizedException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { UsersService } from '../users/users.service';

@Injectable()
export class AuthService {
  constructor(
    private usersService: UsersService,
    private jwtService: JwtService,
  ) {}

  async requestOtp(phone: string): Promise<any> {
    // In a real application, send OTP via SMS. For now, simulate.
    return { message: 'OTP sent successfully', devOtp: '123456' };
  }

  async verifyOtp(phone: string, otp: string): Promise<any> {
    // Simulate verification
    if (otp !== '123456') {
      throw new UnauthorizedException('Invalid OTP');
    }

    let user = await this.usersService.findByPhone(phone);
    if (!user) {
      user = await this.usersService.create(phone);
    }

    const payload = { sub: user.id, phone: user.phone, role: user.role };
    return {
      accessToken: this.jwtService.sign(payload),
      user,
    };
  }
}
