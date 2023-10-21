import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:todolist/core/utils/custom_fade_in_page_route.dart';
import 'package:todolist/core/utils/enums.dart';
import 'package:todolist/core/utils/extensions.dart';
import 'package:todolist/core/utils/theme.dart';
import 'package:todolist/features/shared/presentation/widgets/custom_border_widget.dart';
import 'package:todolist/features/shared/presentation/widgets/custom_button_widget.dart';


bool isContainingAnyLink(String? text) {
  RegExp exp = RegExp(r"(?:(?:(?:ftp|http)[s]*:\/\/|www\.)[^\.]+\.[^ \n]+)");
  Iterable<RegExpMatch> matches = exp.allMatches(text ?? '');
  return matches.isNotEmpty ? true : false;
}

bool isPhoneNumber(String? text) {
  RegExp exp = RegExp(r'[+0]\d+[\d-]+\d');
  Iterable<RegExpMatch> matches = exp.allMatches(text ?? '');
  return matches.isNotEmpty ? true : false;
}

bool isEmail(String? text) {
  RegExp exp = RegExp(r'[^@\s]+@([^@\s]+\.)+[^@\W]+');
  Iterable<RegExpMatch> matches = exp.allMatches(text ?? '');
  return matches.isNotEmpty ? true : false;
}

Color getRandomColor() {
  var list = codeViewTheme.values.toList();

  // generates a new Random object
  final random = Random();

  // generate a random index based on the list length
  // and use it to retrieve the element
  final style = list[random.nextInt(list.length)];
  return style.color ?? kAppBlue;
}



/// Use this method to execute code that requires context in init state
onWidgetBindingComplete(
    {required Function() onComplete, int milliseconds = 1000}) {
  WidgetsBinding.instance.addPostFrameCallback(
          (_) => Timer(Duration(milliseconds: milliseconds), onComplete));
}


/// Get Initials
String getInitials(String? words) {
  if (words.isNullOrEmpty()) {
    return "";
  }
  return words!.isNotEmpty
      ? words.trim().split(' ').map((l) => l[0]).take(2).join()
      : '';
}

/// Extract urls out of text
List<String> getLinksFromText({required String text}) {
  RegExp exp = RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
  Iterable<RegExpMatch> matches = exp.allMatches(text);

  final List<String> links =
  matches.map((match) => text.substring(match.start, match.end)).toList();
  return links;
}

/// Get formatted date
String getTimeAgo(DateTime date) {
  final readableTime = timeago.format(date);
  return readableTime;
}

String getFormattedDateWithIntl(DateTime date, {String format = 'MMM yyyy'}) {
  var formatBuild = DateFormat(format);
  var dateString = formatBuild.format(date);
  return dateString;
}

Future<Object?> pushScreen(
    BuildContext context, Widget classObject,
    {bool replaceAll = false,
      fullscreenDialog = false,
      rootNavigator = false,
      bool fadeIn = false,
      dynamic args = const {}}) {
  if (replaceAll) {
    return Navigator.of(context, rootNavigator: rootNavigator)
        .pushAndRemoveUntil(
      fadeIn ?
      CustomFadeInPageRoute(classObject, color: kAppBlack)
      : MaterialPageRoute(
          builder: (context) => classObject,
          settings: RouteSettings(arguments: args)),
          (Route<dynamic> route) => false,
    );
  } else {
    return Navigator.of(context, rootNavigator: rootNavigator).push(
        fadeIn ?
        CustomFadeInPageRoute(classObject, color: kAppBlack)
        : MaterialPageRoute(
            builder: (context) => classObject,
            fullscreenDialog: fullscreenDialog,
            settings: RouteSettings(arguments: args)));
  }
}


