import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inbridge/constants/constants.dart';
import 'package:inbridge/constants/style.dart';
import 'package:inbridge/services/util/ext.dart';
import 'package:inbridge/services/util/language.dart';
import 'package:inbridge/services/util/logic_service.dart';
import 'package:inbridge/views/tasks/create_task.dart';
import 'package:inbridge/views/tasks/edit_task.dart';
import 'package:inbridge/views/widgets/appbar.dart';
import 'package:inbridge/views/widgets/bottuns.dart';
import 'package:inbridge/views/widgets/loader.dart';
import 'package:inbridge/views/widgets/text_field.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  bool showPublic = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Task List", leading: false),
      backgroundColor: context.bgcolor,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: FloatingActionButton.extended(
            backgroundColor: context.primaryColor,
            onPressed: () {
              context.moveTo(const CreateTask());
            },
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 20,
                ),
                const Gap(10),
                Txt("Add Task", color: Colors.white)
              ],
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(20),
              // Wrap(
              //   spacing: 10,
              //   runSpacing: 10,
              //   children: [
              //     borderButton("In progress"),
              //     borderButton("Completed"),
              //     borderButton("Archived"),
              //     borderButton("Failed"),
              //   ],
              // ),
              CustomTextField(
                hint: txt('Search'),
                controller: TextEditingController(),
                leadingIcon: Icon(Icons.search,
                    color: context.invertedColor.withOpacity(.7), size: 25),
                icon: svgImage(filter,
                    size: 25, function: () {}, color: context.iconColor),
                marginH: 0,
                height: 50,
              ),
              const Gap(20),
              Row(
                children: [
                  tabItem(lable: txt('Public'), status: true),
                  tabItem(lable: txt('Private'), status: false),
                ],
              ),
              ...List.generate(showPublic ? 15 : 3, (index) => taskModelCard()),
              const Gap(20)
            ],
          ),
        ),
      ),
    );
  }

  Widget tabItem({required String lable, required bool status}) {
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => showPublic = status),
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: showPublic == status
                          ? context.primaryColor
                          : Colors.grey,
                      width: 2))),
          height: 40,
          child: Center(
            child: Txt(
              lable,
              bold: showPublic == status,
              // size: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget taskModelCard() {
    return Builder(
        builder: (context) => Card(
              color: context.bgcolor,
              surfaceTintColor: pink,
              child: Container(
                padding: const EdgeInsets.all(15),
                width: context.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.check,
                              color: Colors.green, size: 25),
                          const Gap(10),
                          InkWell(
                              onTap: () =>
                                  context.showPopUpScreen(const EditTask()),
                              child: const Icon(Icons.edit_note,
                                  color: pink, size: 20)),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.assignment_outlined,
                            color: context.primaryColor, size: 25),
                        const Gap(10),
                        Txt('Task Title', bold: true),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 35),
                      child: Txt('2 days', color: context.iconColor, size: 10),
                    ),
                    Txt(loremText(), color: context.iconColor, maxLines: 2)
                  ],
                ),
              ),
            ));
  }
}
