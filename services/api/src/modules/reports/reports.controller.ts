import { Controller, Get, Post, Param, Body, UseGuards } from '@nestjs/common';
import { ReportsService } from './reports.service';
import { JwtAuthGuard } from '../../common/guards/jwt-auth.guard';
import { CurrentUser } from '../../common/decorators/current-user.decorator';
import { User } from '../users/entities/user.entity';

@Controller('v1/reports')
export class ReportsController {
  constructor(private readonly reportsService: ReportsService) {}

  @Get()
  async getActive() {
    return this.reportsService.getActiveReports();
  }

  @Post()
  @UseGuards(JwtAuthGuard)
  async createReport(@CurrentUser() user: User, @Body() data: any) {
    return this.reportsService.create(user.id, data);
  }

  @Post(':id/confirm')
  @UseGuards(JwtAuthGuard)
  async confirmReport(@Param('id') id: string, @CurrentUser() user: User) {
    return this.reportsService.confirmReport(id, user.id);
  }
}
