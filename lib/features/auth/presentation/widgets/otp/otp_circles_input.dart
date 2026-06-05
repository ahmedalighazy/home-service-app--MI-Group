import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/themes/colors/app_colors.dart';

class OtpCirclesInput extends StatefulWidget {
  final int length;
  final ValueChanged<String> onCompleted;
  final ValueChanged<String>? onChanged;

  const OtpCirclesInput({
    super.key,
    this.length = 4,
    required this.onCompleted,
    this.onChanged,
  });

  @override
  State<OtpCirclesInput> createState() => _OtpCirclesInputState();
}

class _OtpCirclesInputState extends State<OtpCirclesInput> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.length,
      (_) => TextEditingController(),
    );
    _focusNodes = List.generate(
      widget.length,
      (_) => FocusNode(),
    );

    // Listen to all controllers
    for (int i = 0; i < widget.length; i++) {
      _controllers[i].addListener(() => _onTextChanged(i));
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onTextChanged(int index) {
    final text = _controllers[index].text;

    if (text.isNotEmpty) {
      // Move to next field
      if (index < widget.length - 1) {
        _focusNodes[index + 1].requestFocus();
      } else {
        // Last field - unfocus and trigger completion
        _focusNodes[index].unfocus();
        _checkCompletion();
      }
    }

    // Notify parent of change
    if (widget.onChanged != null) {
      widget.onChanged!(_getOtpCode());
    }

    setState(() {}); // Refresh UI
  }

  void _checkCompletion() {
    final code = _getOtpCode();
    if (code.length == widget.length) {
      widget.onCompleted(code);
    }
  }

  String _getOtpCode() {
    return _controllers.map((c) => c.text).join();
  }

  void clear() {
    for (var controller in _controllers) {
      controller.clear();
    }
    _focusNodes[0].requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          widget.length,
          (index) => _buildOtpCircle(index),
        ),
      ),
    );
  }

  Widget _buildOtpCircle(int index) {
    final isFocused = _focusNodes[index].hasFocus;
    final hasValue = _controllers[index].text.isNotEmpty;

    return Container(
      width: 64.w,
      height: 64.w,
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: hasValue ? AppColors.greenPrimary.withValues(alpha: 0.1) : AppColors.light,
        border: Border.all(
          color: isFocused
              ? AppColors.greenPrimary
              : hasValue
                  ? AppColors.greenPrimary.withValues(alpha: 0.5)
                  : AppColors.borderInputs,
          width: isFocused ? 2 : 1.5,
        ),
        boxShadow: isFocused
            ? [
                BoxShadow(
                  color: AppColors.greenPrimary.withValues(alpha: 0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: ClipOval(
        child: TextFormField(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.greenPrimary,
          ),
          decoration: const InputDecoration(
            counterText: '',
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          onChanged: (value) {
            if (value.isEmpty && index > 0) {
              // Move back on delete
              _focusNodes[index - 1].requestFocus();
            }
          },
        ),
      ),
    );
  }
}
