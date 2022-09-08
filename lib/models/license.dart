class License {
  late String title;
  late String text;

  License({required this.title, required this.text});

  License.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    text = json['text'];
  }
}
