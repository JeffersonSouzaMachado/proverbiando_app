import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proverbiando/core/analytics/analytics_service.dart';
import 'package:proverbiando/core/analytics/firebase_analytics_service.dart';

final firebaseAnalyticsProvider = Provider<FirebaseAnalytics>((ref) {
  return FirebaseAnalytics.instance;
});

final analyticsServiceProvider = Provider<AnalyticsService>((ref) {
  final analytics = ref.watch(firebaseAnalyticsProvider);

  return FirebaseAnalyticsService(analytics);
});
