import 'package:get/get.dart';
import 'package:polling_app/views/auth/register_view.dart';
import 'package:polling_app/views/instructor/create_poll_view.dart'
    show CreatePollView;
import 'package:polling_app/views/instructor/instructor_view.dart';
import 'package:polling_app/views/instructor/poll_details_view.dart';
import 'package:polling_app/views/student/join_poll_view.dart';
import 'package:polling_app/views/student/student_poll_view.dart';
import 'package:polling_app/views/student/student_view.dart';
import '../views/splash/splash_view.dart';
import 'app_routes.dart';
import '../views/auth/login_view.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.splash, page: () => const SplashView()),
    GetPage(name: AppRoutes.login, page: () => LoginView()),
    GetPage(name: AppRoutes.register, page: () => RegisterView()),
    GetPage(name: AppRoutes.student, page: () => StudentView()),
    GetPage(name: AppRoutes.instructor, page: () => InstructorView()),
    GetPage(name: AppRoutes.joinPoll, page: () => JoinPollView()),
    GetPage(name: AppRoutes.createPoll, page: () => CreatePollView()),
    GetPage(name: AppRoutes.pollDetails, page: () => PollDetailsView()),
    GetPage(
 name: AppRoutes.studentPoll,
 page: () => StudentPollView(),
),

  ];
}
