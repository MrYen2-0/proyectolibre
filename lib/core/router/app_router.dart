import 'package:go_router/go_router.dart';
import '../../features/reservations/presentation/pages/home_page.dart';
import '../../features/reservations/presentation/pages/reservations_list_page.dart';
import '../../features/reservations/presentation/pages/create_reservation_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/reservations',
        builder: (context, state) => const ReservationsListPage(),
      ),
      GoRoute(
        path: '/create-reservation',
        builder: (context, state) => const CreateReservationPage(),
      ),
    ],
  );
}