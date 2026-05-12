import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:proverbiando/core/analytics/analytics_service.dart';

class FirebaseAnalyticsService implements AnalyticsService {
  final FirebaseAnalytics analytics;

  FirebaseAnalyticsService(this.analytics);

  @override
  Future<void> logEvent(String name, {Map<String, Object>? parameters}) async {
    await analytics.logEvent(name: name, parameters: parameters);
  }

  @override
  Future<void> logScreenView(String screenName) async {
    await analytics.logScreenView(screenName: screenName);
  }
}
