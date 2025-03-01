import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';

class OutlinedInput extends StatelessWidget {
  const OutlinedInput({
    super.key,
    this.controller,
    this.onChanged,
    this.hintText = '',
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
    this.validator,
    this.errorText,
    this.inputFormatter,
    this.enabledBorder,
    this.focusedBorder,
    this.onTapOutside,
  });

  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;
  final String? Function(String?)? validator;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatter;
  final Color? enabledBorder;
  final Color? focusedBorder;
  final void Function(PointerDownEvent)? onTapOutside;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        controller: controller,
        validator: validator,
        enabled: enabled,
        onChanged: onChanged,
        keyboardType: keyboardType,
        obscureText: obscureText,
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
          filled: true,
          fillColor: enabled ? CustomColor.white : CustomColor.labelAssistiveBlack,
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 12.0,
          ),
          errorText: errorText,
          errorStyle: const TextStyle(color: CustomColor.primaryStrongRed, fontSize: 13),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: enabledBorder ?? CustomColor.labelAssistiveBlack),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(width: 1, color: focusedBorder ?? CustomColor.black),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: enabledBorder ?? CustomColor.labelAssistiveBlack),
          ),
        ),
        style: CustomText.body1.copyWith(
          color: CustomColor.labelAssistiveBlack,
          decorationThickness: 0,
        ),
        cursorColor: CustomColor.black,
        inputFormatters: inputFormatter ?? [
          FilteringTextInputFormatter.allow(RegExp('[.!@#\$%^&*()-_|1-9|a-z|A-Z|ㄱ-ㅎ|ㅏ-ㅣ|가-힣|ᆞ|ᆢ|ㆍ|ᆢ|ᄀᆞ|ᄂᆞ|ᄃᆞ|ᄅᆞ|ᄆᆞ|ᄇᆞ|ᄉᆞ|ᄋᆞ|ᄌᆞ|ᄎᆞ|ᄏᆞ|ᄐᆞ|ᄑᆞ|ᄒᆞ| ]')),
        ],
        onTapOutside: onTapOutside,
      ),
    );
  }
}
