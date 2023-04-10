import 'dart:async';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dashboard_web/constants/app_routes.dart';
import 'package:flutter_dashboard_web/constants/appwidget_size.dart';
import 'package:flutter_dashboard_web/main.dart';
import 'package:flutter_dashboard_web/ui/widgets/show_toast.dart';
import 'package:flutter_dashboard_web/utils/app_utils.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';

import '../../../bloc/otp_validation/otp_validation_bloc.dart';
import '../../../bloc/registration/registration_bloc.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_images.dart';
import '../../../model/login/login_request.dart';
import '../../../model/registration/registration_request.dart' as reg;
import '../../widgets/loader_widget.dart';
import '../../widgets/text_widget.dart';

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
  TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  int otpCodeLength = 4;
  String? _otpCode;

  TextEditingController textEditingController = TextEditingController(text: "");
  late OtpvalidationBloc otpvalidationBloc;

  ValueNotifier valueNotifier = ValueNotifier("");
  ValueNotifier popShowed = ValueNotifier(false);
  List userList = [];

  @override
  void initState() {
    super.initState();
    userList = AppUtils().getUserlist();

    registrationBloc = BlocProvider.of<RegistrationBloc>(context)
      ..stream.listen((state) async {
        if (state is RegistrationDone) {
          log(state.response.response.infoMsg);

          LoaderWidget().showLoader(context, stopLoader: true);

          if (!popShowed.value) {
            _showMyDialog(context);
          }
          popShowed.value = true;
        }
        if (state is RegistrationError) {
          LoaderWidget().showLoader(context, stopLoader: true);
          Apptoast().toastWidget(state.error);
        }
      });
    otpvalidationBloc = BlocProvider.of<OtpvalidationBloc>(context)
      ..stream.listen((state) {
        if (state is OtpvalidationDone) {
          LoaderWidget().showLoader(context, stopLoader: true);
          appRoute.pop(context);
          clearPinfield();
          appRoute.pushNamed(AppRoutes.watchlistRoute);
        }
        if (state is OtpvalidationError) {
          clearPinfield();
          LoaderWidget().showLoader(context, stopLoader: true);
          Apptoast().toastWidget(state.error);
        }
      });
  }

  void clearPinfield() {
    _otpCode = "";
    textEditingController.clear();
    valueNotifier.value = "";
    popShowed.value = false;
  }

  _onOtpCallBack(String otpCode, bool isAutofill) {
    _otpCode = otpCode;
  }

  _verifyOtpCode() {
    LoaderWidget().showLoader(context, text: AppConstants.pleaseWait);
    FocusScope.of(context).requestFocus(FocusNode());
    Timer(const Duration(milliseconds: 4000), () {
      otpvalidationBloc.add(OtpvalidationRequestEvent(OtpvalidationRequest(
          request: Request(
              data: Data(
                  mobNo: "+91${phoneNo.text}",
                  otp: _otpCode ?? "",
                  userType: AppConstants.usertype),
              appID: AppConstants.appIdOtp))));
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
              child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                return Row(
                  mainAxisAlignment: constraints.maxWidth > 730
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.center,
                  children: [
                    if (constraints.maxWidth > 730)
                      Container(
                        color: Theme.of(context).primaryColorLight,
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextWidget(
                              AppConstants.welcometext,
                              style: GoogleFonts.cuteFont(
                                  fontSize: AppWidgetSize.dimen_60,
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
                            AppImages.loginIllustration()
                          ],
                        ),
                      ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: AppWidgetSize.dimen_50),
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
                              color: Theme.of(context).primaryColor,
                              width: 0.3)),
                      constraints: BoxConstraints(
                          maxWidth: AppWidgetSize.dimen_400,
                          maxHeight: AppWidgetSize.dimen_400),
                      padding: EdgeInsets.all(AppWidgetSize.dimen_24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: AppWidgetSize.dimen_30,
                          ),
                          Text(
                            AppConstants.login,
                            style: GoogleFonts.adamina(
                                fontSize: AppWidgetSize.dimen_30,
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
                          ),
                          SizedBox(
                            height: AppWidgetSize.dimen_15,
                          ),
                          TextWidget(
                            AppConstants.enterMobileNo,
                            color:
                                Theme.of(context).textTheme.titleMedium?.color,
                          ),
                          SizedBox(
                            height: AppWidgetSize.dimen_20,
                          ),
                          suggestionField(context, phoneNo, "Username",
                              (pattern) async {
                            return userList
                                .where((element) => element["username"]
                                    .toString()
                                    .contains(pattern))
                                .toList();
                          }),
                          SizedBox(
                            height: AppWidgetSize.dimen_20,
                          ),
                          suggestionField(context, password, "Password",
                              (pattern) async {
                            return userList
                                .where((element) => element["password"]
                                    .toString()
                                    .contains(pattern))
                                .toList();
                          }, obscureText: true),
                          /*  TextFormField(
                            controller: phoneNo,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == "" || value == null) {
                                return AppConstants.mobileValidation;
                              }
                              return null;
                            },
                            style: TextStyle(
                                fontSize: AppWidgetSize.dimen_16,
                                color: Theme.of(context).primaryColor),
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: AppConstants.mobilenumber,
                              filled: true,
                              fillColor: Colors.white54.withOpacity(0.6),
                              hintStyle: TextStyle(
                                  fontSize: AppWidgetSize.dimen_13,
                                  color: Theme.of(context).canvasColor),
                              labelStyle: TextStyle(
                                  fontSize: AppWidgetSize.dimen_14,
                                  color: Theme.of(context).canvasColor),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: AppWidgetSize.dimen_20,
                                  horizontal: AppWidgetSize.dimen_10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      AppWidgetSize.dimen_10),
                                  borderSide: BorderSide(
                                      width: 0,
                                      color: Theme.of(context).canvasColor)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      AppWidgetSize.dimen_10),
                                  borderSide: BorderSide(
                                      width: 0,
                                      color: Theme.of(context).canvasColor)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      AppWidgetSize.dimen_10),
                                  borderSide: BorderSide(
                                      width: 0,
                                      color: Theme.of(context).canvasColor)),
                            ),
                          ), */
                          SizedBox(
                            height: AppWidgetSize.dimen_30,
                          ),
                          InkWell(
                            onTap: () {
                              //
                              if (formKey.currentState!.validate()) {
                                TextInput.finishAutofillContext(
                                    shouldSave: true);
                                AppUtils().storeUserlist({
                                  "username": phoneNo.text,
                                  "password": password.text
                                });
                                // appRoute.pushNamed("/dashboard?index=0");
                                /*  LoaderWidget().showLoader(context,
                                    text: AppConstants.pleaseWait);
                                registrationBloc.add(RegistrationRequestEvent(
                                    reg.RegistrationRequest(
                                        request: reg.Request(
                                            data: reg.Data(
                                                mobNo: "+91${phoneNo.text}"),
                                            appID: AppConstants.appId)))); */
                              } else {}
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    AppWidgetSize.dimen_15),
                                color: Theme.of(context).primaryColor,
                              ),
                              alignment: Alignment.center,
                              width: double.maxFinite,
                              padding: EdgeInsets.symmetric(
                                  vertical: AppWidgetSize.dimen_16),
                              child: const TextWidget(
                                AppConstants.loginCap,
                                color: Colors.white,
                                fontweight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: AppWidgetSize.dimen_15,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  TypeAheadField<dynamic> suggestionField(
      BuildContext context,
      TextEditingController controller,
      String hintText,
      FutureOr<Iterable<dynamic>> Function(String) suggestionsCallback,
      {bool obscureText = false}) {
    return TypeAheadField(
      hideOnEmpty: true,
      hideOnError: true,
      getImmediateSuggestions: false,
      textFieldConfiguration: TextFieldConfiguration(
        controller: controller,
        autofocus: true,
        obscureText: obscureText,
        style: DefaultTextStyle.of(context)
            .style
            .copyWith(fontStyle: FontStyle.italic),
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Colors.white54.withOpacity(0.6),
          hintStyle: TextStyle(
              fontSize: AppWidgetSize.dimen_13,
              color: Theme.of(context).canvasColor),
          labelStyle: TextStyle(
              fontSize: AppWidgetSize.dimen_14,
              color: Theme.of(context).canvasColor),
          contentPadding: EdgeInsets.symmetric(
              vertical: AppWidgetSize.dimen_20,
              horizontal: AppWidgetSize.dimen_10),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppWidgetSize.dimen_10),
              borderSide:
                  BorderSide(width: 0, color: Theme.of(context).canvasColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppWidgetSize.dimen_10),
              borderSide:
                  BorderSide(width: 0, color: Theme.of(context).canvasColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppWidgetSize.dimen_10),
              borderSide:
                  BorderSide(width: 0, color: Theme.of(context).canvasColor)),
        ),
      ),
      suggestionsBoxDecoration: SuggestionsBoxDecoration(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        color: Theme.of(context).scaffoldBackgroundColor,
        constraints: BoxConstraints(
            maxWidth: 200,
            maxHeight: userList.isEmpty
                ? 0
                : ((AppWidgetSize.dimen_70) * (userList.length))),
      ),
      suggestionsCallback: suggestionsCallback,
      animationDuration: Duration.zero,
      itemBuilder: (context, suggestion) {
        return Container(
          padding: const EdgeInsets.all(4),
          height: AppWidgetSize.dimen_70,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Theme.of(context).dividerColor, width: 0.3))),
          child: ListTile(
            tileColor: Theme.of(context).scaffoldBackgroundColor,
            leading: AppImages.appIcon(),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: TextWidget(suggestion["username"]),
            ),
            subtitle: const Text('••••••••'),
          ),
        );
      },
      onSuggestionSelected: (suggestion) {
        phoneNo.text = suggestion['username'];
        password.text = suggestion["password"];
      },
    );
  }

  _showMyDialog(cxt) async {
    return showDialog(
      context: cxt,
      barrierColor: Colors.black.withOpacity(0.5),
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(AppWidgetSize.dimen_10)),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                  onTap: () {
                    appRoute.pop();
                    clearPinfield();
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
                      ?.copyWith(fontSize: AppWidgetSize.dimen_17),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: AppWidgetSize.dimen_7),
                  child: TextWidget(
                    "${AppConstants.otpVerified}+91${phoneNo.text}",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: AppWidgetSize.dimen_10),
                  child: ValueListenableBuilder(
                    valueListenable: valueNotifier,
                    builder: (context, value, child) {
                      return TextFieldPin(
                          textController: textEditingController,
                          autoFocus: true,
                          codeLength: otpCodeLength,
                          alignment: MainAxisAlignment.center,
                          defaultBoxSize: AppWidgetSize.dimen_46,
                          margin: AppWidgetSize.dimen_10,
                          selectedBoxSize: AppWidgetSize.dimen_46,
                          textStyle:
                              TextStyle(fontSize: AppWidgetSize.dimen_16),
                          defaultDecoration: _pinPutDecoration.copyWith(
                              border: Border.all(
                                  color: Theme.of(context).canvasColor)),
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
                      margin: EdgeInsets.symmetric(
                          vertical: AppWidgetSize.dimen_10),
                      padding: EdgeInsets.symmetric(
                          vertical: AppWidgetSize.dimen_14),
                      child: const TextWidget(
                        AppConstants.validateOtp,
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
                          Timer(const Duration(milliseconds: 4000), () {
                            registrationBloc.add(RegistrationRequestEvent(
                                reg.RegistrationRequest(
                                    request: reg.Request(
                                        data: reg.Data(
                                            mobNo: "+91${phoneNo.text}"),
                                        appID: AppConstants.appId))));
                          });
                        },
                        child: TextWidget(
                          AppConstants.resendOtp,
                          size: AppWidgetSize.dimen_15,
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

  @override
  void dispose() {
    debugPrint("Form widget disposed");
    super.dispose();
  }
}
