import 'package:go_router/go_router.dart';
import '../../features/map/presentation/screens/map_screen.dart';
import 'main_layout.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MainLayout(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const MapScreen(),
        ),
      ],
    ),
  ],
);
