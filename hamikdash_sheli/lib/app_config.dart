import 'package:hamikdash_sheli/dataTypes/korban_case.dart';

class AppConfig {
  List<KorbanCase> korbanCases = [];

  // Use String.fromEnvironment to pull values during compilation
  // Use 'const' to allow for tree-shaking and better performance
  static const String calApiScheme = String.fromEnvironment(
    'CAL_API_SCHEME',
    defaultValue: 'https', // Fallback
  );

  static const String calApiHost = String.fromEnvironment(
    'CAL_API_HOST',
    defaultValue: 'https://api.production.com', // Fallback
  );

  static const String calApiPort = String.fromEnvironment(
    'CAL_API_PORT',
    defaultValue: '3000', // Fallback
  );

  static const String calApiTeamName = String.fromEnvironment(
    'CAL_API_TEAM_NAME',
    defaultValue: 'bet-hamikdash', // Fallback
  );

  static const String environment = String.fromEnvironment(
    'ENV',
    defaultValue: 'PROD',
  );

  static bool get isQA => environment == 'QA';
}

var appConfig = AppConfig();