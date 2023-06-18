import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class AppEndpoints {
  static final String _apiURL = dotenv.env['BASE_URL'] ?? '';

  static String login = '$_apiURL/login';

  static String user = '$_apiURL/users';

  static String group = '$_apiURL/groups';

  static String share = '$_apiURL/groups/join';

  static String expenses = '$_apiURL/expenses';

  static String expensesByGroup = '$_apiURL/expenses/group';

  static String joinGroup = '$_apiURL/groups/join';

  static String category = '$_apiURL/categories';
}
