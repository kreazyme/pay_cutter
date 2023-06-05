// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive_flutter/hive_flutter.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;
import 'package:pay_cutter/common/helper/dio_helper.dart' as _i6;
import 'package:pay_cutter/data/datasource/firebase/firebase_auth.datasource.dart'
    as _i9;
import 'package:pay_cutter/data/datasource/local/user_local.datasource.dart'
    as _i13;
import 'package:pay_cutter/data/datasource/remote/category.datasource.dart'
    as _i4;
import 'package:pay_cutter/data/datasource/remote/chat.datasource.dart' as _i16;
import 'package:pay_cutter/data/datasource/remote/expense.datasource.dart'
    as _i7;
import 'package:pay_cutter/data/datasource/remote/group.datasource.dart'
    as _i10;
import 'package:pay_cutter/data/datasource/remote/user.datasource.dart' as _i12;
import 'package:pay_cutter/data/repository/auth_repo.dart' as _i15;
import 'package:pay_cutter/data/repository/category_repo.dart' as _i5;
import 'package:pay_cutter/data/repository/chat_repo.dart' as _i17;
import 'package:pay_cutter/data/repository/expense_repo.dart' as _i8;
import 'package:pay_cutter/data/repository/group_repo.dart' as _i11;
import 'package:pay_cutter/data/repository/user_repo.dart' as _i14;
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
  gh.lazySingleton<_i6.DioHelper>(() => _i6.DioHelper(
      userBox: gh<_i3.Box<dynamic>>(instanceName: 'divider_app_hive_box')));
  gh.lazySingleton<_i7.ExpenseDataSource>(
      () => _i7.ExpenseDataSource(dioHelper: gh<_i6.DioHelper>()));
  gh.lazySingleton<_i8.ExpenseRepository>(() =>
      _i8.ExpenseRepository(expenseDataSource: gh<_i7.ExpenseDataSource>()));
  gh.lazySingleton<_i9.FirebaseAuthDataSource>(
      () => _i9.FirebaseAuthDataSource());
  gh.lazySingleton<_i10.GroupDataSource>(
      () => _i10.GroupDataSource(dioHelper: gh<_i6.DioHelper>()));
  gh.lazySingleton<_i11.GroupRepository>(
      () => _i11.GroupRepository(groupDataSource: gh<_i10.GroupDataSource>()));
  gh.lazySingleton<_i12.UserDataSource>(
      () => _i12.UserDataSource(dioHelper: gh<_i6.DioHelper>()));
  gh.lazySingleton<_i13.UserLocalDatasource>(() => _i13.UserLocalDatasource(
        box: gh<_i3.Box<dynamic>>(instanceName: 'divider_app_hive_box'),
        dioHelper: gh<_i6.DioHelper>(),
      ));
  gh.lazySingleton<_i14.UserRepo>(() => _i14.UserRepo(
        userLocalDatasource: gh<_i13.UserLocalDatasource>(),
        userDataSource: gh<_i12.UserDataSource>(),
      ));
  gh.lazySingleton<_i15.AuthenRepo>(
      () => _i15.AuthenRepo(authDataSource: gh<_i9.FirebaseAuthDataSource>()));
  gh.lazySingleton<_i16.ChatDataSource>(
      () => _i16.ChatDataSource(dioHelper: gh<_i6.DioHelper>()));
  gh.lazySingleton<_i17.ChatRepository>(
      () => _i17.ChatRepository(chatDataSource: gh<_i16.ChatDataSource>()));
  return getIt;
}

class _$LocalModule extends _i18.LocalModule {}
