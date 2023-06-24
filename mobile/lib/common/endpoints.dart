abstract class AppEndpoints {
  static const String _apiURL = String.fromEnvironment('BASE_URL');

  static String login = '$_apiURL/login';

  static String user = '$_apiURL/users';

  static String group = '$_apiURL/groups';

  static String pushNoti = '$_apiURL/push';

  static String share = '$_apiURL/groups/join';

  static String expenses = '$_apiURL/expenses';

  static String expensesByGroup = '$_apiURL/expenses/group';

  static String joinGroup = '$_apiURL/groups/join';

  static String category = '$_apiURL/categories';
}
