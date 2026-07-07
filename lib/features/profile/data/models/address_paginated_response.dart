import 'address_model.dart';

class AddressPaginatedResponse {
  final int? totalElements;
  final int? totalPages;
  final bool? first;
  final bool? last;
  final int? size;
  final List<AddressModel> content;
  final int? number;
  final int? numberOfElements;
  final bool? empty;

  const AddressPaginatedResponse({
    this.totalElements,
    this.totalPages,
    this.first,
    this.last,
    this.size,
    this.content = const [],
    this.number,
    this.numberOfElements,
    this.empty,
  });

  factory AddressPaginatedResponse.fromJson(Map<String, dynamic> json) {
    return AddressPaginatedResponse(
      totalElements: json['totalElements'] as int?,
      totalPages: json['totalPages'] as int?,
      first: json['first'] as bool?,
      last: json['last'] as bool?,
      size: json['size'] as int?,
      content: (json['content'] as List<dynamic>?)
              ?.map((e) =>
                  AddressModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      number: json['number'] as int?,
      numberOfElements: json['numberOfElements'] as int?,
      empty: json['empty'] as bool?,
    );
  }
}
