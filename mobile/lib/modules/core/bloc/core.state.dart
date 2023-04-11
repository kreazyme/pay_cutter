part of 'core.bloc.dart';

class CoreState extends Equatable {
  final int indexBottom;

  const CoreState(this.indexBottom);

  const CoreState.initial() : indexBottom = 0;

  @override
  List<Object?> get props => [
        indexBottom,
      ];
}
