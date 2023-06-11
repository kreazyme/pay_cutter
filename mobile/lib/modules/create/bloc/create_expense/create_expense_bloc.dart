import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pay_cutter/common/enum.dart';
import 'package:pay_cutter/common/extensions/datetime.extension.dart';
import 'package:pay_cutter/common/ultis/params_wrapper_ultis.dart';
import 'package:pay_cutter/data/datasource/firebase/firebase_upload.datasource.dart';
import 'package:pay_cutter/data/models/category.model.dart';
import 'package:pay_cutter/data/models/dto/expense.dto.dart';
import 'package:pay_cutter/data/models/expense.model.dart';
import 'package:pay_cutter/data/models/group.model.dart';
import 'package:pay_cutter/data/models/user/user.model.dart';
import 'package:pay_cutter/data/repository/category_repo.dart';
import 'package:pay_cutter/data/repository/expense_repo.dart';
import 'package:pay_cutter/data/repository/user_repo.dart';

part 'create_expense_event.dart';
part 'create_expense_state.dart';

class CreateExpenseBloc extends Bloc<CreateExpenseEvent, CreateExpenseState> {
  final ExpenseRepository _expenseRepository;
  final CategoryRepository _categoryRepository;
  final UserRepo _userRepo;
  final FirebaseUploadDataSoure _firebaseUploadDataSoure;
  CreateExpenseBloc({
    required ExpenseRepository expenseRepository,
    required CategoryRepository categoryRepository,
    required UserRepo userRepo,
    required FirebaseUploadDataSoure firebaseUploadDataSoure,
  })  : _expenseRepository = expenseRepository,
        _categoryRepository = categoryRepository,
        _userRepo = userRepo,
        _firebaseUploadDataSoure = firebaseUploadDataSoure,
        super(const CreateExpenseInitial()) {
    on<CreateExpenseSubmit>(_createExpense);
    on<CreateExpenseUploadFile>(_uploadFile);

    on<CreateExpenseCategorySubmit>(_categorySelect);
    on<CreateExpenseStarted>(_inital);
    on<CreateExpenseChangeAmount>(_changeAmount);

    on<CreateExpenseAddUser>(_addUser);
    on<CreateExpenseRemoveUser>(_removeuser);
  }

  Future<void> _inital(
    CreateExpenseStarted event,
    Emitter<CreateExpenseState> emittter,
  ) async {
    try {
      emittter(
        state.copyWith(
          categoryStatus: HandleStatus.loading,
          users: event.groupModel.participants,
        ),
      );
      final ParamsWrapper2<List<UserModel>, List<CategoryModel>> response =
          await _categoryRepository.getCategories(
        event.groupModel.id.toString(),
      );
      emittter(state.copyWith(
        categories: response.param2,
        categoryStatus: HandleStatus.success,
      ));
    } catch (e) {
      emittter(state.copyWith(
        status: HandleStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _changeAmount(
    CreateExpenseChangeAmount event,
    Emitter<CreateExpenseState> emittter,
  ) async {
    emittter(state.copyWith(
      amount: event.amount,
    ));
  }

  Future<void> _createExpense(
    CreateExpenseSubmit event,
    Emitter<CreateExpenseState> emittter,
  ) async {
    try {
      emittter(state.copyWith(
        status: HandleStatus.loading,
      ));
      int userId = (await _userRepo.getUser()).userID;
      ExpenseModel result =
          await _expenseRepository.createExpense(event.data.copyWith(
        paidBy: userId,
      ));
      emittter(state.copyWith(
        status: HandleStatus.success,
        expense: result,
      ));
    } catch (e) {
      emittter(
        state.copyWith(
          status: HandleStatus.error,
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> _categorySelect(
    CreateExpenseCategorySubmit event,
    Emitter<CreateExpenseState> emittter,
  ) async {
    emittter(
      state.copyWith(
        categorySelected: event.category,
        categories: state.categories ?? [],
      ),
    );
  }

  Future<void> _addUser(
    CreateExpenseAddUser event,
    Emitter<CreateExpenseState> emittter,
  ) async {
    List<int> userSelected = [...state.userSelected ?? [], event.index];
    emittter(
      state.copyWith(
        userSelected: userSelected,
      ),
    );
  }

  Future<void> _removeuser(
    CreateExpenseRemoveUser event,
    Emitter<CreateExpenseState> emittter,
  ) async {
    try {
      List<int> userSelected = state.userSelected!
          .where((element) => element != event.index)
          .toList();
      if (userSelected.isEmpty) {
        throw Exception('At least one user must be selected');
      }
      emittter(
        state.copyWith(
          userSelected: userSelected,
        ),
      );
    } catch (e) {
      emittter(
        state.copyWith(
          error: 'At least one user must be selected',
          status: HandleStatus.error,
        ),
      );
      emittter(
        state.copyWith(
          error: null,
          status: HandleStatus.initial,
        ),
      );
    }
  }

  Future<void> _uploadFile(
    CreateExpenseUploadFile event,
    Emitter<CreateExpenseState> emittter,
  ) async {
    emittter(
      state.copyWith(
        imageStatus: HandleStatus.loading,
      ),
    );

    try {
      File file = await _pickerImage();
      String path = 'expense.${event.groupId}.${DateTime.now().toPathString}';
      String url = await _firebaseUploadDataSoure.uploadImage(
        file,
        path,
      );
      debugPrint('url: $url');
      emittter(
        state.copyWith(
          imageUrl: url,
          imageStatus: HandleStatus.success,
        ),
      );
    } catch (e) {
      emittter(
        state.copyWith(
          imageStatus: HandleStatus.error,
          error: e.toString(),
        ),
      );
    }
  }

  Future<File> _pickerImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        return File(pickedFile.path);
      }
      throw Exception('No image selected');
    } catch (e) {
      throw Exception('No image selected');
    }
  }
}
