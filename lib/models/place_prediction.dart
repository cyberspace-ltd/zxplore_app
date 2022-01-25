
class Prediction {
  String placeId;
  String mainText;
  String secondaryText;
  String description;

  Prediction({
    required this.mainText,
    required this.placeId,
    required this.secondaryText,
    required this.description,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
    description: json["description"] !=null? json["description"] : "",
    placeId: json['place_id'] !=null? json['place_id'] : "",
    mainText: json['structured_formatting']['main_text'] !=null?
      json['structured_formatting']['main_text'] : "",
    secondaryText: json['structured_formatting']['secondary_text'] !=null?
      json['structured_formatting']['secondary_text'] : "",

    );
  }
}