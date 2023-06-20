import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/common/enum.dart';
import 'package:pay_cutter/data/datasource/remote/category.datasource.dart';
import 'package:pay_cutter/data/models/category.model.dart';

part 'create_category_event.dart';
part 'create_category_state.dart';

class CreateCategoryBloc
    extends Bloc<CreateCategoryEvent, CreateCategoryState> {
  CreateCategoryBloc({
    required CategoryDataSource categoryDataSource,
  })  : _categoryDataSource = categoryDataSource,
        super(const CreateCategoryInitial()) {
    on<CreateCategorySubmit>(_submitCategory);
  }

  final CategoryDataSource _categoryDataSource;

  Future<void> _submitCategory(
    CreateCategorySubmit event,
    Emitter<CreateCategoryState> emitter,
  ) async {
    try {
      emitter(const CreateCategoryChangeStatus(status: HandleStatus.loading));
      CategoryModel category = await _categoryDataSource.createCategory(
        event.name,
        event.description,
        event.groupId,
      );
      emitter(
        CreateCategorySuccess(
          category: category,
        ),
      );
    } catch (_) {
      emitter(const CreateCategoryChangeStatus(status: HandleStatus.error));
    }
  }
}
