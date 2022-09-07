class Token {
  late String locationToken;

  Token({required this.locationToken});

  Token.fromJson(Map<String, dynamic> json) {
    locationToken = json['locationToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['locationToken'] = locationToken;
    return data;
  }
}
