import 'package:flutter/material.dart';
import 'package:jsonassignment/models/profile_model.dart';

class FollowersPage extends StatefulWidget {
  final ProfileData? profileData;
  const FollowersPage({Key? key, required this.profileData}) : super(key: key);

  @override
  _FollowersPageState createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Color(0xff191A19),
        leading: IconButton(
          color: Color(0xff191A19),
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xffD1E8E4),
        title: Text(
          "Followers",
          style: TextStyle(color: Color(0xff191A19)),
        ),
      ),
      backgroundColor: Color(0xffEADEB8),
      body: Container(
        width: double.infinity,
        child: ListView.builder(
          itemCount: widget.profileData?.peopleFollows?.length ?? 0,
          itemBuilder: (_, int i) {
            return Container(
              color: Color(0xff191A19),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              child: ListTile(
                leading: Text(
                  '${i + 1}.',
                  style: font22,
                ),
                title: Text(
                  '${widget.profileData?.peopleFollows?[i]}',
                  style: font22,
                ),
              ),
            );
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
