import 'package:equatable/equatable.dart';

class loginEntity extends Equatable {
  final String? loginId;
  final String? password;
  final String? personFname;
  final String? deptName;
  final String? personLname;
  final String? orgName;
  final String? clientauthToken;

  loginEntity({
    this.loginId,
    this.password,
    this.personFname,
    this.deptName,
    this.personLname,
    this.orgName,
    this.clientauthToken,
  });

  @override
  List<Object?> get props => [
        loginId,
        password,
        personFname,
        deptName,
        personLname,
        orgName,
        clientauthToken,
      ];
}
