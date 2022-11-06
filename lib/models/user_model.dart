class UserModel {
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? uId;
  String? dateOfBirth;
  String? nationality;

  UserModel({this.firstName, this.lastName, this.email, this.phone, this.uId});

  UserModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    dateOfBirth = json['dateOfBirth'];
    nationality = json['nationality'];
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'uId': uId,
      'dateOfBirth': dateOfBirth,
      'nationality': nationality,
    };
  }
}
