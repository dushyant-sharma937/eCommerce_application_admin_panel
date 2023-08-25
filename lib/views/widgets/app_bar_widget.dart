import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/widgets/normal_text.dart';
import 'package:intl/intl.dart' as intl;

AppBar customAppBar({title}) {
  return AppBar(
    backgroundColor: Colors.white,
    automaticallyImplyLeading: false,
    title: boldText(text: title, color: Colors.black, size: 20.0),
    actions: [
      Center(
          child: normalText(
              text: intl.DateFormat.yMMMMd('en_US').format(DateTime.now()),
              color: purpleColor)),
      10.widthBox,
    ],
  );
}
