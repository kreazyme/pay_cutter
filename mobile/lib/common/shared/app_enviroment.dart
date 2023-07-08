// ignore_for_file: non_constant_identifier_names

class AppEnviroment {
  static String API_URL = const String.fromEnvironment('BASE_URL');
  static String MAP_URL = const String.fromEnvironment('MAP_URL');
  static String MAP_KEY = const String.fromEnvironment('MAP_KEY');
}
