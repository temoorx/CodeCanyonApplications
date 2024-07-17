import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/helper/string_format_helper.dart';
import 'package:hyip_lab/core/utils/dimensions.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/core/utils/style.dart';
import 'package:hyip_lab/data/controller/pool/pool_contrroller.dart';
import 'package:hyip_lab/view/components/appbar/custom_appbar.dart';
import 'package:hyip_lab/view/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:hyip_lab/view/components/buttons/rounded_loading_button.dart';
import 'package:hyip_lab/view/components/custom_loader/custom_loader.dart';
import 'package:hyip_lab/view/components/drop_dawn/custom_drop_down_field3.dart';
import 'package:hyip_lab/view/components/rounded_button.dart';
import 'package:hyip_lab/view/components/text-field/custom_amount_text_field.dart';
import 'package:hyip_lab/view/components/text/label_text.dart';

import '../../../../core/utils/util.dart';
import '../../../../data/controller/common/theme_controller.dart';

class AddPoolScreen extends StatefulWidget {
  const AddPoolScreen({super.key});

  @override
  State<AddPoolScreen> createState() => _AddPoolScreenState();
}

class _AddPoolScreenState extends State<AddPoolScreen> {
  String id = "-1";
  @override
  void initState() {
    String arg = Get.arguments.toString();
    id = arg;

    ThemeController themeController = ThemeController(sharedPreferences: Get.find());
    MyUtils.allScreensUtils(themeController.darkTheme);

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<PoolController>().amountController.text = "";
      Get.find<PoolController>().planID = "-1";
      Get.find<PoolController>().changePlanID(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.getScreenBgColor(),
      appBar: CustomAppBar(title: MyStrings.pool),
      body: GetBuilder<PoolController>(builder: (controller) {
        print(controller.selectedWallet);
        for(int i = 0; i< controller.walletList.length; i++){
          print('data: ${controller.walletList[i]}');
        }
        return controller.isLoading? const CustomLoader() : SingleChildScrollView(
          child: Padding(
            padding: Dimensions.screenPaddingHV,
            child: Column(
              children: [
                const LabelText(text: MyStrings.wallet, required: true),
                const SizedBox(
                  height: Dimensions.space5,
                ),
                CustomDropDownTextField3(
                  fillColor: MyColor.getCardBg(),
                  focusColor: MyColor.getCardBg(),
                  dropDownColor: MyColor.getCardBg(),
                  needLabel: false,
                  selectedValue: null,
                  onChanged: (value) {
                    controller.selectwallet(value);
                  },
                  items: controller.walletList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        overflow: TextOverflow.ellipsis,
                        style:  TextStyle(
                          fontSize: Dimensions.fontDefault,
                          color: MyColor.getTextColor()
                        ),
                      ),
                    );
                  }).toList(),
                  hintText: MyStrings.selectOne.tr,
                ),
                const SizedBox(
                  height: Dimensions.space25,
                ),
                CustomAmountTextField(
                  labelText: MyStrings.amount,
                  hintText: "",
                  currency: controller.currency,
                  onChanged: (val) {},
                  controller: controller.amountController,
                  autoFocus: false,
                ),
                const SizedBox(
                  height: Dimensions.space50,
                ),
                controller.isSubmitLoading ?
                const RoundedLoadingBtn() :
                RoundedButton(
                  text: MyStrings.submit,
                  press: () {
                    controller.submitPool();
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
