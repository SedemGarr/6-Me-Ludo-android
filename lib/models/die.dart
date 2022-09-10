class Die {
  late bool isRolling;
  late int rolledValue;
  late String lastRolledBy;

  Die({required this.isRolling, required this.rolledValue, required this.lastRolledBy});

  static Die getDefaultDie() {
    return Die(isRolling: false, rolledValue: 0, lastRolledBy: '');
  }

  Die.fromJson(Map<String, dynamic> json) {
    isRolling = json['isRolling'];
    lastRolledBy = json['lastRolledBy'];
    rolledValue = json['rolledValue'];
    }
  

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isRolling'] = isRolling;
    data['lastRolledBy'] = lastRolledBy;
    data['rolledValue'] = rolledValue;
    return data;
  }
}
