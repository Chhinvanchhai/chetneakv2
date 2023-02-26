import 'package:get/get.dart';
import 'package:chetneak_v2/components/primary_button.dart';
import 'package:chetneak_v2/constants.dart';
import 'package:chetneak_v2/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:chetneak_v2/themes/app_theme.dart';

class LoginScreen extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());
  String password = '';
  String email = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            children: [
              Spacer(flex: 1),
              Image.asset(
                MediaQuery.of(context).platformBrightness == Brightness.light
                    ? "assets/logo/logo5.png"
                    : "assets/logo/logo5.png",
                height: 200,
              ),
              Spacer(),
              Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          onChanged: (text) {
                            email = text;
                          },
                          style: TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                              hintText: 'Username',
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none),
                        ),
                      ),
                      Icon(Icons.email),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // TextField(
              //     onChanged: (text) {
              //       email = text;
              //     },
              //     decoration: InputDecoration(hintText: 'Email')),
              // TextField(
              //     onChanged: (text) {
              //       password = text;
              //     },
              //     decoration: InputDecoration(hintText: 'Password')),

              Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          onChanged: (text) {
                            password = text;
                          },
                          style: TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                              hintText: 'Password',
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none),
                        ),
                      ),
                      Icon(Icons.password_outlined)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              PrimaryButton(
                  text: "Sign In",
                  press: () => profileController.login(email, password)),
              SizedBox(height: kDefaultPadding * 1.5),
              Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
