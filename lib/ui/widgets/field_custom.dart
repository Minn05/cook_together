// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'widgets.dart';

class TextFieldCustom extends StatelessWidget {
  final TextEditingController controller;
  final int? maxLines;
  final String? hintText;
  final bool isPassword;
  final TextInputType keyboardType;
  final Icon? icon;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;

  const TextFieldCustom({
    Key? key,
    required this.controller,
    this.maxLines,
    this.hintText,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.icon,
    this.suffixIcon,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      // maxLines: maxLines,
      controller: controller,
      // style: GoogleFonts.getFont('Roboto', fontSize: 18),
      style: const TextStyle(fontSize: 18),
      cursorColor: kPrimaryLabelColor,
      obscureText: isPassword,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        hintText: hintText,
        hintStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        icon: icon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: ColorsCustom.primary.withOpacity(0.7),
            width: 1,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: ColorsCustom.primary.withOpacity(0.7),
            width: 1,
          ),
        ),
        suffixIcon: suffixIcon,
      ),
      validator: validator,
    );
  }
}
