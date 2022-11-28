import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';

class AnalyticsProvider with ChangeNotifier {
  FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics.instance;
}
