class Address {
  String placeName = '';
  double lat;
  double lng;
  String placeID;
  String placeFormatedAddress;
  Address({
    this.lat,
    this.lng,
    this.placeFormatedAddress,
    this.placeID,
    this.placeName = '',
  });
}
