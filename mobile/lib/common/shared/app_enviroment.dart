// ignore_for_file: non_constant_identifier_names

import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnviroment {
  static String API_URL = dotenv.env['BASE_URL'] ?? '';
}
