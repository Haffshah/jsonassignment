

class FollowersListModel {
  FollowersListModel({this.followersData});
  List<FollowersData>? followersData = [];

  factory FollowersListModel.fromJson(dynamic json) {
    return FollowersListModel(
      followersData: List<FollowersData>.from(
        json.map(
          (x) => FollowersData.fromJson(x),
        ),
      ),
    );
  }
}

class FollowersData {
  String? id;
  String? name;
  String? avatar;

  FollowersData({this.id, this.avatar, this.name});

  factory FollowersData.fromJson(Map<String, dynamic> follower) {
    return FollowersData(
        id: follower['id'], name: follower['name'], avatar: follower['avatar']);
  }
}
