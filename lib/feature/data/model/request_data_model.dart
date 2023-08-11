import 'dart:convert';

class ApiRequestDataModel {
  String? clientAuthToken;
  String apiFor;
  String? loginId;
  String? loginPassword;
  String? clGroup;
  int? checklistStatus;
  String? fromDateTime;
  String? toDateTime;
  String? clientId;

  ApiRequestDataModel({
    this.clientAuthToken,
    required this.apiFor,
    this.loginId,
    this.loginPassword,
    this.clGroup,
    this.checklistStatus,
    this.fromDateTime,
    this.toDateTime,
    this.clientId,
  });

  Map<String, dynamic> toJson() {
    return {
      'client_aut_token': clientAuthToken,
      'api_for': apiFor,
      'login_id': loginId,
      'login_password': loginPassword,
      'cl_group': clGroup,
      'checklist_status': checklistStatus,
      'from_date_time': fromDateTime,
      'to_date_time': toDateTime,
      'client_id': clientId,
    };
  }
}
