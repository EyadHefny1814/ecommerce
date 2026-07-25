import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'auth_colors.dart';

/// Row of six single-digit boxes for entering an OTP code.
/// Automatically advances focus forward on entry and backward on delete.
class OtpInputBoxes extends StatefulWidget {
  const OtpInputBoxes({
    super.key,
    this.length = 6,
    required this.onCompleted,
    this.onChanged,
  });

  final int length;

  /// Called with the full code once every box is filled.
  final ValueChanged<String> onCompleted;

  /// Called on every keystroke with the code entered so far.
  final ValueChanged<String>? onChanged;

  @override
  State<OtpInputBoxes> createState() => OtpInputBoxesState();
}

class OtpInputBoxesState extends State<OtpInputBoxes> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers =
        List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  /// Clears every box. Useful after a failed verification attempt.
  void clear() {
    for (final c in _controllers) {
      c.clear();
    }
    _focusNodes.first.requestFocus();
  }

  String get _code => _controllers.map((c) => c.text).join();

  void _onChanged(int index, String value) {
    if (value.isNotEmpty && index < widget.length - 1) {
      _focusNodes[index + 1].requestFocus();
    }
    widget.onChanged?.call(_code);
    if (_code.length == widget.length) {
      widget.onCompleted(_code);
    }
  }

  void _onKey(int index, KeyEvent event) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _controllers[index].text.isEmpty &&
        index > 0) {
      _focusNodes[index - 1].requestFocus();
      _controllers[index - 1].clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(widget.length, (index) {
        return SizedBox(
          width: 46,
          height: 56,
          child: KeyboardListener(
            focusNode: FocusNode(skipTraversal: true),
            onKeyEvent: (event) => _onKey(index, event),
            child: TextField(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 1,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: const TextStyle(
                color: AuthColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              decoration: InputDecoration(
                counterText: '',
                filled: true,
                fillColor: AuthColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AuthColors.surfaceBorder),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AuthColors.surfaceBorder),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: AuthColors.primary, width: 1.5),
                ),
              ),
              onChanged: (value) => _onChanged(index, value),
            ),
          ),
        );
      }),
    );
  }
}
