import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormTextField extends StatefulWidget {
  final String labelText;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final String? Function(String?)? validator;
  final bool isPassWordField;
  final String hintText;
  final Color errorBorder;
  final Color focusErrorBorder;
  final TextEditingController controller;
  final bool addMargin;
  final Color fillColor;
  final Color errorTextColor;
  final String? errorText;
  final int? maxLength;
  final bool readOnly;
  final bool isEdu;
  final Function(String)? onChange;
  // final String headerText;

  const FormTextField({
    Key? key,
    this.labelText = "",
    this.textInputAction = TextInputAction.done,
    this.addMargin = true,
    this.textInputType = TextInputType.text,
    this.hintText = "",
    this.isPassWordField = false,
    this.textCapitalization = TextCapitalization.none,
    this.validator,
    required this.controller,
    this.errorBorder = Colors.red,
    this.focusErrorBorder = Colors.red,
    this.fillColor = Colors.grey,
    this.errorTextColor = Colors.red,
    this.readOnly = false,
    this.isEdu = false,
    this.errorText,
    this.onChange,
    this.maxLength,
  }) : super(key: key);

  @override
  _FormTextFieldState createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  bool _obscureText = true;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusNodeEvent);
  }

  void _onFocusNodeEvent() {
    setState(() {});
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _requestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    var passwordVisibilityToggle = GestureDetector(
      onTap: _togglePasswordVisibility,
      child: Container(
        width: 48,
        height: 44,
        margin: const EdgeInsets.only(left: 14.0),
        child: Center(
          child: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            size: 18,
            color: Colors.grey,
          ),
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...(widget.labelText.isNotEmpty
            ? [
                Text(
                  widget.labelText,
                  style: const TextStyle(
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 6)
              ]
            : []),
        TextFormField(
          readOnly: widget.readOnly,
          focusNode: _focusNode,
          onTap: _requestFocus,
          cursorWidth: 1.8,
          cursorHeight: 18,
          cursorColor: Colors.black,
          controller: widget.controller,
          textCapitalization: widget.textCapitalization,
          textInputAction: widget.textInputAction,
          keyboardType: widget.textInputType,
          validator: widget.validator,
          onChanged: widget.onChange,
          maxLength: widget.maxLength,
          decoration: InputDecoration(
            errorText: widget.errorText,
            counter: const SizedBox(),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            border: const OutlineInputBorder(),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: widget.focusErrorBorder, width: 0.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: widget.errorBorder, width: 0.5),
            ),
            errorStyle: GoogleFonts.dmSans(fontWeight: FontWeight.w400),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.black26, width: 0.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.black54, width: 0.5),
            ),
            hintText: widget.hintText,
            suffixIcon: widget.isPassWordField
                ? passwordVisibilityToggle
                : widget.isEdu
                    ? const Icon(
                        Icons.arrow_drop_down_outlined,
                        size: 18,
                      )
                    : null,
          ),
          autofocus: false,
          obscureText: widget.isPassWordField ? _obscureText : false,
        ),
      ],
    );
  }
}
