import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pixabay_gallery/models/card_model.dart';

/// Виджет отображения карточки с фотографией
/// количеством лайков и годом на создания фотографии
class ImageBlock extends StatelessWidget {
  final dynamic item;

  const ImageBlock({
    required this.item, 
    super.key
  });

  void dialog(BuildContext context, String url) {
    Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20), 
            child: Center(
                child: CachedNetworkImage(
                  imageUrl: url,
                  progressIndicatorBuilder: (context, url, progress) => const CircularProgressIndicator(),
                ),
              )
          ),
        );
      })
    );
  }

  @override
  Widget build(BuildContext context) {
    CardModel card = CardModel.fromJson(item);

    return Card(
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded( 
            child: GestureDetector(
              onTap: () => dialog(context, card.bigImage),
              child: CachedNetworkImage(
                imageUrl: card.smallImage,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => const Icon(Icons.error),
              )
            )
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5, bottom: 5, left: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.favorite, color: Colors.red),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text("${card.likes}"),
                    )
                  ],
                ),
                Text(card.year)
              ],
            ),
          )
        ]
      )
    );
  }
}