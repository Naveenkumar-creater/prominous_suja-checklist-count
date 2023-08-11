import 'package:equatable/equatable.dart';

class ChecklistStatusEntity extends Equatable {
  final int count;

  ChecklistStatusEntity({
    required this.count,
  });

  @override
  List<Object?> get props => [count];
}
