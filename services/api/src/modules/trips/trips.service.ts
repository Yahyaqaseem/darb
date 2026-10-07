import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Trip } from './entities/trip.entity';

@Injectable()
export class TripsService {
  constructor(
    @InjectRepository(Trip)
    private tripRepository: Repository<Trip>,
  ) {}

  async createTrip(userId: string, data: Partial<Trip>): Promise<Trip> {
    const trip = this.tripRepository.create({ ...data, userId });
    return this.tripRepository.save(trip);
  }

  async getUserTrips(userId: string): Promise<Trip[]> {
    return this.tripRepository.find({
      where: { userId },
      order: { createdAt: 'DESC' },
    });
  }
}
