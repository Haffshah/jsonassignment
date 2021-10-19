

class ProfileData {
  String? firstname;
  String? lastname;
  String? region;
  String? country;
  String? bio;
  num? post;
  num? followers;
  num? following;
  String? image;

  ProfileData(
      {this.image,
      this.firstname,
      this.lastname,
      this.region,
      this.country,
      this.bio,
      this.post,
      this.followers,
      this.following});

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
        following: parsedJson['following']);
  }
}
