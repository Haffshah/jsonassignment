import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jsonassignment/models/profile_model.dart';

class MobileSpecification extends StatefulWidget {
  final ProfileData? profileData;
  const MobileSpecification({Key? key, this.profileData}) : super(key: key);

  @override
  _MobileSpecificationState createState() => _MobileSpecificationState();
}

class _MobileSpecificationState extends State<MobileSpecification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffD5D5D5),
      appBar: AppBar(
        leading: IconButton(color: Color(0xff091353),
          icon: Icon(Icons.arrow_back_rounded),onPressed: (){
            Navigator.pop(context);
        },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(" Nested Json Data",
            style: TextStyle(color: Color(0xff091353))),
      ),
      body: Center(
        child: Card(
          elevation: 20,
          borderOnForeground: true,
          shadowColor: Color(0xffD1E8E4),
          color: Color(0xff091353),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Mobile Brand: ${widget.profileData?.mobile?.mobname}",
                  style: font22(),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("RAM: ${widget.profileData?.mobile?.ram}",
                    style: font22()),
                SizedBox(
                  height: 10,
                ),
                Text("Storage: ${widget.profileData?.mobile?.rom}",
                    style: font22()),
                SizedBox(
                  height: 10,
                ),
                Text("Screen Size: ${widget.profileData?.mobile?.screensize}",
                    style: font22()),
                SizedBox(
                  height: 10,
                ),
                Text("Color:  ${widget.profileData?.mobile?.color?.one}",
                    style: font22()),
                SizedBox(
                  height: 20,
                ),
                Container(padding: EdgeInsets.all(10),
                  color: Color(0xff4B6587),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Weekly Results and also Data From List of Objects in JSON".toUpperCase(),
                          style: font22()),
                          SizedBox(
                          height: 20,
                          ),
                          ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.profileData?.results?.length ?? 0,
                          itemBuilder: (_, int i) {
                          return Container(
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Text(
                          "Test Result on ${widget.profileData?.results?[i].day?.toUpperCase()} is ${widget.profileData?.results?[i].score}",
                          style: font22(),
                          ),
                          SizedBox(
                          height: 10,
                          ),

                            ],
                          ));
                        },
                      ),

                    ],
                  ),
                ), Text(
                  "Test Result on Monday is ${widget.profileData?.results?.firstWhere((WeeklyResults element) => element.day =="mon").score}",
                  style: font22(),
                ), SizedBox(
                  height: 10,
                ),
                Text(
                  "Test Result on Tuesday is ${widget.profileData?.results?.firstWhere((WeeklyResults element) => element.day =="tue").score}",
                  style: font22(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextStyle font22() => TextStyle(color: Color(0xffD1E8E4), fontSize: 20);
}
