// ignore_for_file: prefer_const_constructors


import '../../utils/colors.dart';
import '../../utils/text_style.dart';
import 'package:flutter/material.dart';
import 'common_space_divider_widget.dart';
import 'icon_and_image.dart';

class CommonTextField extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final bool? autofocus;
  final FocusNode? focusNode;
  final bool? obscureText;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final bool? autocorrect;
  final FormFieldValidator<String>? validator;
  final bool? readOnly;
  final String? labelText;
  final String? hintText;
  final String? prefix;
  final Widget? suffix;
  final String? obscuringCharacter;
  final int? maxLines;
  final int? maxLength;

  const CommonTextField({
    Key? key,
    this.controller,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.readOnly = false,
    this.autofocus = false,
    this.obscureText = false,
    this.autocorrect = true,
    this.onChanged,
    this.obscuringCharacter,
    this.onTap,
    this.validator,
    this.maxLines,
    this.labelText,
    this.hintText,
    this.prefix,
    this.suffix,
    this.focusNode,
    this.maxLength,
  }) : super(key: key);

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  final TextAlign textAlign = TextAlign.start;
  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void _onFocusChange() {
    debugPrint("Focus: ${_focus.hasFocus.toString()}");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        widget.labelText == ''
            ? verticalSpace(0)
            : Text(
                widget.labelText!,
                style: pMedium12,
              ),
        verticalSpace(15),
        Center(
          child: TextFormField(
            controller: widget.controller,
            cursorColor: AppColor.cHintFont,
            autofocus: widget.autofocus ?? false,
            focusNode: _focus,
            readOnly: widget.readOnly ?? false,
            validator: widget.validator,
            onChanged: widget.onChanged,
            obscureText: widget.obscureText ?? false,
            obscuringCharacter: widget.obscuringCharacter ?? ' ',
            keyboardType: widget.keyboardType,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            style: pMedium14.copyWith(color: AppColor.cFont),
            decoration: InputDecoration(
              fillColor: _focus.hasFocus
                  ? AppColor.cFocusLightBlue
                  : AppColor.cTransparent,
              filled: true,
              hintText: widget.hintText,
              hintStyle: pMedium14.copyWith(color: AppColor.cHintFont),
              errorStyle: pMedium12.copyWith(color: AppColor.cFav),
              counterStyle: pMedium12.copyWith(height: 0,fontSize: 0,),
              prefixIcon: widget.prefix == null
                  ? horizontalSpace(0)
                  : assetSvdImageWidget(
                      image: widget.prefix,
                      colorFilter: ColorFilter.mode(
                        _focus.hasFocus ? AppColor.cFont : AppColor.cGreyFont,
                        BlendMode.srcIn,
                      ),
                    ),
              suffixIcon: widget.suffix,
              prefixIconConstraints: BoxConstraints(
                  maxWidth: widget.prefix == null ? 16 : 45,
                  minWidth: widget.prefix == null ? 16 : 42),
              suffixIconConstraints: BoxConstraints(maxWidth: 45, minWidth: 42),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColor.cHintFont),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColor.cHintFont),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColor.cHintFont),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColor.cHintFont),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    BorderSide(color: AppColor.blueThemeColor, width: 1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
