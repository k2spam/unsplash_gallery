import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pixabay_gallery/services/unsplash_service.dart';
import 'package:pixabay_gallery/ui/widgets/image_block.dart';

/// Страница залереи
class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  static const _imageCount = 10;
  final UnsplashService _pixabayService = UnsplashService();
  final PagingController _pagingController = PagingController(firstPageKey: 1);

  /// Метод подгрузки пачки картинок постранично по мере скролла
  /// Если картинок меньше чем необходимо для полной пачки, значит
  /// это последняя страница
  Future<void> _fetchPage(int page) async {
    try {
      final images = await _pixabayService.fetchImages(page: page);
      final isLastPage = images.length < _imageCount;

      if(isLastPage) {
        _pagingController.appendLastPage(images);
      }
      else {
        final nextPage = page + 1;
        _pagingController.appendPage(images, nextPage);
      }
    }
    catch(e) {
      _pagingController.error = e;
    }
  }

  /// Метод рассчета количества элементов в строке сетки
  /// в зависимости от ширины экрана устройства
  int _getCrossAxisCount (BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return 
      width > 1200 ? 6
      : width > 900 ? 4
        : width > 600 ? 3
          : 2;
      
  }

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((page) { 
      _fetchPage(page);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unsplash Gallery'),
      ),
      body: PagedGridView(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate(
          itemBuilder: (context, item, index) => ImageBlock(item: item),
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _getCrossAxisCount(context)
        ),
      )
    );
  }
}