import 'package:flutter/material.dart';
import 'package:pet_app/core/theme/color_schemes.dart';
import 'package:pet_app/core/extensions/context_extension.dart';
import 'package:rxdart/rxdart.dart';

class TextFieldWidget extends StatelessWidget {
  final _controller = TextEditingController();
  final Function(String) onSearch;
  final _searchSubject = PublishSubject<String>();

  void _debounceListener() {
    _searchSubject.stream
        .debounceTime(const Duration(milliseconds: 350))
        .listen((searchText) {
      onSearch(searchText);
    });
  }

  TextFieldWidget({
    required this.onSearch,
    super.key,
  }) {
    _debounceListener();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        hintText: context.translations.search,
        isDense: true,
        hintStyle: context.textTheme.labelMedium,
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
          borderSide: BorderSide(
            color: context.colorScheme.borderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
          borderSide: BorderSide(
            color: context.colorScheme.borderColor,
          ),
        ),
      ),
      onChanged: (String value) {
        _searchSubject.add(value);
      },
    );
  }
}
