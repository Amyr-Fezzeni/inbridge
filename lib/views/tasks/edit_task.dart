import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inbridge/constants/style.dart';
import 'package:inbridge/services/util/ext.dart';
import 'package:inbridge/services/util/language.dart';
import 'package:inbridge/views/widgets/bottuns.dart';
import 'package:inbridge/views/widgets/popup.dart';
import 'package:inbridge/views/widgets/text_field.dart';

class EditTask extends StatefulWidget {
  const EditTask({super.key});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: .7,
      maxChildSize: .9,
      minChildSize: .2,
      snap: true,
      snapSizes: const [.2, .4, .6, .8],
      builder: (context, scrollController) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(top: 20),
        decoration: BoxDecoration(
            color: context.bgcolor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(bigRadius),
                topRight: Radius.circular(bigRadius))),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Txt("Edit Task", bold: true)),
              const Gap(20),
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
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                margin: const EdgeInsets.symmetric(horizontal: 15),
                height: 50,
                width: context.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(smallRadius),
                    border: Border.all(
                        color: context.invertedColor.withOpacity(.3))),
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
                      text: "Save",
                      w: context.w * .7)),
              Center(
                  child: gradientButton(
                      function: () {
                        Navigator.pop(context);
                      },
                      colors: [red, red],
                      text: "Delete",
                      w: context.w * .7)),
            ],
          ),
        ),
      ),
    );
  }
}
