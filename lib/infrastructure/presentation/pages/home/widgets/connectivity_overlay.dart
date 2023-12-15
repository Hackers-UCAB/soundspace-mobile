import 'package:flutter/material.dart';

class ConnectivityOverlay {
  late OverlayEntry overlayEntry;
  bool _isVisible = false;
  ConnectivityOverlay() {
    overlayEntry = _createOverlayEntry();
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (_) => const Positioned(
          bottom: 0,
          child: Material(
            color: Color.fromARGB(255, 113, 126, 138),
            child: Dialog(child: Text('This is an overlay')),
          )),
    );
  }

  void show(BuildContext context) {
    Overlay.of(context).insert(overlayEntry);
  }

  void hide() {
    if (_isVisible) {
      overlayEntry.remove();
    }
  }
}
