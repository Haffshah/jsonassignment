import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      body: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
            child: Container(
              child: Image.network(
                profileData!.image ?? " ",
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
                            "${profileData!.firstname!.toUpperCase()} ${profileData!.lastname!.toUpperCase()}",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            ("${profileData!.region ?? " "},${profileData!.country}"),
                            style: TextStyle(fontSize: 10, color: Colors.grey),
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
              ("${profileData!.bio}"),
              maxLines: 5,
              style: TextStyle(fontSize: 10, color: Colors.grey),
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Posts',
                      style: TextStyle(color: Colors.grey, fontSize: 10.0),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      "${profileData?.post}",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Followers',
                      style: TextStyle(color: Colors.grey, fontSize: 10.0),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      "${profileData?.followers}",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Following',
                      style: TextStyle(color: Colors.grey, fontSize: 10.0),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      "${profileData?.following}",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
