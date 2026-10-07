import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { UsersModule } from './modules/users/users.module';
import { AuthModule } from './modules/auth/auth.module';
import { RoadCallModule } from './modules/road-call/road-call.module';
import { FuelModule } from './modules/fuel/fuel.module';
import { ReportsModule } from './modules/reports/reports.module';
import { TripsModule } from './modules/trips/trips.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    TypeOrmModule.forRootAsync({
      imports: [ConfigModule],
      inject: [ConfigService],
      useFactory: (configService: ConfigService) => ({
        type: 'postgres',
        host: configService.get<string>('DB_HOST', 'localhost'),
        port: configService.get<number>('DB_PORT', 5432),
        username: configService.get<string>('DB_USER', 'darb_user'),
        password: configService.get<string>('DB_PASS', 'darb_password'),
        database: configService.get<string>('DB_NAME', 'darb_db'),
        autoLoadEntities: true,
        synchronize: true, // TODO: Use migrations in production
      }),
    }),
    UsersModule,
    AuthModule,
    RoadCallModule,
    FuelModule,
    ReportsModule,
    TripsModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
