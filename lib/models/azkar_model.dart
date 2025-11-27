class AzkarModel {
  final String content;
  final String description;
  final int count;
  final int currentCount;

  AzkarModel({
    required this.content,
    required this.description,
    required this.count,
    required this.currentCount,
  });

  factory AzkarModel.fromJson(Map<String, dynamic> json) {
    return AzkarModel(
      content: json["zekr"],
      description: json["bless"],
      count: json["repeat"],
      currentCount: json["currentCount"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "zekr": content,
      "bless": description,
      "repeat": count,
      "currentCount": currentCount,
    };
  }

  AzkarModel increment() {
    return AzkarModel(
      content: content,
      description: description,
      count: count,
      currentCount: currentCount + 1,
    );
  }
}
