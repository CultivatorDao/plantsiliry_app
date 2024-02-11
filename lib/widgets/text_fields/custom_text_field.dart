import 'package:flutter/material.dart';


class CustomTextField extends StatefulWidget {
  const CustomTextField({super.key,
    this.passwordField,
    this.hintText,
    this.label,
    this.onChanged
  });

  final bool? passwordField;
  final String? hintText;
  final String? label;
  final Function? onChanged;


  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  bool? _passwordField = false;
  bool showPassword = true;
  String? _hintText = "";
  String? _label = "";
  Function? _onChanged = (value) {};

  @override
  void initState() {
    _passwordField = widget.passwordField ?? _passwordField;
    _hintText = widget.hintText ?? _hintText;
    _label = widget.label ?? _label;
    _onChanged = widget.onChanged ?? _onChanged;

    showPassword = _passwordField! ? false : true;
    debugPrint(showPassword.toString());

    super.initState();
  }

  void toggle() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: _hintText,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        label: Text(_label!, style: Theme.of(context).textTheme.titleMedium,),
        suffixIcon: Visibility(
          visible: _passwordField!,
          child: IconButton(
            onPressed: () {
              toggle();
            },
            icon: Icon(
              showPassword ? Icons.visibility : Icons.visibility_off,
            )
          ),
        ),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 226, 227, 228)),
            borderRadius: BorderRadius.all(Radius.circular(12))
        ),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 226, 227, 228)),
            borderRadius: BorderRadius.all(Radius.circular(12))
        ),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(12))
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      obscureText: !showPassword,
      onChanged: (value) {
        setState(() {
          _onChanged!(value);
        });
      },

    );
  }
}
