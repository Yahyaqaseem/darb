import { Entity, Column, PrimaryGeneratedColumn, CreateDateColumn, UpdateDateColumn, ManyToOne, JoinColumn } from 'typeorm';
import { User } from '../../users/entities/user.entity';

@Entity('trips')
export class Trip {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @ManyToOne(() => User)
  @JoinColumn({ name: 'userId' })
  user: User;

  @Column()
  userId: string;

  @Column('float')
  distance: number; // in meters

  @Column('int')
  duration: number; // in seconds

  @Column('float')
  averageSpeed: number; // km/h

  @Column('float')
  trustedMaxSpeed: number; // km/h (filtered spikes)

  @Column('jsonb', { nullable: true })
  routeGeometry: any; // PostGIS LineString would be used here in prod

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;
}
