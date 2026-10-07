import { Entity, Column, PrimaryGeneratedColumn, CreateDateColumn, UpdateDateColumn, ManyToOne, JoinColumn } from 'typeorm';
import { User } from '../../users/entities/user.entity';

export enum ReportType {
  ACCIDENT = 'ACCIDENT',
  TRAFFIC = 'TRAFFIC',
  CLOSURE = 'CLOSURE',
  CHECKPOINT = 'CHECKPOINT',
  POTHOLE = 'POTHOLE',
  DANGER = 'DANGER',
  ROADWORKS = 'ROADWORKS',
}

export enum ReportStatus {
  ACTIVE = 'ACTIVE',
  CONFIRMED = 'CONFIRMED',
  EXPIRED = 'EXPIRED',
  RESOLVED = 'RESOLVED',
  DISPUTED = 'DISPUTED',
}

@Entity('reports')
export class Report {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @ManyToOne(() => User)
  @JoinColumn({ name: 'userId' })
  user: User;

  @Column()
  userId: string;

  @Column({ type: 'enum', enum: ReportType })
  type: ReportType;

  // Real app needs PostGIS Geometry Point
  @Column('float')
  lat: number;

  @Column('float')
  lng: number;

  @Column({ nullable: true })
  roadSegment: string;

  @Column({ default: 100 })
  confidence: number;

  @Column({ default: 0 })
  confirmations: number;

  @Column({ type: 'enum', enum: ReportStatus, default: ReportStatus.ACTIVE })
  status: ReportStatus;

  @Column({ nullable: true })
  expiration: Date;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;
}
