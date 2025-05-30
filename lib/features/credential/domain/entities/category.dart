import 'package:equatable/equatable.dart';

/// Represents a category with an ID and a name.
/// Extends Equatable to enable value equality comparison.
class Category extends Equatable {
  final String id;
  final String name;

  /// Constructor for initializing Category with required fields.
  const Category({
    required this.id,
    required this.name,
  });

  /// Serializes this Category instance into a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  /// Factory constructor to create a Category from a JSON map.
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }

  /// Override props to support Equatable value comparison.
  @override
  List<Object?> get props => [id, name];
}
