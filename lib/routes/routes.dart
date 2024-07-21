import 'package:bus_ticket_booker_flutter/home/controller/bus_details_controller.dart';
import 'package:bus_ticket_booker_flutter/home/controller/home_controller.dart';
import 'package:bus_ticket_booker_flutter/home/view/bus_details_view.dart';
import 'package:bus_ticket_booker_flutter/home/view/home_view.dart';
import 'package:bus_ticket_booker_flutter/my_ticket/controller/my_ticket_controller.dart';
import 'package:bus_ticket_booker_flutter/my_ticket/view/my_tickets_view.dart';
import 'package:bus_ticket_booker_flutter/notifications/controller/notifications_controller.dart';
import 'package:bus_ticket_booker_flutter/notifications/view/notification_view.dart';
import 'package:bus_ticket_booker_flutter/profile/controller/profile_controller.dart';
import 'package:bus_ticket_booker_flutter/profile/view/profile_view.dart';
import 'package:bus_ticket_booker_flutter/sign_in/controller/signin_controller.dart';
import 'package:bus_ticket_booker_flutter/sign_in/view/sign_in_view.dart';
import 'package:bus_ticket_booker_flutter/signup/controller/signup_controller.dart';
import 'package:bus_ticket_booker_flutter/signup/view/create_account_view.dart';
import 'package:bus_ticket_booker_flutter/signup/view/signup_view.dart';
import 'package:bus_ticket_booker_flutter/splash/controller/splash_controller.dart';
import 'package:bus_ticket_booker_flutter/splash/view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppRoutes {
  static List<GetPage<dynamic>>? routes() => [
        GetPage(
          name: RoutesNames.splashView,
          page: () => const SplashView(),
          curve: Curves.easeInOut,
          transitionDuration: Durations.extralong1,
          transition: Transition.rightToLeft,
          bindings: [
            BindingsBuilder.put(
              () => SplashController(),
            ),
          ],
        ),
        GetPage(
          name: RoutesNames.signupView,
          page: () => const SignUpView(),
          curve: Curves.easeInOut,
          transitionDuration: Durations.extralong1,
          transition: Transition.rightToLeft,
          bindings: [
            BindingsBuilder.put(
              () => SignupController(),
            ),
          ],
        ),
        GetPage(
          name: RoutesNames.createAccountView,
          page: () => const CreateAccountView(),
          curve: Curves.easeInOut,
          transitionDuration: Durations.extralong1,
          transition: Transition.rightToLeft,
          bindings: [
            BindingsBuilder.put(
              () => SignupController(),
            ),
          ],
        ),
        GetPage(
          name: RoutesNames.signInView,
          page: () => const SignInView(),
          curve: Curves.easeInOut,
          transitionDuration: Durations.extralong1,
          transition: Transition.rightToLeft,
          bindings: [
            BindingsBuilder.put(
              () => SigninController(),
            ),
          ],
        ),
        GetPage(
          name: RoutesNames.myTicketView,
          page: () => const MyTicketsView(),
          curve: Curves.easeInOut,
          transitionDuration: Durations.extralong1,
          transition: Transition.rightToLeft,
          bindings: [
            BindingsBuilder.put(
              () => MyTicketController(),
            ),
          ],
        ),
        GetPage(
          name: RoutesNames.homeView,
          page: () => const HomeView(),
          curve: Curves.easeInOut,
          transitionDuration: Durations.extralong1,
          transition: Transition.rightToLeft,
          bindings: [
            BindingsBuilder.put(
              () => HomeController(),
            ),
          ],
        ),
        GetPage(
          name: RoutesNames.busDetailsView,
          page: () => const BusDetails(),
          curve: Curves.easeInOut,
          transitionDuration: Durations.extralong1,
          transition: Transition.rightToLeft,
          bindings: [
            BindingsBuilder.put(
              () => BusDetailsController(),
            ),
          ],
        ),
        GetPage(
          name: RoutesNames.notificationView,
          page: () => const Notificationview(),
          curve: Curves.easeInOut,
          transitionDuration: Durations.extralong1,
          transition: Transition.rightToLeft,
          bindings: [
            BindingsBuilder.put(
              () => NotificationsController(),
            ),
          ],
        ),
        GetPage(
          name: RoutesNames.profileView,
          page: () => const ProfileView(),
          curve: Curves.easeInOut,
          transitionDuration: Durations.extralong1,
          transition: Transition.rightToLeft,
          bindings: [
            BindingsBuilder.put(
              () => ProfileController(),
            ),
          ],
        ),
      ];
}

class RoutesNames {
  static const String splashView = '/';
  static const String signInView = '/signInView';
  static const String signupView = '/signupView';
  static const String createAccountView = '/createAccountView';
  static const String homeView = '/homeView';
  static const String myTicketView = '/myTicketView';
  static const String busDetailsView = '/busDetailsView';
  static const String notificationView = '/notificationView';
  static const String profileView = '/profileView';
}
