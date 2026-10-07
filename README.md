# DARB دَرْب - Production-Grade Navigation Platform

This repository contains the full source code for DARB, a complete cross-platform navigation, road intelligence, and driver community platform.

## Architecture
- **Client**: Flutter (targeting iOS, Android, Windows Desktop)
- **Backend**: NestJS (Node.js)
- **Database**: PostgreSQL with PostGIS
- **Cache & Queues**: Redis
- **Realtime**: WebSockets

## Prerequisites
- Flutter SDK (>= 3.4.0)
- Node.js (>= 20)
- Docker & Docker Compose
- CocoaPods (for iOS build on macOS)

## How to Run

1. **Environment Setup**
   ```bash
   cp .env.example .env
   ```

2. **Start Infrastructure (DB + Redis)**
   ```bash
   docker compose up -d
   ```

3. **Start API Server**
   ```bash
   cd services/api
   npm install
   npm run start:dev
   ```

4. **Run Mobile App**
   ```bash
   cd apps/mobile
   flutter pub get
   flutter run
   ```

## Documentation
See the `docs/` folder for comprehensive documentation on Architecture, Map Engine, Road Call feature, and more.
