import 'package:emart_seller/views/widgets/normal_text.dart';

import '../../const/const.dart';

class DashBoardButton extends StatelessWidget {
  const DashBoardButton({
    super.key,
    required this.title,
    required this.number,
    required this.image,
  });
  final String title, number, image;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              boldText(text: title, size: 16.0),
              boldText(text: number, size: 20.0)
            ],
          ),
        ),
        Image.asset(
          image,
          width: 30,
          color: white,
        ),
      ],
    )
        .box
        .color(purpleColor)
        .rounded
        .size(context.screenWidth * 0.4, 80)
        .padding(const EdgeInsets.all(8))
        .make();
  }
}
