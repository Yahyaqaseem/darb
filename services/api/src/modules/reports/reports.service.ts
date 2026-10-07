import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Report, ReportStatus } from './entities/report.entity';

@Injectable()
export class ReportsService {
  constructor(
    @InjectRepository(Report)
    private reportRepository: Repository<Report>,
  ) {}

  async create(userId: string, data: Partial<Report>): Promise<Report> {
    const report = this.reportRepository.create({
      ...data,
      userId,
      expiration: new Date(Date.now() + 2 * 60 * 60 * 1000), // Expires in 2 hours
    });
    return this.reportRepository.save(report);
  }

  async getActiveReports(): Promise<Report[]> {
    return this.reportRepository.find({
      where: [
        { status: ReportStatus.ACTIVE },
        { status: ReportStatus.CONFIRMED },
      ],
    });
  }

  async confirmReport(id: string, userId: string): Promise<Report> {
    const report = await this.reportRepository.findOne({ where: { id } });
    if (!report) throw new NotFoundException('Report not found');
    
    // In real app, check idempotency so a user can't confirm twice
    report.confirmations += 1;
    report.confidence = Math.min(100, report.confidence + 10);
    if (report.confirmations > 5) {
      report.status = ReportStatus.CONFIRMED;
    }
    
    return this.reportRepository.save(report);
  }
}
