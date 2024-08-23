class ContactModel {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String description;
  final bool? hasEmail;
  final bool? hasPhoneNumber;

  ContactModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.description,
    this.hasEmail = true,
    this.hasPhoneNumber = true,
  });
}
