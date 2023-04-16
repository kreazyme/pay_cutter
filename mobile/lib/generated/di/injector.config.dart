// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive_flutter/hive_flutter.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;
import 'package:pay_cutter/common/helper/dio_helper.dart' as _i8;
import 'package:pay_cutter/data/datasource/firebase/firebase_auth.datasource.dart'
    as _i11;
import 'package:pay_cutter/data/datasource/local/user_local.datasource.dart'
    as _i15;
import 'package:pay_cutter/data/datasource/remote/category.datasource.dart'
    as _i4;
import 'package:pay_cutter/data/datasource/remote/chat.datasource.dart' as _i6;
import 'package:pay_cutter/data/datasource/remote/expense.datasource.dart'
    as _i9;
import 'package:pay_cutter/data/datasource/remote/group.datasource.dart'
    as _i12;
import 'package:pay_cutter/data/datasource/remote/user.datasource.dart' as _i14;
import 'package:pay_cutter/data/repository/auth_repo.dart' as _i17;
import 'package:pay_cutter/data/repository/category_repo.dart' as _i5;
import 'package:pay_cutter/data/repository/chat_repo.dart' as _i7;
import 'package:pay_cutter/data/repository/expense_repo.dart' as _i10;
import 'package:pay_cutter/data/repository/group_repo.dart' as _i13;
import 'package:pay_cutter/data/repository/user_repo.dart' as _i16;
import 'package:pay_cutter/generated/di/modules/local_modules.dart' as _i18;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
Future<_i1.GetIt> initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final localModule = _$LocalModule();
  await gh.lazySingletonAsync<_i3.Box<dynamic>>(
    () => localModule.appBox,
    instanceName: 'divider_app_hive_box',
    preResolve: true,
  );
  gh.lazySingleton<_i4.CategoryDataSource>(() => _i4.CategoryDataSource());
  gh.lazySingleton<_i5.CategoryRepository>(() =>
      _i5.CategoryRepository(categoryDataSource: gh<_i4.CategoryDataSource>()));
  gh.lazySingleton<_i6.ChatDataSource>(() => _i6.ChatDataSource());
  gh.lazySingleton<_i7.ChatRepository>(
      () => _i7.ChatRepository(chatDataSource: gh<_i6.ChatDataSource>()));
  gh.lazySingleton<_i8.DioHelper>(() => _i8.DioHelper(
      userBox: gh<_i3.Box<dynamic>>(instanceName: 'divider_app_hive_box')));
  gh.lazySingleton<_i9.ExpenseDataSource>(
      () => _i9.ExpenseDataSource(dioHelper: gh<_i8.DioHelper>()));
  gh.lazySingleton<_i10.ExpenseRepository>(() =>
      _i10.ExpenseRepository(expenseDataSource: gh<_i9.ExpenseDataSource>()));
  gh.lazySingleton<_i11.FirebaseAuthDataSource>(
      () => _i11.FirebaseAuthDataSource());
  gh.lazySingleton<_i12.GroupDataSource>(() => _i12.GroupDataSource());
  gh.lazySingleton<_i13.GroupRepository>(
      () => _i13.GroupRepository(groupDataSource: gh<_i12.GroupDataSource>()));
  gh.lazySingleton<_i14.UserDataSource>(() => _i14.UserDataSource());
  gh.lazySingleton<_i15.UserLocalDatasource>(() => _i15.UserLocalDatasource(
        box: gh<_i3.Box<dynamic>>(instanceName: 'divider_app_hive_box'),
        dioHelper: gh<_i8.DioHelper>(),
      ));
  gh.lazySingleton<_i16.UserRepo>(
      () => _i16.UserRepo(userLocalDatasource: gh<_i15.UserLocalDatasource>()));
  gh.lazySingleton<_i17.AuthenRepo>(
      () => _i17.AuthenRepo(authDataSource: gh<_i11.FirebaseAuthDataSource>()));
  return getIt;
}

class _$LocalModule extends _i18.LocalModule {}
