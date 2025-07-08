import 'package:debtgo_flutter/screens/accept_request_screen.dart';
import 'package:debtgo_flutter/screens/advice_request_list_screen.dart';
import 'package:debtgo_flutter/screens/register_screen.dart';
import 'package:debtgo_flutter/screens/start_request_screen.dart';
import 'package:debtgo_flutter/screens/welcome_screen.dart';
import 'package:debtgo_flutter/screens/notification_list_screen.dart';
import 'package:flutter/material.dart';
import '../screens/alerts_screen.dart';
import '../screens/budget_planning_screen.dart';
import '../screens/cancel_contract_screen.dart';
import '../screens/entrepreneur_search_screen.dart';
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
import 'package:debtgo_flutter/screens/entrepreneur_services_screen.dart';
import '../screens/login_screen.dart';
import '../screens/reviews_screen.dart';
import 'package:debtgo_flutter/screens/performance_metrics_screen.dart';

class AppRoutes {
  static const String welcome = '/welcome';
  static const String splash = '/';
  static const String register = '/register';
  static const String login = '/login';
  static const String home = '/home';
  static const String entrepreneurSearch = '/entrepreneur-search';
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
  static const String notifications = '/notifications';
  static const String startRequest = '/start-request';
  static const String acceptRequest = '/accept-request';
  static const String entrepreneurServices = '/entrepreneur-services';
  static const String performanceMetrics = '/performance-metrics';
  static const String adviceRequestListScreen = '/advice-request-list-screen';

  static Map<String, WidgetBuilder> routes = {
    welcome: (context) => const WelcomeScreen(),
    splash: (context) => const SplashScreen(),
    register: (context) => const RegisterScreen(),
    login: (context) => const LoginScreen(),
    home: (context) => const HomeScreen(),
    entrepreneurSearch: (context) => const EntrepreneurSearchScreen(),
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
    notifications: (context) => const NotificationListScreen(),
    startRequest: (context) => StartRequestScreen(),
    acceptRequest: (context) => const AcceptRequestScreen(),
    entrepreneurServices: (context) => const EntrepreneurServicesScreen(),
    performanceMetrics: (context) => const PerformanceMetricsScreen(),
    adviceRequestListScreen: (context) => const AdviceRequestListScreen()
  };
}