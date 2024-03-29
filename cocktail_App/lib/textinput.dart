import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef OnChanged = Function(String);
typedef OnSubmit = Function(String);

class UITextInput extends StatelessWidget {
  final String? title;
  final String? hint;
  final String? errorMessage;
  final double height;
  final bool enabled;
  final bool isRequired;
  final bool isObscure;
  final int? maxLength;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextEditingController? controller;
  final VoidCallback? onSuffixIconPressed;
  final VoidCallback? onFocus;
  final OnChanged? onChanged;
  final OnSubmit? onSubmitted;
  final bool numberType;
  final bool errorDate;

  const UITextInput({
    super.key,
    this.height = 48,
    this.enabled = true,
    this.hint,
    this.errorMessage,
    this.isRequired = false,
    this.isObscure = false,
    this.maxLength,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.onSuffixIconPressed,
    this.onFocus,
    this.onChanged,
    this.onSubmitted,
    this.title,
    this.textInputAction = TextInputAction.done,
    this.numberType = false,
    this.errorDate = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != null
            ? Row(
                children: [
                  Text(
                    title!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    isRequired ? " *" : "",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.blue,
                    ),
                  ),
                ],
              )
            : const SizedBox.shrink(),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          height: height,
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: TextField(
              inputFormatters: numberType
                  ? [
                      FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                    ]
                  : [],
              maxLines: height == 48 ? 1 : null,
              expands: height != 48,
              enabled: enabled,
              onTap: onFocus,
              controller: controller,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              maxLength: maxLength,
              style: TextStyle(
                color: errorDate ? Colors.red : null,
                fontSize: 14,
                height: 1.25,
              ),
              textAlignVertical: height == 48
                  ? TextAlignVertical.center
                  : TextAlignVertical.top,
              obscureText: isObscure,
              autocorrect: false,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(15),
                disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 1.0),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 1.0),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                hintText: hint,
                hintStyle: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  height: 1.25,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                suffixIcon: keyboardType == TextInputType.visiblePassword
                    ? IconButton(
                        icon: Icon(!isObscure
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: onSuffixIconPressed)
                    : keyboardType == TextInputType.datetime
                        ? IconButton(
                            icon: const Icon(Icons.calendar_today_outlined),
                            onPressed: onSuffixIconPressed)
                        : null,
              ),
              keyboardType: keyboardType,
              textInputAction: textInputAction,
            ),
          ),
        ),
        if (!(errorMessage == null || errorMessage!.isEmpty))
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                errorMessage!,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
