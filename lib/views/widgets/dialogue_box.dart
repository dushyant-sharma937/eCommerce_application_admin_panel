import 'package:emart_seller/const/const.dart';

class CustomDialogueBox extends StatelessWidget {
  final String text;
  final BuildContext context;
  final dynamic onPressYes;
  final dynamic onPressNo;
  const CustomDialogueBox(
      {super.key,
      required this.text,
      required this.context,
      required this.onPressYes,
      required this.onPressNo});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16),
        height: context.screenHeight * 0.18,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Confirm".text.bold.black.size(18).make(),
            10.heightBox,
            text.text.semiBold.size(16).black.make(),
            10.heightBox,
            Row(
              children: [
                const Spacer(),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: onPressNo,
                          child: "No".text.bold.color(Colors.green).make()),
                      10.widthBox,
                      TextButton(
                          onPressed: onPressYes,
                          child: "Yes".text.bold.color(Colors.red).make()),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
