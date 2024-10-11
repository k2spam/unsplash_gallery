class CardModel {
  late String smallImage;
  late String bigImage;
  late int likes;
  late String year;

  CardModel({
    required this.smallImage,
    required this.bigImage,
    required this.likes,
    required this.year
  });

  CardModel.fromJson(dynamic json) {
    DateTime dt = DateTime.parse(json['created_at']);

    smallImage = json['urls']['small'];
    bigImage = json['urls']['full'];
    likes = json['likes'] as int;
    year = '${dt.year}';
  }
}