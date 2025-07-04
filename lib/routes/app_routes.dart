import 'package:debtgo_flutter/screens/register_screen.dart';
import 'package:debtgo_flutter/screens/welcome_screen.dart';
import 'package:debtgo_flutter/screens/notification_list_screen.dart';
import 'package:flutter/material.dart';
import '../screens/alerts_screen.dart';
import '../screens/budget_planning_screen.dart';
import '../screens/cancel_contract_screen.dart';
import '../screens/consultant_search_screen.dart';
import '../screens/editable_profile_screen.dart';
import '../screens/important_alerts_screen.dart';
import '../screens/income_expense_screen.dart';
import '../screens/payment_simulator_screen.dart';
import '../screens/rate_service_screen.dart';
import '../screens/request_status_notification_screen.dart';
import '../screens/service_comparison_screen.dart';
import '../screens/service_rating_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/home_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/login_screen.dart';
import '../screens/reviews_screen.dart';

class AppRoutes {
  static const String welcome = '/welcome';
  static const String splash = '/';
  static const String register = '/register';
  static const String login = '/login';
  static const String home = '/home';
  static const String consultantSearch = '/consultant-search';
  static const String serviceComparison = '/service-comparison';
  static const String requestStatusNotifications = '/request-status-notifications';
  static const String rateService = '/rate-service';
  static const String importantAlerts = '/important-alerts';
  static const String cancelContract = '/cancel-contract';
  static const String paymentSimulator = '/payment-simulator';
  static const String incomeExpense = '/income-expense';
  static const String budgetPlanning = '/budget-planning';
  static const String serviceRating = '/service-rating';
  static const String alerts = '/alerts';
  static const String profile = '/profile';
  static const String reviews = '/reviews';
  static const String reminders = '/reminders';
  static const String editableProfile = '/editable-profile';
  static const notifications = '/notifications';

  static Map<String, WidgetBuilder> routes = {
    welcome: (context) => const WelcomeScreen(),
    splash: (context) => const SplashScreen(),
    register: (context) => const RegisterScreen(),
    login: (context) => const LoginScreen(),
    home: (context) => const HomeScreen(),
    consultantSearch: (context) => const ConsultantSearchScreen(),
    serviceComparison: (context) => const ServiceComparisonScreen(),
    requestStatusNotifications: (context) => const RequestStatusNotificationScreen(),
    importantAlerts: (context) => const ImportantAlertsScreen(),
    rateService: (context) => const RateServiceScreen(),
    cancelContract: (context) => const CancelContractScreen(),
    paymentSimulator: (context) => const PaymentSimulatorScreen(),
    serviceRating: (context) => const ServiceRatingScreen(),
    alerts: (context) => const AlertsScreen(),
    budgetPlanning: (context) => const BudgetPlanningScreen(),
    incomeExpense: (context) => const IncomeExpenseScreen(),
    profile: (context) => const ProfileScreen(),
    reviews: (context) => const ReviewsScreen(),
    editableProfile: (context) => const EditableProfileScreen(),
    notifications: (_) => const NotificationListScreen()
  };
}

