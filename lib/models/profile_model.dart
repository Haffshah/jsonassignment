class ProfileData {
  String? firstname;
  String? lastname;
  String? region;
  String? country;
  String? bio;
  num? post;
  num? followers;
  double? following;
  String? image;
  List<String>? peopleFollows;
<<<<<<< HEAD
  MobileDataModel? mobile;
  List<WeeklyResults>? results;
=======
  // MobileData? mobileData;
>>>>>>> 8b0789ce6e7adfd6dcf1e60a3d3d6f274718a1a6

  ProfileData(
      {this.image,
      this.firstname,
      this.lastname,
      this.region,
      this.country,
      this.bio,
      this.post,
      this.followers,
      this.following,
<<<<<<< HEAD
      this.mobile,
      this.peopleFollows,
      this.results});
=======
        // this.mobileData,
      this.peopleFollows});
>>>>>>> 8b0789ce6e7adfd6dcf1e60a3d3d6f274718a1a6

  factory ProfileData.fromJson(Map<String, dynamic> parsedJson) {
    return ProfileData(
        image: parsedJson['profile_pic'],
        firstname: parsedJson['first_name'],
        lastname: parsedJson['last_name'],
        region: parsedJson['region'],
        country: parsedJson['country'],
        bio: parsedJson['bio'],
        post: parsedJson['post'],
        followers: parsedJson['followers'],
        following: parsedJson['following'],
<<<<<<< HEAD
        peopleFollows: List<String>.from(
          parsedJson["peopleFollows"].map((x) => x),
        ),
        mobile: MobileDataModel.fromJson(
          parsedJson['mobile'],
        ),
        results: List<WeeklyResults>.from(parsedJson['WeeklyResults'].map((x)=> WeeklyResults.fromJson(x)  )));
  }
}

class MobileDataModel {
  num? ram;
  num? rom;
  num? screensize;
  String? mobname;
  MobileColor? color;

  MobileDataModel(
      {this.ram, this.rom, this.screensize, this.mobname, this.color});

  factory MobileDataModel.fromJson(Map<String, dynamic> parsedJson) {
    return MobileDataModel(
        mobname: parsedJson['mobname'],
        ram: parsedJson['ram'],
        rom: parsedJson['rom'],
        screensize: parsedJson['screensize'],
        color: MobileColor.fromJson(parsedJson['color']));
  }
}

class MobileColor {
  String? one;
  String? two;
  String? three;

  MobileColor({this.one, this.two, this.three});

  factory MobileColor.fromJson(Map<String, dynamic> parsedJson) {
    return MobileColor(
        one: parsedJson['one'],
        two: parsedJson['two'],
        three: parsedJson['three']);
  }
}

class WeeklyResults {
  String? day;
  num? score;
  WeeklyResults({this.day, this.score});

  factory WeeklyResults.fromJson(Map<String, dynamic> parsedJson) {
    return WeeklyResults(day: parsedJson['day'], score: parsedJson['score']);
=======
        // mobileData: MobileData.fromJson(parsedJson["mobileData"]),
        peopleFollows:
            List<String>.from(parsedJson["peopleFollows"].map((x) => x)));
>>>>>>> 8b0789ce6e7adfd6dcf1e60a3d3d6f274718a1a6
  }
}

// class MobileData {
//   num? ram;
//   num? rom;
//   num? screensize;
//   String? mo_name;
//   MobileData({this.mo_name, this.ram, this.rom, this.screensize});
//
//   factory MobileData.fromJson(Map<String, dynamic> parsedJson) {
//     return MobileData(
//       mo_name: parsedJson["mo_name"],
//       rom: parsedJson["rom"],
//       ram: parsedJson["ram"],
//       screensize: parsedJson["screensize"],
//     );
//   }
// }