// Handy method to show bottom sheets with ease
Future<void> showCustomBottomSheet(BuildContext context, {required Widget child, bool? showDragHandle}){
  final theme = Theme.of(context);
  return showModalBottomSheet<void>(
    enableDrag: true,
    context: context,
    showDragHandle: showDragHandle,
    backgroundColor: theme.colorScheme.primary,
    isScrollControlled: true,
    builder: (BuildContext ctx) {
      return Padding(padding: EdgeInsets.only(
        bottom:  MediaQuery.of(ctx).viewInsets.bottom),
        child: child,
      );
    },
  );
}


void showConfirmDialog(BuildContext context,
    {required VoidCallback onConfirmTapped,
      VoidCallback? onCancelTapped,
      required String title,
      bool showCancelButton = true,
      bool isDismissible = true,
      bool showCloseButton = true,
      String? subtitle,
      Map<String, dynamic> data = const {},
      String? confirmAction,
      String? cancelAction}) {
  showModalBottomSheet<void>(
      isScrollControlled: true,
      isDismissible: isDismissible,
      backgroundColor: Theme.of(context).colorScheme.primary,
      context: context,
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 10,
                bottom: MediaQuery.of(ctx).viewInsets.bottom),
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (showCloseButton) ...{
                    Align(
                      alignment: Alignment.topRight,
                      child: CloseButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    const CustomBorderWidget(),
                  },
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    title,
                    style: Theme.of(ctx).textTheme.titleLarge,
                  ),
                  if (subtitle != null) ...{
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      subtitle,
                      style:
                      TextStyle(color: Theme.of(ctx).colorScheme.onPrimary),
                    ),
                  },
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: CustomButtonWidget(
                            text: confirmAction ?? "Confirm",
                            expand: true,
                            appearance: Appearance.error,
                            onPressed: () {
                              Navigator.of(ctx).pop();

                              onConfirmTapped();

                              // switch(action) {
                              //   case DialogAction.deleteThread:
                              //     state._deleteThread(data);
                              //     break;
                              //   case DialogAction.logout:
                              //     state._logout();
                              //     break;
                              //   default:
                              //     break;
                              // }
                            },
                          )),
                      if (showCancelButton) ...[
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: CustomButtonWidget(
                              text: cancelAction ?? "Cancel",
                              expand: true,
                              appearance: Appearance.secondary,
                              onPressed: () {
                                Navigator.of(ctx).pop();
                                onCancelTapped?.call();
                              },
                            )),
                      ]
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      });
}




pop<T extends Object?>(BuildContext context, [T? result]) {
  Navigator.of(context).pop(result);
}



String formatHumanReadable(int numberToFormat){
  var formattedNumber = NumberFormat.compactCurrency(decimalDigits: 2, symbol: '',).format(numberToFormat);
  return formattedNumber.endsWith('.00')  ? formattedNumber.replaceAll('.00','')  : formattedNumber ;
}


DateTime convertYearMonthToDate({required String year, required String month}){
  return DateFormat.LLLL()
      .add_y()
      .parse('$month $year');
}

///MediaQuery Width
double width(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

///MediaQuery Height
double height(BuildContext context) {
  return MediaQuery.of(context).size.height;
}
ThemeData theme(BuildContext context){
  return Theme.of(context);
}

Future<bool> isNetworkConnected () async {

  final connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    // I am connected to a mobile network.
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    // I am connected to a wifi network.
    return true;
  } else if (connectivityResult == ConnectivityResult.ethernet) {
    // I am connected to a ethernet network.
    return true;
  } else if (connectivityResult == ConnectivityResult.vpn) {
    // I am connected to a vpn network.
    // Note for iOS and macOS:
    // There is no separate network interface type for [vpn].
    // It returns [other] on any device (also simulator)
    return true;
  } else if (connectivityResult == ConnectivityResult.bluetooth) {
    // I am connected to a bluetooth.
    return false;
  } else if (connectivityResult == ConnectivityResult.other) {
    // I am connected to a network which is not in the above mentioned networks.
    return false;
  } else if (connectivityResult == ConnectivityResult.none) {
    // I am not connected to any network.
    return false;
  }

  return false;
}