import 'package:flutter/material.dart';
import 'package:pay_cutter/common/ultis/params_wrapper_ultis.dart';
import 'package:pay_cutter/data/models/category.model.dart';
import 'package:pay_cutter/data/models/expense.model.dart';
import 'package:pay_cutter/data/models/group.model.dart';
import 'package:pay_cutter/data/models/user/user.model.dart';
import 'package:pay_cutter/modules/analysis/analysis.page.dart';
import 'package:pay_cutter/modules/chat/detail_chat.page.dart';
import 'package:pay_cutter/modules/chat/participant.page.dart';
import 'package:pay_cutter/modules/chat/share_chat.page.dart';
import 'package:pay_cutter/modules/core/core.page.dart';
import 'package:pay_cutter/modules/create/create_category.page.dart';
import 'package:pay_cutter/modules/create/create_expense.page.dart';
import 'package:pay_cutter/modules/create/create_group.page.dart';
import 'package:pay_cutter/modules/create/widgets/expense/pick_location.page.dart';
import 'package:pay_cutter/modules/create/widgets/expense/select_category.page.dart';
import 'package:pay_cutter/modules/feedback/about_us.page.dart';
import 'package:pay_cutter/modules/feedback/feedback.page.dart';
import 'package:pay_cutter/modules/login/login_page.dart';
import 'package:pay_cutter/modules/onboard/onboard_page.dart';
import 'package:pay_cutter/modules/qr_scan/qr_scan.page.dart';
import 'package:pay_cutter/modules/scan/scan.page.dart';
import 'package:pay_cutter/modules/splash/splash.page.dart';
import 'package:pay_cutter/modules/chat/chat.page.dart';

abstract class AppRouters {
  static const core = '/core';
  static const login = '/login';
  static const onBoarding = '/onBoarding';
  static const register = '/register';
  static const splash = '/splash';
  static const analysis = '/analysis';
  static const chat = '/chat';
  static const detail = '/detail';
  static const shareChat = '/share_chat';
  static const createExpense = '/create_expense';
  static const createCategory = '/create_category';
  static const qrScan = '/qr_scan';
  static const createGroup = '/create_group';
  static const String scanBill = '/scan_bill';
  static const String participants = '/participants';
  static const String categoryPage = '/category_page';
  static const String feedback = '/feedback';
  static const String aboutUs = '/about_us';
  static const String pickLocation = '/pick_location';

  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => const SplashPage(),
        );
      case core:
        return MaterialPageRoute(
          builder: (_) => const CorePage(),
        );
      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        );
      case onBoarding:
        return MaterialPageRoute(
          builder: (_) => const OnBoardingPage(),
        );
      case register:
        return MaterialPageRoute(
          builder: (_) => const Placeholder(),
        );
      case analysis:
        return MaterialPageRoute(
          builder: (_) => const AnalysisPage(),
        );
      case chat:
        ParamsWrapper2<GroupModel, bool> params =
            settings.arguments as ParamsWrapper2<GroupModel, bool>;
        return MaterialPageRoute(
          builder: (_) => ChatPage(
            params: params,
          ),
        );
      case detail:
        ParamsWrapper2<GroupModel?, List<ExpenseModel>> params = settings
            .arguments as ParamsWrapper2<GroupModel?, List<ExpenseModel>>;
        return MaterialPageRoute(
          builder: (_) => DetailChatPage(
            group: params.param1!,
            expenses: params.param2,
          ),
        );
      case shareChat:
        int id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => ShareChat(
            id: id,
          ),
        );
      case createExpense:
        GroupModel group = settings.arguments as GroupModel;
        return MaterialPageRoute(
          builder: (_) => CreateExpensePage(group: group),
        );
      case createCategory:
        int groupId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => CreateCategoryPage(
            groupId: groupId,
          ),
        );
      case qrScan:
        return MaterialPageRoute(
          builder: (_) => const QRScanPage(),
        );
      case createGroup:
        return MaterialPageRoute(
          builder: (_) => const CreateGroupPage(),
        );

      case scanBill:
        return MaterialPageRoute(
          builder: (_) => const ScanPage(),
        );
      case participants:
        List<UserModel> users = settings.arguments as List<UserModel>;
        return MaterialPageRoute(
          builder: (_) => ParticipantsPage(
            users: users,
          ),
        );
      case categoryPage:
        ParamsWrapper2<int, List<CategoryModel>> params =
            settings.arguments as ParamsWrapper2<int, List<CategoryModel>>;
        return MaterialPageRoute(
          builder: (context) => SelectCategoryPage(
            listCategory: params.param2,
            groupId: params.param1,
          ),
        );
      case feedback:
        return MaterialPageRoute(
          builder: (_) => const FeedbackPage(),
        );
      case aboutUs:
        return MaterialPageRoute(
          builder: (_) => AboutUsPage(),
        );
      case pickLocation:
        return MaterialPageRoute(
          builder: (_) => const PickLocationPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Placeholder(),
        );
    }
  }
}
