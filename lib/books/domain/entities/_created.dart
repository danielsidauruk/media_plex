import 'package:equatable/equatable.dart';

class Created extends Equatable{
  const Created({
    required this.type,
    required this.value,
  });

  final String type;
  final DateTime value;

  @override
  List<Object?> get props => [type, value];
}