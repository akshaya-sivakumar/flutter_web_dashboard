import 'dart:async';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dashboard_web/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';

import '../../bloc/otp_validation/otp_validation_bloc.dart';
import '../../bloc/registration/registration_bloc.dart';
import '../../constants/app_constants.dart';
import '../../model/login_request.dart';
import '../../model/registration_request.dart' as reg;
import '../widgets/loader_widget.dart';
import '../widgets/text_widget.dart';

@RoutePage(name: "registration")
class RegistrationScreen extends StatefulWidget implements AutoRouteWrapper {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();

  @override
  Widget wrappedRoute(context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => RegistrationBloc(),
      ),
      BlocProvider(
        create: (context) => OtpvalidationBloc(),
      )
    ], child: const RegistrationScreen());
  }
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late RegistrationBloc registrationBloc;
  TextEditingController phoneNo = TextEditingController();
  final formKey = GlobalKey<FormState>();

  //===otp=======
  int otpCodeLength = 4;
  String? _otpCode;

  TextEditingController textEditingController = TextEditingController(text: "");
  late OtpvalidationBloc otpvalidationBloc;

  ValueNotifier valueNotifier = ValueNotifier("");

  @override
  void initState() {
    super.initState();

    registrationBloc = BlocProvider.of<RegistrationBloc>(context)
      ..stream.listen((state) async {
        if (state is RegistrationDone) {
          log(state.response.response.infoMsg);
          LoaderWidget().showLoader(context, stopLoader: true);

          _showMyDialog();
        }
        if (state is RegistrationError) {
          LoaderWidget().showLoader(context, stopLoader: true);
          Fluttertoast.showToast(
              msg: state.error,
              gravity: ToastGravity.BOTTOM_RIGHT,
              timeInSecForIosWeb: 5,
              webPosition: "right",
              webShowClose: true,
              toastLength: Toast.LENGTH_LONG,
              webBgColor: "linear-gradient(to right, #F8313E, #F8313E)",
              fontSize: 20.0);
          //   Fluttertoast.showToast(msg: state.error, backgroundColor: Colors.red);
        }
      });
    otpvalidationBloc = BlocProvider.of<OtpvalidationBloc>(context)
      ..stream.listen((state) {
        if (state is OtpvalidationDone) {
          LoaderWidget().showLoader(context, stopLoader: true);
          appRoute.pop(context);
          appRoute.pushNamed("/dashboard?index=0");
        }
        if (state is OtpvalidationError) {
          LoaderWidget().showLoader(context, stopLoader: true);
          Fluttertoast.showToast(
              msg: state.error,
              gravity: ToastGravity.BOTTOM_RIGHT,
              timeInSecForIosWeb: 5,
              webPosition: "right",
              webShowClose: true,
              toastLength: Toast.LENGTH_LONG,
              webBgColor: "linear-gradient(to right, #F8313E, #F8313E)",
              fontSize: 20.0);
        }
      });
    registrationBloc.add(AgreeEvent(false));
  }

  _onOtpCallBack(String otpCode, bool isAutofill) {
    _otpCode = otpCode;
    if (otpCode.length == otpCodeLength) {
      //   LoaderWidget().showLoader(context, text: "Please wait..");

      //  _verifyOtpCode();
    }
  }

  _verifyOtpCode() {
    LoaderWidget().showLoader(context, text: "Please wait..");
    FocusScope.of(context).requestFocus(FocusNode());
    Timer(const Duration(milliseconds: 4000), () {
      context.read<OtpvalidationBloc>().add(OtpvalidationRequestEvent(
          OtpvalidationRequest(
              request: Request(
                  data: Data(
                      mobNo: phoneNo.text,
                      otp: _otpCode ?? "",
                      userType: "virtual"),
                  appID: "45370504ab27eed7327a1df46403a30a"))));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: Theme.of(context).primaryColorLight,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget(
                          AppConstants.welcometext,
                          style: GoogleFonts.cuteFont(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              shadows: <Shadow>[
                                Shadow(
                                  offset: const Offset(10.0, 10.0),
                                  blurRadius: 3.0,
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                              ],
                              color: Theme.of(context).primaryColor),
                        ),
                        Image.asset(
                          "lib/assets/icons/login_illus.png",
                          width: MediaQuery.of(context).size.width * 0.6,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          stops: const [0.0, 1.0],
                          begin: FractionalOffset.topLeft,
                          end: FractionalOffset.topRight,
                          colors: [
                            Theme.of(context)
                                .primaryColorLight
                                .withOpacity(0.8),
                            Theme.of(context).primaryColor.withOpacity(0.6),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Theme.of(context).primaryColor, width: 0.3)),
                    constraints:
                        const BoxConstraints(maxWidth: 400, maxHeight: 400),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          AppConstants.login,
                          style: GoogleFonts.adamina(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              shadows: <Shadow>[
                                Shadow(
                                  offset: const Offset(10.0, 10.0),
                                  blurRadius: 3.0,
                                  color: Theme.of(context)
                                      .primaryColorLight
                                      .withOpacity(0.3),
                                ),
                              ],
                              color: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.color),

                          /* Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  fontSize: 25,
                                  fontFamily:
                                      GoogleFonts.abhayaLibre().fontFamily), */
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextWidget(
                          "Enter the Mobile Number to Login",
                          color: Theme.of(context).textTheme.titleMedium?.color,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: phoneNo,
                          style: const TextStyle(fontSize: 16),
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            //labelText: "Mobile Number",
                            hintText: "Mobile Number",
                            filled: true,
                            fillColor: Colors.white54.withOpacity(0.6),
                            hintStyle: TextStyle(
                                fontSize: 13,
                                color: Theme.of(context).canvasColor),
                            labelStyle: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).canvasColor),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    width: 0,
                                    color: Theme.of(context).canvasColor)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    width: 0,
                                    color: Theme.of(context).canvasColor)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    width: 0,
                                    color: Theme.of(context).canvasColor)),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () {
                            //appRoute.pushNamed("/dashboard?index=0");
                            if (formKey.currentState!.validate()) {
                              LoaderWidget().showLoader(context,
                                  text: AppConstants.pleaseWait);
                              context.read<RegistrationBloc>().add(
                                  RegistrationRequestEvent(reg.RegistrationRequest(
                                      request: reg.Request(
                                          data: reg.Data(mobNo: phoneNo.text),
                                          appID:
                                              "f79f65f1b98e116f40633dbb46fd5e21"))));
                            } else {}
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Theme.of(context).primaryColor,
                            ),
                            alignment: Alignment.center,
                            width: double.maxFinite,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: const TextWidget(
                              "LOG IN",
                              color: Colors.white,
                              fontweight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,

      barrierColor: Colors.black.withOpacity(0.5),
      barrierDismissible:
          false, //this means the user must tap a button to exit the Alert Dialog
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(10)),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                  onTap: () {
                    appRoute.pop();
                  },
                  child: const Icon(Icons.close))
            ],
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextWidget(
                  AppConstants.otpVerify,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 17),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: TextWidget(
                    AppConstants.otpVerified + phoneNo.text,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ValueListenableBuilder(
                    valueListenable: valueNotifier,
                    builder: (context, value, child) {
                      return TextFieldPin(
                          textController: textEditingController,
                          autoFocus: true,
                          codeLength: otpCodeLength,
                          alignment: MainAxisAlignment.center,
                          defaultBoxSize: 46.0,
                          margin: 10,
                          selectedBoxSize: 46.0,
                          textStyle: const TextStyle(fontSize: 16),
                          defaultDecoration: _pinPutDecoration.copyWith(
                              border: Border.all(color: Colors.grey)),
                          selectedDecoration: _pinPutDecoration,
                          onChange: (code) {
                            valueNotifier.value = code;
                            _onOtpCallBack(code, false);
                          });
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      _verifyOtpCode();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Theme.of(context).primaryColor,
                      ),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.2,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: const TextWidget(
                        "Validate OTP",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Center(
                    child: TextButton(
                        onPressed: () {
                          LoaderWidget().showLoader(context,
                              text: AppConstants.pleaseWait);
                          context.read<RegistrationBloc>().add(
                              RegistrationRequestEvent(reg.RegistrationRequest(
                                  request: reg.Request(
                                      data: reg.Data(mobNo: phoneNo.text),
                                      appID:
                                          "f79f65f1b98e116f40633dbb46fd5e21"))));
                        },
                        child: TextWidget(
                          AppConstants.resendOtp,
                          size: 15,
                          color: Theme.of(context).primaryColor,
                        )))
              ],
            ),
          ),
        );
      },
    );
  }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(10.0),
    );
  }
}
