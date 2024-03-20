import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inbridge/constants/constants.dart';
import 'package:inbridge/constants/fixed_messages.dart';
import 'package:inbridge/constants/style.dart';
import 'package:inbridge/models/user.dart';
import 'package:inbridge/services/user_service.dart';
import 'package:inbridge/services/util/ext.dart';
import 'package:inbridge/services/util/language.dart';
import 'package:inbridge/views/widgets/appbar.dart';
import 'package:inbridge/views/widgets/bottuns.dart';
import 'package:inbridge/views/widgets/loader.dart';

class PublicProfile extends StatefulWidget {
  final String userId;
  const PublicProfile({super.key, required this.userId});

  @override
  State<PublicProfile> createState() => _PublicProfileState();
}

class _PublicProfileState extends State<PublicProfile> {
  late Future<UserModel?> function;

  @override
  void initState() {
    function = UserService.getUserById(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Profile'),
      backgroundColor: context.bgcolor,
      body: FutureBuilder<UserModel?>(
        future: function,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: cLoader());
          }
          if (snapshot.connectionState == ConnectionState.done) {
            try {
              if (snapshot.data != null) {
                UserModel user = snapshot.data!;
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(children: [
                      SizedBox(
                        height: 180,
                        child: Stack(
                          children: [
                            Container(
                              height: 120,
                              decoration: BoxDecoration(
                                  color: context.bgcolor,
                                  boxShadow: defaultShadow,
                                
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 110,
                                      width: 110,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: context.bgcolor,
                                          borderRadius:
                                              BorderRadius.circular(80)),
                                      child: profileIcon(size: 90),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Txt(user.getFullName(), size: 20, bold: true),
                          const Gap(5),
                          Icon(
                            Icons.verified,
                            color: context.primaryColor,
                            size: 25,
                          )
                        ],
                      ),
                      const Gap(20),
                    
                    ]),
                  ),
                );
              } else {
                return Center(child: Txt(defaultError));
              }
            } catch (e) {
              return Center(child: Txt(defaultError));
            }
          }
          return const SizedBox();
        },
      ),
    );
  }
}
