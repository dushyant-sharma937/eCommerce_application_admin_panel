import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/widgets/normal_text.dart';

Widget customTextField({
  label,
  hintText,
  controller,
  isDesc = false,
  borderColor = Colors.white,
  color = Colors.black87,
  ti = TextInputType.text,
}) {
  return TextFormField(
    controller: controller,
    obscureText: false,
    maxLines: isDesc ? 4 : 1,
    keyboardType: ti,
    style: TextStyle(
      color: color,
    ),
    decoration: InputDecoration(
      isDense: true,
      label: normalText(text: label),
      hintText: hintText,
      hintStyle: TextStyle(color: color),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: borderColor,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: borderColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: color,
        ),
      ),
    ),
  );
}

Widget customPasswordTextField(
    {label,
    hintText,
    controller,
    borderColor = Colors.white,
    isPass,
    icon,
    onPress,
    color = Colors.black87}) {
  return TextFormField(
    controller: controller,
    obscureText: isPass,
    style: TextStyle(
      color: color,
    ),
    decoration: InputDecoration(
      suffixIcon: IconButton(
        icon: Icon(
          !isPass ? Icons.visibility : Icons.visibility_off,
          color: Colors.white,
        ),
        onPressed: onPress,
      ),
      isDense: true,
      label: normalText(text: label),
      hintText: hintText,
      hintStyle: TextStyle(color: color),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: borderColor,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: borderColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: color,
        ),
      ),
    ),
  );
}
