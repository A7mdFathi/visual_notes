import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    this.hint,
    this.label,
    this.textType,
    this.onTextChange,
    this.suffixWidget,
    this.obsecureTxt = false,
    this.inputAction,
    this.initialValue,
    this.textEditingController,
    this.maxLines = 1,
    this.validator,
    this.errorTxt,
  }) : super(key: key);
  final String? label;
  final String? hint;
  final TextInputType? textType;
  final ValueChanged<String?>? onTextChange;
  final Widget? suffixWidget;
  final bool obsecureTxt;
  final FormFieldValidator<String?>? validator;
  final TextInputAction? inputAction;
  final String? initialValue;
  final int? maxLines;
  final String? errorTxt;
  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.85.sw,
      height: 0.09.sh,
      margin: EdgeInsets.only(
        bottom: 4.h,
      ),
      child: TextFormField(
        initialValue: initialValue,
        controller: textEditingController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        maxLines: maxLines,
        enableSuggestions: true,
        textInputAction: inputAction,
        // style: AppTextStyles.regular_14,
        decoration: InputDecoration(
          suffixIcon: suffixWidget,
          suffixIconConstraints: BoxConstraints.tight(
            Size(50.w, 0.06.sh),
          ),
          labelText: label,
          // labelStyle: AppTextStyles.regular_12,
          border: const OutlineInputBorder(
              // borderRadius: AppStyles.borderRadius12,
              ),
          errorMaxLines: 1,

          errorBorder: const OutlineInputBorder(
            // borderRadius: AppStyles.borderRadius12,
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          // errorStyle: AppTextStyles.regular_10.copyWith(color: AppColors.RED),
          contentPadding: EdgeInsets.all(12.r),
          disabledBorder: InputBorder.none,
          focusedBorder: const OutlineInputBorder(
              // borderSide: const BorderSide(
              //   color: AppColors.LIGHT_GREEN,
              // ),
              // borderRadius: AppStyles.borderRadius12,
              ),
          alignLabelWithHint: true,
          hintText: hint,
          isDense: true,
        ),
        // cursorColor: AppColors.LIGHT_GREEN,
        textAlignVertical: TextAlignVertical.bottom,
        keyboardType: textType,
        onChanged: onTextChange,

        obscureText: obsecureTxt,
        validator: validator,
      ),
    );
  }
}
