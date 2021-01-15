class PredictionSearchModel {
  String placeId;
  String mainText;
  String secondaryText;

  PredictionSearchModel({
    this.placeId,
    this.mainText,
    this.secondaryText,
  });
  PredictionSearchModel.fromJson(Map<String, dynamic> json) {
    placeId = json['place_id'];
    mainText = json['structured_formatting']['main_text'];
    secondaryText = json['structured_formatting']['secondary_text'];
  }
}
