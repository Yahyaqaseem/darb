import { Module } from '@nestjs/common';
import { RoadCallService } from './road-call.service';
import { RoadCallGateway } from './road-call.gateway';

@Module({
  providers: [RoadCallService, RoadCallGateway],
  exports: [RoadCallService],
})
export class RoadCallModule {}
