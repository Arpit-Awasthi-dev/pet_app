import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

removeFocus(BuildContext context) {
  FocusManager.instance.primaryFocus!.unfocus();
  SystemChannels.textInput.invokeMethod('TextInput.hide');
}

successToast({
  required VoidCallback onClose,
  required String message,
  Duration? duration,
  bool clickClose = false,
}) {
  BotToast.showCustomText(
    crossPage: true,
    clickClose: clickClose,
    backgroundColor: const Color(0x42000000),
    animationDuration: const Duration(milliseconds: 300),
    animationReverseDuration: const Duration(milliseconds: 200),
    duration: duration ?? const Duration(seconds: 2),
    onClose: () async {
      await Future.delayed(const Duration(milliseconds: 200));
      onClose();
    },
    toastBuilder: (_) {
      return _CustomMessageWidget(
        icon: Icons.check_circle,
        iconColor: Colors.green,
        text: message,
      );
    },
  );
}

class _CustomMessageWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;

  const _CustomMessageWidget({
    required this.icon,
    required this.text,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        elevation: 0,
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: iconColor),
              const Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
              Flexible(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 14,
                      ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
