import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { FuelStation } from './entities/fuel-station.entity';

@Injectable()
export class FuelService {
  constructor(
    @InjectRepository(FuelStation)
    private fuelRepository: Repository<FuelStation>,
  ) {}

  async findAll(): Promise<FuelStation[]> {
    return this.fuelRepository.find();
  }

  // Find nearby stations (To be implemented using PostGIS ST_DWithin)
  async findNearby(lat: number, lng: number, radius: number = 5000): Promise<FuelStation[]> {
    // For now returning all stations. PostGIS query will replace this.
    return this.fuelRepository.find();
  }

  async updatePrices(id: string, prices: any[]): Promise<FuelStation> {
    const station = await this.fuelRepository.findOne({ where: { id } });
    if (!station) throw new Error('Station not found');
    
    station.fuelPrices = prices;
    station.priceUpdatedAt = new Date();
    return this.fuelRepository.save(station);
  }
}
