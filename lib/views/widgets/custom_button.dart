import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/widgets/normal_text.dart';

Widget customButton({title, color = purpleColor, onPress, titleColors}) {
  return ElevatedButton(
    onPressed: onPress,
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      backgroundColor: color,
      padding: const EdgeInsets.all(12),
    ),
    child: normalText(
      text: title,
      size: 16.0,
      color: titleColors,
    ),
  );
}
