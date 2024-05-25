import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class MyAvatar extends StatefulWidget {
  final double size;
  final String imageUrl;

  const MyAvatar({super.key, required this.size, required this.imageUrl});

  @override
  State<MyAvatar> createState() => _MyAvatarState();
}

class _MyAvatarState extends State<MyAvatar> {
  String previousImageUrl = '';

  @override
  void didUpdateWidget(covariant MyAvatar oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Detectar cambios en la URL de la imagen
    if (widget.imageUrl != previousImageUrl) {
      // La URL de la imagen ha cambiado, puedes realizar acciones necesarias aquí
      // Por ejemplo, borrar el caché si es necesario
      final cacheManager = DefaultCacheManager();
      cacheManager.emptyCache();

      // Actualizar la URL anterior con la nueva URL
      setState(() {
        previousImageUrl = widget.imageUrl;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: (widget.imageUrl.isEmpty)
            ? Image.asset(
          "assets/icons/user_account_icon.png",
          fit: BoxFit.cover,
        )
            : Image.network(widget.imageUrl,
          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Center(
              child: LinearProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                    : null,
                color: Theme.of(context).colorScheme.secondary,
              ),
            );
          },
          errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
            return const Center(
              child: Icon(
                Icons.warning,
                size: 48,
                color: Colors.red,
              ),
            );
          },
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
