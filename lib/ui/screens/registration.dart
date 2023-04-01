import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dashboard_web/constants/sbi_constants.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/registration/registration_bloc.dart';
import '../../main.dart';
import '../widgets/loader_widget.dart';
import '../widgets/text_widget.dart';

@RoutePage(name: "registration")
class RegistrationScreen extends StatefulWidget implements AutoRouteWrapper {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();

  @override
  Widget wrappedRoute(context) {
    return BlocProvider(
      create: (context) => RegistrationBloc(),
      child: this, // this as the child Important!
    );
  }
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late RegistrationBloc registrationBloc;
  TextEditingController phoneNo = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    registrationBloc = BlocProvider.of<RegistrationBloc>(context)
      ..stream.listen((state) {
        if (state is RegistrationDone) {
          log(state.response.response.infoMsg);
          LoaderWidget().showLoader(context, stopLoader: true);

          /*  Navigator.pushNamed(context, RouteName.otpvalidationScreen,
              arguments: (ccode.text + phoneNo.text)); */
        }
        if (state is RegistrationError) {
          log(state.error);
          Navigator.pop(context);
          //   Fluttertoast.showToast(msg: state.error, backgroundColor: Colors.red);
        }
      });
    registrationBloc.add(AgreeEvent(false));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    /*  Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: AppImages.logoSmall(context,
                          color: AppColors.primaryColor),
                    ), */
                    Expanded(child: Container()),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text(
                      "Login",
                      style: GoogleFonts.roboto(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    TextWidget(
                      "Welcome back to the Traditional Login.",
                      color: SbiConstants().lightGrey,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                /*  TextField(
                  controller: userIDController,
                  style: const TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    labelText: "User ID",
                    hintStyle: const TextStyle(fontSize: 16),
                    labelStyle: const TextStyle(fontSize: 16),
                    hintText: "11110111",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ), */
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: phoneNo,
                  style: const TextStyle(fontSize: 16),
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Mobile Number",
                    hintText: "",
                    hintStyle: const TextStyle(fontSize: 16),
                    labelStyle: const TextStyle(fontSize: 16),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    TextWidget(
                      "Forgot password?",
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    appRoute.pushNamed("/dashboard?index=0");
                    /* if (formKey.currentState!.validate()) {
                      LoaderWidget()
                          .showLoader(context, text: AppConstants.pleaseWait);
                      context.read<RegistrationBloc>().add(
                          RegistrationRequestEvent(RegistrationRequest(
                              request: Request(
                                  data: Data(mobNo: phoneNo.text),
                                  appID: "f79f65f1b98e116f40633dbb46fd5e21"))));
                    } else {
                      /*  Fluttertoast.showToast(
                                      msg: AppConstants.pleaseAgree,
                                      backgroundColor: Colors.red); */
                    } */
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: SbiConstants().active,
                    ),
                    alignment: Alignment.center,
                    width: double.maxFinite,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: const TextWidget(
                      "Login",
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(text: "Do not have credentials? "),
                      TextSpan(
                          text: "Request Credentials! ", style: TextStyle())
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
