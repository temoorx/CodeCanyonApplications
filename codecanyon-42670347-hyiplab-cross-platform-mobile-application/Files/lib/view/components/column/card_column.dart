import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/style.dart';

import '../../../core/utils/dimensions.dart';

class CardColumn extends StatelessWidget {
  final String header;
  final String body;
  final bool alignmentEnd;
  final bool isDate;
  final Color? textColor;
  final double? space;

  const CardColumn({
    Key? key,
    this.alignmentEnd = false,
    required this.header,
    this.isDate = false,
    this.textColor,
    required this.body,
    this.space = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignmentEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          header.tr,
          style: interLightExtraSmall.copyWith(color: MyColor.getLabelTextColor(), fontWeight: FontWeight.w600),
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          height: space,
        ),
        Text(body.tr, style: isDate ? interRegularDefault.copyWith(fontStyle: FontStyle.italic, color: textColor ?? MyColor.getTextColor(), fontSize: Dimensions.fontSmall) : interRegularDefault.copyWith(color: textColor ?? MyColor.getTextColor()))
      ],
    );
  }
}
