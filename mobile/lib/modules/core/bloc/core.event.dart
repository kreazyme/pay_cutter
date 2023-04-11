part of 'core.bloc.dart';

class CoreEvent extends Equatable {
  const CoreEvent();

  @override
  List<Object?> get props => [];
}

class CoreBottomChange extends CoreEvent {
  final int index;

  const CoreBottomChange(this.index);

  @override
  List<Object?> get props => [
        index,
      ];
}
