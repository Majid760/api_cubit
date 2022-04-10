class WeatherDBModel {
  int? id;
  String? city;
  String? country;
  double? lat;
  double? lon;
  int? updatedDate;
  int? createdDate;

  WeatherDBModel(
      {this.id,
      this.city,
      this.country,
      this.lat,
      this.lon,
      this.updatedDate,
      this.createdDate});

  WeatherDBModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    city = json['city'];
    country = json['country'];
    lat = json['lat'];
    lon = json['lon'];
    updatedDate = json['updatedDate'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['city'] = city;
    data['country'] = country;
    data['lat'] = lat;
    data['lon'] = lon;
    data['updatedDate'] = updatedDate;
    data['createdDate'] = createdDate;
    return data;
  }

  Map<String, dynamic> toJsonWithoutId() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city'] = city;
    data['lat'] = lat;
    data['lon'] = lon;
    data['updatedDate'] = updatedDate;
    data['createdDate'] = createdDate;
    return data;
  }
}
