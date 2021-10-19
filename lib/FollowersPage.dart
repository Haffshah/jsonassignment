import 'package:flutter/material.dart';
import 'package:jsonassignment/models/profile_model.dart';

class FollowersPage extends StatefulWidget {
  const FollowersPage({Key? key}) : super(key: key);

  @override
  _FollowersPageState createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage> {
  ProfileData? profileData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Followers"),
      ),
      backgroundColor: Color(0xffEADEB8),
      body: Container(width: double.infinity,
        height: 150,
        color: Colors.white,
        child: ListView.builder(
          itemCount: profileData?.peopleFollows?.length ?? 0,
          itemBuilder: (_, int i) {
            return Center(
              child: Text(
                '${profileData?.peopleFollows?[i]}',
                style: TextStyle(color: Colors.blue),
              ),
            );
          },
        ),
      ),
    );
  }
}
