class PartnerModel {
  int id;
  String name;
  String lastName;
  String email;
  String phone;
  double percentParticipation;
  PartnerModel(
      {this.id, this.name, this.lastName, this.email, this.phone, this.percentParticipation});
  String get fullName => "$name $lastName";
}