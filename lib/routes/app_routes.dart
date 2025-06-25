import 'package:debtgo_flutter/screens/register_screen.dart';
import 'package:debtgo_flutter/screens/welcome_screen.dart';
import 'package:debtgo_flutter/screens/notification_list_screen.dart';
import 'package:flutter/material.dart';
import '../screens/add_debt_screen.dart';
import '../screens/editable_profile_screen.dart';
import '../screens/messages_screen.dart';
import '../screens/payment_history_screen.dart';
import '../screens/plan_selection_screen.dart';
import '../screens/projection_screen.dart';
import '../screens/reminders_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/home_screen.dart';
import '../screens/entrepreneurs_screen.dart';
import '../screens/debt_management_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/login_screen.dart';
import '../screens/reviews_screen.dart';

class AppRoutes {
  static const String welcome = '/welcome';
  static const String splash = '/';
  static const String register = '/register';
  static const String login = '/login';
  static const String home = '/home';
  static const String entrepreneurs = '/entrepreneurs';
  static const String debtManagement = '/debt-management';
  static const String profile = '/profile';
  static const String reviews = '/reviews';
  static const String messages = '/messages';
  static const String planSelection = '/plan-selection';
  static const String addDebt = '/add-debt';
  static const String paymentHistory = '/payment-history';
  static const String reminders = '/reminders';
  static const String projection = '/projection';
  static const String editableProfile = '/editable-profile';
  static const notifications = '/notifications';

  static Map<String, WidgetBuilder> routes = {
    welcome: (context) => const WelcomeScreen(),
    splash: (context) => const SplashScreen(),
    register: (context) => const RegisterScreen(),
    login: (context) => const LoginScreen(),
    home: (context) => const HomeScreen(),
    entrepreneurs: (context) => const EntrepreneursScreen(),
    debtManagement: (context) => const DebtManagementScreen(),
    profile: (context) => const ProfileScreen(),
    reviews: (context) => const ReviewsScreen(),
    messages: (context) => const MessagesScreen(),
    planSelection: (context) => const PlanSelectionScreen(),
    addDebt: (context) => const AddDebtScreen(),
    paymentHistory: (context) => const PaymentHistoryScreen(),
    reminders: (context) => const RemindersScreen(),
    projection: (context) => const ProjectionScreen(),
    editableProfile: (context) => const EditableProfileScreen(),
    notifications: (_) => const NotificationListScreen()
  };
}
