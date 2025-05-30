import 'package:equatable/equatable.dart';

class Category extends Equatable{
  final String id;
  final String name;

  const Category({
    required this.id,
    required this.name,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }

  @override
  List<Object?> get props => [id,name];
}