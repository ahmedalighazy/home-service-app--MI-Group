import 'package:equatable/equatable.dart';

class SearchResultEntity extends Equatable {
  final String id;
  final String title;

  const SearchResultEntity({required this.id, required this.title});

  @override
  List<Object?> get props => [id, title];
}
