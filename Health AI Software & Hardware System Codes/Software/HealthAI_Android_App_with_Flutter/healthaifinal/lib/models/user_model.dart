
class UserModel {
  final String? id;
  final String? fullname;
  final String? email;
  final String? age;
  final String? sos_no;
  final String? hospital;
  final String hospital_no;

  const UserModel({
    this.id,
    required this.fullname,
    required this.email,
    required this.age,
    required this.sos_no,
    required this.hospital,
    required this.hospital_no,
  });
  toJason(){
    return{
      "age": age,
      "email": email,
      "name": fullname,
      "soshospital": hospital,
      "soshospitalnumber": hospital_no,
      "sosnumber": sos_no
    };
  }
}

