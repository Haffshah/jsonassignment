import 'package:flutter/material.dart';
import 'package:jsonassignment/models/profile_model.dart';

class MobileDataClass extends StatefulWidget {
  final ProfileData? profileData;
  const MobileDataClass({Key? key, this.profileData}) : super(key: key);

  @override
  _MobileDataClassState createState() => _MobileDataClassState();
}

class _MobileDataClassState extends State<MobileDataClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mobile Specification"),
      ),
      body: Column(
        children: [
          // Text("${widget.profileData?.mobileData?.ram}"),
        ],
      ),
    );
  }
}
