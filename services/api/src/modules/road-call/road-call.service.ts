import { Injectable } from '@nestjs/common';

@Injectable()
export class RoadCallService {
  // Temporary in-memory map for road segments.
  // In production, Redis will be used for distributed caching.
  private roadSegments = new Map<string, { drivers: number; reports: any[] }>();

  joinSegment(segmentId: string, clientId: string) {
    if (!this.roadSegments.has(segmentId)) {
      this.roadSegments.set(segmentId, { drivers: 0, reports: [] });
    }
    const segment = this.roadSegments.get(segmentId);
    segment.drivers++;
    return segment.drivers;
  }

  leaveSegment(segmentId: string, clientId: string) {
    if (this.roadSegments.has(segmentId)) {
      const segment = this.roadSegments.get(segmentId);
      segment.drivers--;
      if (segment.drivers <= 0) {
        this.roadSegments.delete(segmentId);
        return 0;
      }
      return segment.drivers;
    }
    return 0;
  }

  getDriverCount(segmentId: string): number {
    return this.roadSegments.get(segmentId)?.drivers || 0;
  }
}
