import { Controller, Get, Query } from '@nestjs/common';
import { FuelService } from './fuel.service';

@Controller('v1/fuel')
export class FuelController {
  constructor(private readonly fuelService: FuelService) {}

  @Get()
  async getAll() {
    return this.fuelService.findAll();
  }

  @Get('nearby')
  async getNearby(@Query('lat') lat: number, @Query('lng') lng: number) {
    return this.fuelService.findNearby(lat, lng);
  }
}
