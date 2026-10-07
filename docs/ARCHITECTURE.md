# DARB Architecture

## Mobile Client (Flutter)
- Feature-based modular architecture (`lib/features/*`)
- Shared core utilities (`lib/core/*`)
- Dependency Injection via `get_it` and `injectable`
- State Management via `flutter_bloc`
- Navigation via `go_router`

### Map Provider Abstraction
DARB abstracts its map engine so it can switch underlying technologies (e.g., `flutter_map` with vector tiles) without touching UI logic.

## Backend API (NestJS)
- Clean architecture with `Controller` -> `Service` -> `Repository`
- TypeORM / Prisma with PostGIS extension for spatial queries.
- WebSocket Gateway for realtime "Road Call" and "Driver proximity".

## Realtime Infrastructure
- **Redis** is used for presence tracking (who is on which road segment).
- **PostgreSQL/PostGIS** handles permanent geographic persistence (Road Reports, Fuel Stations, Places).
