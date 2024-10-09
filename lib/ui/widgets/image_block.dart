import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
            child: CachedNetworkImage(imageUrl: url),
          ),
        );
      })
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime dt = DateTime.parse(item['created_at']);
    String date = '${dt.year}';

    return Card(
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded( 
            child: GestureDetector(
              onTap: () => dialog(context, item['urls']['small']),
              child: CachedNetworkImage(
                imageUrl: item['urls']['small'],
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => const Icon(Icons.error),
              )
            )
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 5, bottom: 5, left: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.favorite, color: Colors.red),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text("${item['likes']}"),
                    )
                  ],
                ),
                Text(date)
              ],
            ),
          )
        ]
      )
    );
  }
}