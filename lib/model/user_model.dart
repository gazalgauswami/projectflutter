class UserModel {
  String? uid;
  String? email;
  String? bdate;
  String? phone;
  String? pass;

  UserModel({this.uid, this.email, this.bdate, this.phone, this.pass});

  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['key'],
      email: map['email'],
      bdate: map['bdate'],
      phone: map['phone'],
      pass: map['pass'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'key': uid,
      'email': email,
      "bdate": bdate,
      'password': pass,
    };
  }
}
