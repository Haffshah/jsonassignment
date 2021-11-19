import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:jsonassignment/Constants/api_constant.dart';
import 'package:jsonassignment/models/api_response.dart';
import 'package:jsonassignment/models/profile_model.dart';
import 'package:jsonassignment/screens/FollowersPage.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LoginScreenForm extends StatefulWidget {
  const LoginScreenForm({Key? key}) : super(key: key);

  @override
  _LoginScreenFormState createState() => _LoginScreenFormState();
}

class _LoginScreenFormState extends State<LoginScreenForm> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _salaryCtrl = TextEditingController();
  final TextEditingController _ageCtrl = TextEditingController();
ProfileData? profileData;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _salaryCtrl.dispose();
    _ageCtrl.dispose();
    super.dispose();
  }


  getValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
   dynamic aName = prefs.get('name');
   print(aName);
  }

  void onCreate() async {
    bool isValid = _formKey.currentState?.validate() ?? false;

    if (isValid) {
      final dynamic data = <String, dynamic>{
        'name': _nameCtrl.text.trim(),
        'salary': _salaryCtrl.text.trim(),
        'age': _ageCtrl.text.trim()
      };
      setState(() {
        isLoading = true;
      });

      var url = Uri.parse('${APIConstant.baseUrlForPost}${APIConstant.create}');
      var response = await http.post(url, body: data);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        Map<String, dynamic> decodeJson = json.decode(response.body);

        CommonApiResModel commonApiResModel =
            CommonApiResModel.fromJson(decodeJson);
        if (commonApiResModel.status == "success") {
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(
              msg: "${commonApiResModel.message}",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Color(0xff191A19),
              textColor: Color(0xffC1FFD7),
              fontSize: 18.0);
        }
        Navigator.push(context,CupertinoPageRoute(builder: (context)=> FollowersPage(profileData: profileData,)));
      } else {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(
            msg: "Error From Server ${response.statusCode}",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0xff191A19),
            textColor: Color(0xffC1FFD7),
            fontSize: 18.0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff191A19),
      appBar: AppBar(
        toolbarHeight: 70,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          color: Color(0xffA2D2FF),
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          "Login Post API",
          style: TextStyle(color: Color(0xffA2D2FF)),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextFormField(
                  controller: _nameCtrl,
                  validator: (String? s) {
                    if ((s?.isEmpty ?? true)) {
                      return "Please Enter your Name";
                    }
                  },
                  decoration: InputDecoration(
                    fillColor: Color(0xffA2D2FF),
                    labelText: 'Name',
                    filled: true,
                    hintText: 'Enter your Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  controller: _salaryCtrl,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Salary';
                    }
                  },
                  decoration: InputDecoration(
                    fillColor: Color(0xffA2D2FF),
                    labelText: 'Salary',
                    filled: true,
                    hintText: 'Salary',
                    prefixIcon: Icon(Icons.monetization_on_rounded),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  controller: _ageCtrl,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Your Age';
                    }
                  },
                  decoration: InputDecoration(
                    fillColor: Color(0xffA2D2FF),
                    labelText: 'Age',
                    filled: true,
                    hintText: 'Age',
                    prefixIcon: Icon(Icons.calendar_today_sharp),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: onCreate,
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(200, 45),
                    onPrimary: Color(0xffA2D2FF),
                    elevation: 0,
                    primary: Color(0xff191A19),
                  ),
                  child: isLoading
                      ? CircularProgressIndicator(color: Color(0xff8E05C2),)
                      : Text(
                          'Login',
                          style: TextStyle(fontSize: 20),
                        ),
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
