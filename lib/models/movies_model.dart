class MoviesModel {
  List<Titles>? titles;
  int? totalCount;
  String? nextPageToken;

  MoviesModel({this.titles, this.totalCount, this.nextPageToken});

  MoviesModel.fromJson(Map<String, dynamic> json) {
    if (json['titles'] != null) {
      titles = <Titles>[];
      json['titles'].forEach((v) {
        titles!.add(Titles.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
    nextPageToken = json['nextPageToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (titles != null) {
      data['titles'] = titles!.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = totalCount;
    data['nextPageToken'] = nextPageToken;
    return data;
  }
}

class Titles {
  String? id;
  String? type;
  String? primaryTitle;
  String? originalTitle;
  PrimaryImage? primaryImage;
  int? startYear;
  int? runtimeSeconds;
  List<String>? genres;
  Rating? rating;
  String? plot;

  Titles({
    this.id,
    this.type,
    this.primaryTitle,
    this.originalTitle,
    this.primaryImage,
    this.startYear,
    this.runtimeSeconds,
    this.genres,
    this.rating,
    this.plot,
  });

  Titles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    primaryTitle = json['primaryTitle'];
    originalTitle = json['originalTitle'];
    primaryImage = json['primaryImage'] != null
        ? PrimaryImage.fromJson(json['primaryImage'])
        : null;
    startYear = json['startYear'];
    runtimeSeconds = json['runtimeSeconds'];
    genres = json['genres'].cast<String>();
    rating = json['rating'] != null ? Rating.fromJson(json['rating']) : null;
    plot = json['plot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['primaryTitle'] = primaryTitle;
    data['originalTitle'] = originalTitle;
    if (primaryImage != null) {
      data['primaryImage'] = primaryImage!.toJson();
    }
    data['startYear'] = startYear;
    data['runtimeSeconds'] = runtimeSeconds;
    data['genres'] = genres;
    if (rating != null) {
      data['rating'] = rating!.toJson();
    }
    data['plot'] = plot;
    return data;
  }
}

class PrimaryImage {
  String? url;
  int? width;
  int? height;

  PrimaryImage({this.url, this.width, this.height});

  PrimaryImage.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['width'] = width;
    data['height'] = height;
    return data;
  }
}

class Rating {
  double? aggregateRating;
  int? voteCount;

  Rating({this.aggregateRating, this.voteCount});

  Rating.fromJson(Map<String, dynamic> json) {
    aggregateRating = (json['aggregateRating'] as num?)?.toDouble();
    voteCount = json['voteCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['aggregateRating'] = aggregateRating;
    data['voteCount'] = voteCount;
    return data;
  }
}
