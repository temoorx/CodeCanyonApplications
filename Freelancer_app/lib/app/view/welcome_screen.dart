/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V3
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2024-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:freelancer/app/controller/welcome_controller.dart';
import 'package:freelancer/app/helper/router.dart';
import 'package:freelancer/app/util/constant.dart';
import 'package:freelancer/app/util/theme.dart';
import 'package:freelancer/app/widget/elevated_button.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Widget getLanguages() {
    return PopupMenuButton(
      onSelected: (value) {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: IconButton(icon: const Icon(Icons.translate), color: ThemeProvider.appColor, onPressed: () {}),
      ),
      itemBuilder: (context) => AppConstants.languages
          .map(
            (e) => PopupMenuItem<String>(
              value: e.languageCode.toString(),
              onTap: () {
                var locale = Locale(e.languageCode.toString());
                Get.updateLocale(locale);
                Get.find<WelcomeController>().saveLanguage(e.languageCode);
              },
              child: Text(e.languageName.toString()),
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WelcomeController>(
      builder: (value) {
        return Scaffold(
          backgroundColor: ThemeProvider.whiteColor,
          extendBodyBehindAppBar: true,
          appBar: AppBar(backgroundColor: ThemeProvider.transParent,automaticallyImplyLeading: false,  elevation: 0, actions: <Widget>[getLanguages()]),
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Image.asset('assets/images/bob.gif', fit: BoxFit.cover, height: MediaQuery.of(context).size.height * .55),
                ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * .45,
                    decoration: const BoxDecoration(color: ThemeProvider.appColor, borderRadius: BorderRadius.all(Radius.circular(0))),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Welcome to Handyman'.tr, textAlign: TextAlign.center, style: const TextStyle(fontFamily: 'bold', fontSize: 24, color: ThemeProvider.whiteColor)),
                          const SizedBox(height: 20),
                          MyElevatedButton(
                            onPressed: () => Get.toNamed(AppRouter.getLoginRoute()),
                            color: ThemeProvider.whiteColor,
                            height: 45,
                            width: double.infinity,
                            child: Text('Continue with Email'.tr, style: const TextStyle(letterSpacing: 1, fontSize: 16, color: ThemeProvider.appColor, fontFamily: 'bold')),
                          ),
                          const SizedBox(height: 20),
                          MyElevatedButton(
                            onPressed: () => Get.toNamed(AppRouter.getRegisterRoute()),
                            color: ThemeProvider.secondaryAppColor,
                            height: 45,
                            width: double.infinity,
                            child: Text('Partner with Us'.tr, style: const TextStyle(letterSpacing: 1, fontSize: 16, color: ThemeProvider.whiteColor, fontFamily: 'bold')),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
