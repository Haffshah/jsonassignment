import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jsonassignment/Constants/api_constant.dart';
import 'package:jsonassignment/models/Followers_model.dart';
import 'package:jsonassignment/models/profile_model.dart';
import 'package:http/http.dart' as http;

class FollowersPage extends StatefulWidget {
  final ProfileData? profileData;

  const FollowersPage({Key? key, required this.profileData}) : super(key: key);

  @override
  _FollowersPageState createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage> {
  List<FollowersData> arrFollowers = [];
  bool isLoading = false;

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    getFollowersData();

    super.initState();
  }

  getFollowersData() async {
    var url = Uri.parse('${APIConstant.baseUrl}${APIConstant.followersList}');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');

    if (response.statusCode == 200) {
      try {
        final jsonRes = json.decode(response.body);
        FollowersListModel aFollowersListModel =
            FollowersListModel.fromJson(jsonRes);
        print(aFollowersListModel.followersData?.length);

        setState(() {
          arrFollowers = aFollowersListModel.followersData ?? [];
          isLoading = false;
        });
      } catch (e) {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff191A19),
      appBar: AppBar(
        toolbarHeight: 70,
        elevation: 0,
        leading: IconButton(
          color: Color(0xffA2D2FF),
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          "Followers GET API",
          style: TextStyle(color: Color(0xffA2D2FF)),
        ),
      ),
      body: Container(
          width: double.infinity,
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(
                  color: Color(0xffA2D2FF),
                ))
              : arrFollowers.isEmpty
                  ? Center(
                      child: Text(
                      'Data Not Found',
                      style: font22,
                    ))
                  : ListView.builder(
                      itemCount: arrFollowers.length,
                      itemBuilder: (_, int i) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          child: ListTile(
                            leading: Text(
                              '${arrFollowers[i].id}.',
                              style: font22,
                            ),
                            title: Text(
                              ' ${arrFollowers[i].name} ',
                              style: font22,
                            ),
                            trailing: CircleAvatar(
                              backgroundColor: Color(0xff191A19),
                              backgroundImage: NetworkImage(
                                  '${arrFollowers[i].avatar ?? ""}'),
                            ),
                          ),
                        );
                      },
                    )),
    );
  }

  TextStyle get font22 => TextStyle(
      color: Color(0xffD1E8E4),
      fontWeight: FontWeight.w500,
      wordSpacing: 1,
      fontSize: 18);
}
