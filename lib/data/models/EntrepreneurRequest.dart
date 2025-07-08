class EntrepreneurRequest {
  final String id;
  final Map<String, String> title;
  final Map<String, String> description;
  bool accepted;

  EntrepreneurRequest({
    required this.id,
    required this.title,
    required this.description,
    this.accepted = false,
  });
}