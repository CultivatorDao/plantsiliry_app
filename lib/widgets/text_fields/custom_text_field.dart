import 'package:flutter/material.dart';
import 'package:plantsility_app/widgets/validator/validator.dart';


class CustomTextField extends StatefulWidget {
  /// Creates text field with rounded rectangular border.
  ///
  /// If passwordField set true hide value and show visibility button on left side of field.
  const CustomTextField({super.key,
    this.passwordField,
    this.onlyDigits,
    this.initialValue,
    this.hintText,
    this.label,
    this.padding,
    this.height,
    this.fontSize,
    this.onChanged,
    this.validator,
  });

  /// [passwordField] Set true if you want this textField to obfuscate text and show visibility button.
  final bool? passwordField;
  /// [onlyDigits] Set true if you want this text field take only digits as input
  final bool? onlyDigits;
  /// [initialValue] When specified fills text field value with this value.
  final String? initialValue;
  /// [hintText] Text that suggests what sort of input the field accepts.
  final String? hintText;
  /// [label] Optional widget that describes the input field.
  final String? label;
  ///
  final double? height;
  ///
  final EdgeInsetsGeometry? padding;
  ///
  final double? fontSize;
  /// [onChanged] Called when the user initiates a change to the TextField's value: when they have inserted or deleted text or reset the form.
  final Function? onChanged;
  /// [validator] Optional validation checks.
  final Validator? validator;


  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  bool? _passwordField = false;
  bool showPassword = true;
  bool? _onlyDigits = false;
  String? _initialValue = "";
  String? _hintText = "";
  String? _label = "";
  EdgeInsetsGeometry? _padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 16);
  double? _fontSize = 16;
  double? _height = 50;
  Function? _onChanged = (value) {};
  Validator? _validator = Validator();

  // TODO modify to receive user condition and helper text
  String? validateField(String? value) {
    if (value!.isEmpty) {
      return "";
    }
    else if (value.length < 8) {
      return "";
    }
    else {
      return null;
    }
  }

  @override
  void initState() {
    _passwordField = widget.passwordField ?? _passwordField;
    _onlyDigits = widget.onlyDigits ?? _onlyDigits;
    _initialValue = widget.initialValue ?? _initialValue;
    _hintText = widget.hintText ?? _hintText;
    _label = widget.label ?? _label;
    _padding = widget.padding ?? _padding;
    _height = widget.height ?? _height;
    _fontSize = widget.fontSize ?? _fontSize;
    _onChanged = widget.onChanged ?? _onChanged;
    _validator = widget.validator ?? _validator;

    showPassword = _passwordField! ? false : true;

    super.initState();
  }

  // Function toggles value show mode, show or hide textField value
  void toggle() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      child: TextFormField(
        style: TextStyle(fontSize: _fontSize),
        keyboardType: _onlyDigits! ? TextInputType.number : TextInputType.text,
        initialValue: _initialValue,
        decoration: InputDecoration(
          hintText: _hintText,
          contentPadding: _padding,
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
        // Call user provided onChanged function here
        onChanged: (value) {
          setState(() {
            _onChanged!(value);
          });
        },
        validator: (val) {
          return _validator?.validate(val);
        },
      ),
    );
  }
}
