import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class AppEndpoints {
  static final String _apiURL = dotenv.env['BASE_URL'] ?? '';

  static String login = '$_apiURL/login';
}
