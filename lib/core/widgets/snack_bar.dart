import 'package:flutter/material.dart';

class AppSnackBars {
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  static void hideSnackBar() {
    scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
  }

  static void error({required String message, Widget? icon}) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              width: scaffoldMessengerKey.currentContext!.size!.width / 1.85,
              child: Wrap(
                children: [
                  Text(
                    message,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            IconButton(onPressed: hideSnackBar, icon: icon ?? const Icon(Icons.cancel, color: Colors.white)),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(24),
        padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  static void noInternet({required String message, required String message2, Widget? icon}) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              width: scaffoldMessengerKey.currentContext!.size!.width / 1.85,
              child: Wrap(
                children: [
                  Text(
                    '$message $message2',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
            icon ?? const Icon(Icons.cancel, color: Colors.grey),
          ],
        ),
        backgroundColor: Colors.white,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  static void success({required String message, Widget? icon}) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: scaffoldMessengerKey.currentContext!.size!.width / 1.85,
              child: Wrap(
                children: [
                  Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            icon ?? const Icon(Icons.check),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
