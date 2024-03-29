import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inbridge/constants/style.dart';
import 'package:inbridge/services/util/ext.dart';
import 'package:inbridge/services/util/navigation_service.dart';
import 'package:provider/provider.dart';
import 'package:inbridge/providers/theme_notifier.dart';
import 'package:inbridge/services/util/language.dart';
import 'package:inbridge/views/widgets/bottuns.dart';

Future<dynamic> popup(BuildContext context, String confirmText,
    {String? title,
    String? description,
    Function? confirmFunction,
    bool cancel = true}) {
  var style = context.read<ThemeNotifier>();
  var size = MediaQuery.of(context).size;
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: context.isDark
              ? const Color.fromARGB(255, 33, 33, 33)
              : Colors.white,
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: SizedBox(
            // height: 180,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: SizedBox(
                      child: Text(
                        title,
                        // maxLines: 2,
                        textAlign: TextAlign.center,
                        style: style.text18.copyWith(fontSize: 22),
                      ),
                    ),
                  ),
                if (description != null)
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    width: double.infinity,
                    // height: 1.5 * 10,
                    child: Text(
                      description,
                      // maxLines: 2,
                      textAlign: TextAlign.center,
                      style: style.text18.copyWith(fontSize: 15),
                    ),
                  ),
                SizedBox(
                  height: 60,
                  width: size.width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (cancel)
                        gradientButton(
                            function: () => Navigator.pop(context),
                            text: txt("Cancel"),
                            h: 40,
                            w: 140,
                            colors: [
                              darkRed,
                              darkRed,
                            ]),
                      gradientButton(
                          function: () {
                            Navigator.pop(context);
                            if (confirmFunction != null) {
                              confirmFunction();
                            }
                          },
                          text: confirmText,
                          colors: [context.primaryColor, context.primaryColor],
                          h: 40,
                          w: 140),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

// Alert Dialog

Future<DateTime?> datePopup(
    {DateTime? minDate,
    DateTime? maxDate,
    DateTime? initDate,
    bool day = false,
    String title = ''}) async {
  final context = NavigationService.navigatorKey.currentContext!;
  DateTime? date;
  DateTime? tempDate = initDate ?? DateTime.now();
  await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: SizedBox(
                    child: Text(
                      title,
                      // maxLines: 2,
                      textAlign: TextAlign.center,
                      style: context.text.copyWith(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                    height: 100,
                    child: CupertinoDatePicker(
                        mode: day
                            ? CupertinoDatePickerMode.date
                            : CupertinoDatePickerMode.monthYear,
                        initialDateTime: initDate ?? DateTime.now(),
                        maximumDate: maxDate,
                        maximumYear: maxDate?.year,
                        minimumDate: minDate,
                        onDateTimeChanged: (d) {
                          tempDate = d;
                        })),
                SizedBox(
                  height: 60,
                  width: context.w * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      gradientButton(
                          function: () => Navigator.pop(context),
                          text: txt("Cancel"),
                          h: 40,
                          w: 140,
                          raduis: smallRadius,
                          colors: [darkRed, darkRed]),
                      gradientButton(
                          function: () {
                            Navigator.pop(context);
                            date = tempDate;
                          },
                          text: txt("Confirm"),
                          colors: [context.primaryColor, context.primaryColor],
                          h: 40,
                          raduis: smallRadius,
                          w: 140),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      });
  debugPrint('Value:$date');
  return date;
}
