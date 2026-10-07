import { Entity, Column, PrimaryGeneratedColumn, CreateDateColumn, UpdateDateColumn } from 'typeorm';

export enum CrowdStatus {
  EMPTY = 'غير مزدحمة',
  MEDIUM = 'متوسطة',
  CROWDED = 'مزدحمة',
  UNKNOWN = 'غير معروف',
}

@Entity('fuel_stations')
export class FuelStation {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column()
  name: string;

  // In production with PostGIS, this should use geometry(Point, 4326)
  // Using simple lat/lng for boilerplate simplicity
  @Column('float')
  lat: number;

  @Column('float')
  lng: number;

  @Column('jsonb')
  fuelPrices: { type: string; price: number; currency: string }[];

  @Column()
  priceUpdatedAt: Date;

  @Column({ type: 'enum', enum: CrowdStatus, default: CrowdStatus.UNKNOWN })
  crowdStatus: CrowdStatus;

  @Column({ default: false })
  isVerified: boolean;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;
}
