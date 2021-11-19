import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jsonassignment/Constants/api_constant.dart';
import 'package:jsonassignment/login/login.dart';
import 'package:jsonassignment/models/Followers_model.dart';
import 'package:jsonassignment/screens/FollowersPage.dart';
import 'package:jsonassignment/models/profile_model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jsonassignment/screens/MobileSpecification.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ProfileData? profileData;

  List<FollowersData> arrFollowers = [];

  @override
  void initState() {
    loadProfile();
    getFollowersData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getFollowersData() async {
    var url = Uri.parse('${APIConstant.baseUrl}${APIConstant.followersList}');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');

    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      final jsonRes = json.decode(response.body);
      FollowersListModel aFollowersListModel =
          FollowersListModel.fromJson(jsonRes);
      print(aFollowersListModel.followersData?.length);

      setState(() {
        arrFollowers = aFollowersListModel.followersData ?? [];
      });
    }
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
      backgroundColor: Color(0xff191A19),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  CupertinoPageRoute(builder: (context) => LoginScreenForm()));
            },
            icon: Icon(
              Icons.arrow_forward_rounded,
              color: Color(0xff191A19),
              size: 28,
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 165, right: 10),
        child: FloatingActionButton(
          elevation: 0,
          backgroundColor: Color(0xffFDB643),
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) =>
                      MobileSpecification(profileData: profileData)),
            );
          },
          child: Icon(
            CupertinoIcons.add,
            size: 25,
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                child: Container(
                  child: Image.asset(
                    profileData?.image ?? "assets/images/photo.png",
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 10),
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
                                    fontSize: 15, fontWeight: FontWeight.w700,color: Color(0xffA2D2FF)),
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
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
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
                              backgroundColor: Color(0xff191A19),
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
                              "${profileData?.peopleFollows?.length}",
                              style: font18(),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
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
                              "${arrFollowers.length}",
                              style: font18(),
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
                            style: font18(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle font18() {
    return TextStyle(
      fontSize: 18.0,
    );
  }

  TextStyle greyFont() => TextStyle(
        fontSize: 10,
        color: Colors.grey,
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(40.0, 20, 40, 20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xffA2D2FF),
              ),
              width: 80,
              height: 3,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.47,
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
        ],
      ),
    );
  }

  TextStyle get font22 => TextStyle(
      color: Color(0xffD1E8E4),
      fontWeight: FontWeight.w500,
      wordSpacing: 1,
      fontSize: 18);
}
