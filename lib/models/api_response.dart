// {
// "status": "success",
// "data": {
// "name": "test",
// "salary": "123",
// "age": "23",
// "id": 3737
// },
// "message": "Successfully! Record has been added."
// }

class CommonApiResModel {
  String? status;
  String? message;

  CommonApiResModel({this.message, this.status});

  factory CommonApiResModel.fromJson(Map<String, dynamic> parsedJson) {
    return CommonApiResModel(
      message: parsedJson['message'],
      status:  parsedJson['status']
    );
  }
}
