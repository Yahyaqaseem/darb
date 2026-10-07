import { Controller, Get, Post, Body, UseGuards } from '@nestjs/common';
import { TripsService } from './trips.service';
import { JwtAuthGuard } from '../../common/guards/jwt-auth.guard';
import { CurrentUser } from '../../common/decorators/current-user.decorator';
import { User } from '../users/entities/user.entity';

@Controller('v1/trips')
@UseGuards(JwtAuthGuard)
export class TripsController {
  constructor(private readonly tripsService: TripsService) {}

  @Get()
  async getMyTrips(@CurrentUser() user: User) {
    return this.tripsService.getUserTrips(user.id);
  }

  @Post()
  async createTrip(@CurrentUser() user: User, @Body() data: any) {
    return this.tripsService.createTrip(user.id, data);
  }
}
