import 'package:equatable/equatable.dart';

class SearchResultEntity extends Equatable {
  final String title;

  const SearchResultEntity({required this.title});

  @override
  List<Object?> get props => [title];
}
