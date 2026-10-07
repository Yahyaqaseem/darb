import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { FuelService } from './fuel.service';
import { FuelController } from './fuel.controller';
import { FuelStation } from './entities/fuel-station.entity';

@Module({
  imports: [TypeOrmModule.forFeature([FuelStation])],
  controllers: [FuelController],
  providers: [FuelService],
  exports: [FuelService],
})
export class FuelModule {}
