import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inbridge/constants/style.dart';
import 'package:inbridge/services/util/ext.dart';
import 'package:inbridge/services/util/language.dart';
import 'package:inbridge/views/widgets/appbar.dart';
import 'package:inbridge/views/widgets/bottuns.dart';
import 'package:inbridge/views/widgets/popup.dart';
import 'package:inbridge/views/widgets/text_field.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.bgcolor,
      appBar: appBar('Create Task'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Gap(40),
            CustomTextField(
              hint: 'Title',
              controller: TextEditingController(),
              trailing: false,
            ),
            CustomTextField(
              hint: 'Description',
              controller: TextEditingController(),
              maxLines: 3,
              padding: 10,
              height: 65,
              trailing: false,
            ),
            CustomTextField(
              hint: 'Guidlines',
              controller: TextEditingController(),
              trailing: false,
            ),
            InkWell(
              onTap: () {
                datePopup(day: true, minDate: DateTime.now());
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                margin: const EdgeInsets.symmetric(horizontal: 15)
                    .copyWith(bottom: 10),
                height: 50,
                width: context.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(smallRadius),
                    border: Border.all(
                        color: context.invertedColor.withOpacity(.3))),
                child: Txt('DeadLine',
                    color: context.invertedColor.withOpacity(.4)),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              margin: const EdgeInsets.symmetric(horizontal: 15),
              height: 50,
              width: context.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(smallRadius),
                  border:
                      Border.all(color: context.invertedColor.withOpacity(.3))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Txt('Attached to',
                      color: context.invertedColor.withOpacity(.4)),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: context.iconColor,
                    size: 25,
                  )
                ],
              ),
            ),
            const Gap(40),
            Center(
              child: gradientButton(
                  function: () {
                    Navigator.pop(context);
                  },
                  w: context.w * .7,
                  text: "Create"),
            )
          ],
        ),
      ),
    );
  }
}
