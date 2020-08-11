import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final bool enabled;
  final String labelText;
  final String error;
  final Function function;
  final bool obscure;
  final Function eyeFunction;
  final Color color;
  final bool dislowSpace;

  CustomTextFieldWidget(
      {this.labelText,
      this.error,
      this.function,
      this.obscure,
      this.eyeFunction,
      this.enabled,
      this.color,
      this.dislowSpace});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context)
          .copyWith(primaryColor: color ?? Colors.deepPurpleAccent),
      child: TextField(
        inputFormatters: dislowSpace == null
            ? null
            : dislowSpace
                ? [
                    WhitelistingTextInputFormatter(RegExp("[ ]")),
                  ]
                : null,
        textCapitalization: color != null
            ? TextCapitalization.sentences
            : TextCapitalization.none,
        enabled: enabled,
        onChanged: function,
        obscureText: obscure ?? false,
        style: TextStyle(color: color ?? Colors.deepPurpleAccent),
        decoration: InputDecoration(
          suffixIcon: eyeFunction != null
              ? IconButton(
                  icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
                  onPressed: eyeFunction,
                )
              : null,
          errorText: error,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          labelText: labelText,
          labelStyle: TextStyle(color: color ?? Colors.deepPurpleAccent),
        ),
      ),
    );
  }
}
