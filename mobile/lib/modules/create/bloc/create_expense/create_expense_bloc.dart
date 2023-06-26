import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pay_cutter/common/enum.dart';
import 'package:pay_cutter/common/extensions/datetime.extension.dart';
import 'package:pay_cutter/common/extensions/regex.dart';
import 'package:pay_cutter/data/datasource/firebase/firebase_upload.datasource.dart';
import 'package:pay_cutter/data/models/category.model.dart';
import 'package:pay_cutter/data/models/dto/expense.dto.dart';
import 'package:pay_cutter/data/models/expense.model.dart';
import 'package:pay_cutter/data/models/group.model.dart';
import 'package:pay_cutter/data/models/response/category/list_category_response.dart';
import 'package:pay_cutter/data/models/user/user.model.dart';
import 'package:pay_cutter/data/repository/category_repo.dart';
import 'package:pay_cutter/data/repository/expense_repo.dart';
import 'package:pay_cutter/data/repository/user_repo.dart';
import 'package:pay_cutter/modules/scan/barcode_painter.dart';
import 'package:tiengviet/tiengviet.dart';

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
    on<CreateExpenseTakePicture>(_takeImage);

    on<CreateExpenseCategorySubmit>(_categorySelect);
    on<CreateExpenseStarted>(_inital);
    on<CreateExpenseChangeAmount>(_changeAmount);
    on<CreateExpenseChangeLocation>(_changeLocation);

    on<CreateExpenseAddUser>(_addUser);
    on<CreateExpenseRemoveUser>(_removeuser);
  }

  final TextRecognizer _textRecognizer = TextRecognizer();
  bool _isBusy = false;
  bool _canProcess = true;

  CustomPaint? _customPaint;
  String? _text = '';

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
      final ListCategoryResponse response =
          await _categoryRepository.getCategories(
        event.groupModel.id.toString(),
      );
      emittter(state.copyWith(
        categories: response.data,
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

  void _changeLocation(
    CreateExpenseChangeLocation event,
    Emitter<CreateExpenseState> emittter,
  ) {
    emittter(state.copyWith(
      location: event.location,
      address: event.address,
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
      var data = event.data;
      if (state.location != null) {
        data = event.data.copyWith(
          lat: state.location?.latitude,
          lng: state.location?.longitude,
          address: state.address,
        );
      }
      ExpenseModel result = await _expenseRepository.createExpense(
        data.copyWith(
          paidBy: userId,
          categoryId: state.categorySelected!.id,
        ),
      );
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

  Future<void> _takeImage(
    CreateExpenseTakePicture event,
    Emitter<CreateExpenseState> emittter,
  ) async {
    emittter(
      state.copyWith(
        imageStatus: HandleStatus.loading,
      ),
    );

    try {
      File file = await _pickerImage(event, emittter);
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
      File file = await _pickerGallery(emittter);
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

  Future<File> _pickerGallery(
    Emitter<CreateExpenseState> emittter,
  ) async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        int? txtBill =
            await _scanImage(InputImage.fromFilePath(pickedFile.path));
        if (txtBill != null) {
          debugPrint('-------');
          emittter(state.copyWith(
            expenseAmount: txtBill,
          ));
          emittter(state.copyWith(
            expenseAmount: -1,
          ));
        }
        return File(pickedFile.path);
      }
      throw Exception('No image selected');
    } catch (e) {
      throw Exception('No image selected');
    }
  }

  Future<File> _pickerImage(
    CreateExpenseTakePicture event,
    Emitter<CreateExpenseState> emittter,
  ) async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        int? txtBill =
            await _scanImage(InputImage.fromFilePath(pickedFile.path));
        if (txtBill != null) {
          debugPrint('-------');
          emittter(state.copyWith(
            expenseAmount: txtBill,
          ));
          emittter(state.copyWith(
            expenseAmount: -1,
          ));
        }
        return File(pickedFile.path);
      }
      throw Exception('No image selected');
    } catch (e) {
      throw Exception('No image selected');
    }
  }

  Future<int?> _scanImage(InputImage inputImage) async {
    log('Start processing');
    if (!_canProcess) return null;
    if (_isBusy) return null;
    _isBusy = true;
    String? txtBill;
    // setState(() {
    //   _text = '';
    // });
    final recognizedText = await _textRecognizer.processImage(inputImage);
    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      log('start painted');
      final painter = TextRecognizerPainter(
        recognizedText,
        inputImage.inputImageData!.size,
        inputImage.inputImageData!.imageRotation,
      );
      _customPaint = CustomPaint(painter: painter);
    } else {
      recognizedText.blocks
          .sort((a, b) => a.boundingBox.top.compareTo(b.boundingBox.top));
      for (var element in recognizedText.blocks.reversed) {
        String vnText = TiengViet.parse(element.text);
        if (checkBill.hasMatch(vnText)) {
          log('------------------------');
          log(vnText);
          txtBill = recognizedText
              .blocks[recognizedText.blocks.indexOf(element) + 1].text;
        }
      }
      if (txtBill == null) {
        recognizedText.blocks
            .sort((a, b) => a.boundingBox.top.compareTo(b.boundingBox.top));
        for (var element in recognizedText.blocks.reversed) {
          String vnText = TiengViet.parse(element.text);
          if (recheckBill.hasMatch(vnText)) {
            log('------------------------');
            log(vnText);
            txtBill = recognizedText
                .blocks[recognizedText.blocks.indexOf(element) + 1].text;
          }
        }
      }
      _customPaint = null;
    }
    _isBusy = false;
    log('End processing');
    log('------------------------$txtBill');
    if (txtBill == null) return null;
    return int.tryParse(
        txtBill.replaceAll(',', '').replaceAll('.', '').replaceAll('C', '0'));
  }
}
