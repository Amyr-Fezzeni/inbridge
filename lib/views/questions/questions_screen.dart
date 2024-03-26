import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inbridge/constants/style.dart';
import 'package:inbridge/services/util/ext.dart';
import 'package:inbridge/services/util/language.dart';
import 'package:inbridge/services/util/logic_service.dart';
import 'package:inbridge/views/widgets/appbar.dart';
import 'package:inbridge/views/widgets/bottuns.dart';
import 'package:inbridge/views/widgets/default_screen.dart';
import 'package:inbridge/views/widgets/loader.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  List<Map<String, dynamic>> questions = [
    {
      "question": "Which concept do you want to work on ?",
      "options": {
        "9antra training": true,
        "9antra project": false,
        "9antra Kids": false,
      }
    },
    {
      "question": "Please select a category !",
      "options": {
        "Meme": true,
        "Quiz": false,
        "Feedback": false,
        "Success story": false,
        "Training": false,
        "Trick": false,
        "Partnership": false,
        "Quotes": false
      }
    },
    {
      "question": "Choose a type",
      "options": {"Simple": true, "Collection": false}
    },
    {
      "question": "On which platform ?",
      "options": {
        "Facebook": {
          "status": false,
          "icon": 'assets/icons/social media/facebook.svg'
        },
        "Instagram": {
          "status": false,
          "icon": 'assets/icons/social media/instagram.svg'
        },
        "Linkedin": {
          "status": false,
          "icon": 'assets/icons/social media/inkedin.svg'
        },
        "TikTok": {
          "status": false,
          "icon": 'assets/icons/social media/tiktok.svg'
        }
      }
    },
  ];
  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Questions'),
      backgroundColor: context.bgcolor,
      body: Stepper(
        elevation: 0,
        type: StepperType.horizontal,
        currentStep: currentStep,
        margin: const EdgeInsets.only(left: 45, right: 15),
        onStepCancel: () =>
            currentStep == 0 ? null : setState(() => currentStep -= 1),
        onStepContinue: () {
          if (currentStep != 2) {
            setState(() => currentStep += 1);
          }
        },
        onStepTapped: (step) => setState(() => currentStep = step),
        connectorColor: MaterialStateColor.resolveWith((states) =>
            states.contains(MaterialState.selected)
                ? context.primaryColor
                : Colors.grey.shade400),
        controlsBuilder: (context, details) =>
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          if (currentStep != 0)
            InkWell(
              onTap: () =>
                  currentStep == 0 ? null : setState(() => currentStep -= 1),
              child: Icon(Icons.arrow_back_ios,
                  color: context.iconColor, size: 30),
            ),
          const Gap(10),
          gradientButton(
              function: () async {
                if (currentStep == 0) {
                  setState(() => currentStep += 1);
                  return;
                }
                if (currentStep == 1) {
                  setState(() => currentStep += 1);
                  return;
                }
                if (currentStep == 2) {
                  context.replaceWith(const DefaultScreen(
                      title: "Post Template", appbar: true));
                }
              },
              text: currentStep == 2 ? "Select template" : "Next",
              w: currentStep == 2 ? 180 : 150),
        ]),
        steps: [
          Step(
            state: currentStep == 0
                ? StepState.editing
                : currentStep > 0
                    ? StepState.complete
                    : StepState.disabled,
            isActive: currentStep == 0,
            title: SizedBox(child: Txt("")),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Txt(questions.first['question'], bold: true),
                const Gap(10),
                for (var key
                    in (questions.first['options'] as Map<String, bool>)
                        .keys) ...[
                  checkBox(questions.first['options'][key], capitalize(key),
                      () => {}),
                  const Gap(10)
                ],
                const Gap(20)
              ],
            ),
          ),
          Step(
            state: currentStep == 1
                ? StepState.editing
                : currentStep > 1
                    ? StepState.complete
                    : StepState.disabled,
            isActive: currentStep == 1,
            title: Txt(""),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Txt(questions[1]['question'], bold: true),
                const Gap(10),
                for (var key
                    in (questions[1]['options'] as Map<String, bool>).keys) ...[
                  checkBox(questions[1]['options'][key], capitalize(key), () {
                    setState(() {
                      for (var k
                          in (questions[1]['options'] as Map<String, bool>)
                              .keys
                              .where((option) => option != key)) {
                        questions[1]['options'][k] = false;
                      }
                      questions[1]['options'][key] = true;
                    });
                  }),
                  const Gap(10)
                ],
                const Gap(20)
              ],
            ),
          ),
          Step(
              state: currentStep == 2
                  ? StepState.editing
                  : currentStep > 2
                      ? StepState.complete
                      : StepState.disabled,
              isActive: currentStep == 2,
              title: Txt(''),
              content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Txt(questions[2]['question'], bold: true),
                    const Gap(10),
                    for (var key
                        in (questions[2]['options'] as Map<String, bool>)
                            .keys) ...[
                      checkBox(questions[2]['options'][key], capitalize(key),
                          () {
                        setState(() {
                          for (var k
                              in (questions[2]['options'] as Map<String, bool>)
                                  .keys
                                  .where((option) => option != key)) {
                            questions[2]['options'][k] = false;
                          }
                          questions[2]['options'][key] = true;
                        });
                      }),
                      const Gap(10)
                    ],
                    const Gap(20),
                    Txt(questions[3]['question'], bold: true),
                    const Gap(10),
                    Center(
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          for (var key in (questions[3]['options']
                                  as Map<String, Map<String, dynamic>>)
                              .keys) ...[
                            InkWell(
                              onTap: () {
                                setState(() {
                                  for (var k in (questions[3]['options']
                                          as Map<String, Map<String, dynamic>>)
                                      .keys
                                      .where((option) => option != key)) {
                                    questions[3]['options'][k]['status'] =
                                        false;
                                  }
                                  questions[3]['options'][key]['status'] = true;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                decoration: BoxDecoration(
                                    color: questions[3]['options'][key]
                                            ['status']
                                        ? context.primaryColor.withOpacity(.5)
                                        : Colors.transparent,
                                    border: Border.all(
                                        color: questions[3]['options'][key]
                                                ['status']
                                            ? context.primaryColor
                                                .withOpacity(.2)
                                            : context.invertedColor
                                                .withOpacity(.3)),
                                    borderRadius:
                                        BorderRadius.circular(bigRadius)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    svgImage(
                                        questions[3]['options'][key]['icon']),
                                    const Gap(10),
                                    Txt(capitalize(key)),
                                    // checkBox(questions[3]['options'][key]['status'],
                                    //     capitalize(key), () {
                                    //   setState(() {
                                    //     for (var k in (questions[3]['options']
                                    //             as Map<String,
                                    //                 Map<String, dynamic>>)
                                    //         .keys
                                    //         .where((option) => option != key)) {
                                    //       questions[3]['options'][k]['status'] =
                                    //           false;
                                    //     }
                                    //     questions[3]['options'][key]['status'] =
                                    //         true;
                                    //   });
                                    // }),
                                  ],
                                ),
                              ),
                            ),
                            const Gap(10)
                          ],
                        ],
                      ),
                    ),
                    const Gap(70)
                  ]))
        ],
      ),
    );
  }
}
