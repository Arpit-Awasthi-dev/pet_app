import 'package:flutter/material.dart';
import 'package:pet_app/core/extensions/context_extension.dart';
import 'package:pet_app/core/theme/color_schemes.dart';

class IconContainer extends StatelessWidget {
  final IconData iconData;
  final Color iconColor;
  final VoidCallback onClick;

  const IconContainer({
    required this.iconData,
    required this.iconColor,
    required this.onClick,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClick();
      },
      child: Container(
        height: 36,
        width: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: context.colorScheme.appBarIconColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          iconData,
          color: iconColor,
          size: 20,
        ),
      ),
    );
  }
}
