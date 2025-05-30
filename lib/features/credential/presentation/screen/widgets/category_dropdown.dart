import 'package:flutter/material.dart';

import '../../../../../core/constants/category_constants.dart';
import '../../../domain/entities/category.dart';

class CategoryDropdown extends StatefulWidget {
  final Category? selectedCategory;
  final ValueChanged<Category> onChanged;

  const CategoryDropdown({
    super.key,
    this.selectedCategory,
    required this.onChanged,
  });

  @override
  State<CategoryDropdown> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  late Category? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.selectedCategory ?? (categories.isNotEmpty ? categories.first : null);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Category>(
      value: _selectedCategory,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).inputDecorationTheme.fillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
      isExpanded: true,
      items: categories.map((Category category) {
        return DropdownMenuItem<Category>(
          value: category,
          child: Text(category.name),
        );
      }).toList(),
      onChanged: (Category? newValue) {
        setState(() {
          _selectedCategory = newValue;
        });
        if (newValue != null) {
          widget.onChanged(newValue);
        }
      },
    );
  }
}

