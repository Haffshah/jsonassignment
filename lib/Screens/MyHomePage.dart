import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jsonassignment/Screens/FollowersPage.dart';
import 'package:jsonassignment/models/profile_model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ProfileData? profileData;

  @override
  void initState() {
    loadProfile();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<dynamic> _loadProfileAssets() async {
    return await rootBundle.loadString('assets/profiledata.json');
  }

  Future loadProfile() async {
    String jsonString = await _loadProfileAssets();
    final jsonResponse = json.decode(jsonString);
    setState(() {
      profileData = ProfileData.fromJson(jsonResponse);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 160.0, right: 10),
        child: FloatingActionButton(
          elevation: 0,
          backgroundColor: Color(0xffFDB643),
          onPressed: () {},
          child: Icon(
            CupertinoIcons.add,
            size: 25,
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              child: Container(
                child: Image.asset(
                  profileData?.image ?? "0",
                  fit: BoxFit.cover,
                ),
                height: MediaQuery.of(context).size.height / 1.60,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${profileData?.firstname?.toUpperCase()} ${profileData?.lastname?.toUpperCase()}",
                              style: TextStyle(
                                  fontFamily: 'Avenir',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              ("${profileData?.region ?? " "},${profileData?.country}"),
                              style: greyFont(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 19,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              height: 50,
              child: Text(
                ("${profileData?.bio}"),
                maxLines: 5,
                style: greyFont(),
              ),
            ),
            Spacer(),
            Container(
              alignment: Alignment.bottomCenter,
              color: Color(0xffFFF8ED),
              height: 85,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20))),
                          context: context,
                          builder: (context) {
                            return Bottomsheet(
                              profileData: profileData,
                            );
                          });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Posts',
                          style: greyFont(),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          "${profileData?.post}",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'Avenir',
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => FollowersPage(
                            profileData: profileData,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Followers',
                          style: greyFont(),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          "${profileData?.followers}",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'Avenir',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Following',
                        style: greyFont(),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        "${profileData?.following}",
                        style: TextStyle(fontFamily: 'Avenir', fontSize: 18.0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle greyFont() => TextStyle(
    fontSize: 10,
    color: Colors.grey,
    fontFamily: 'Avenir',
  );

  Widget buildSheet() => Column(
    children: [],
  );
}

class Bottomsheet extends StatelessWidget {
  const Bottomsheet({
    Key? key,
    required this.profileData,
  }) : super(key: key);

  final ProfileData? profileData;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      builder: (_, controller) => Container(
        color: Color(0xff191A19),
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: profileData?.peopleFollows?.length ?? 0,
          itemBuilder: (_, int i) {
            return Container(
                color: Color(0xff191A19),
                child: ListTile(
                  leading: Text(
                    '${i + 1}.',
                    style: font22,
                  ),
                  title: Text(
                    '${profileData?.peopleFollows?[i]}',
                    style: font22,
                  ),
                ));
          },
        ),
      ),
    );
  }

  TextStyle get font22 => TextStyle(
      color: Color(0xffD1E8E4),
      fontFamily: 'Avenir',
      fontWeight: FontWeight.w500,
      wordSpacing: 1,
      fontSize: 22);
}
