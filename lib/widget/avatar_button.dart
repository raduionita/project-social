import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AvatarButton extends StatelessWidget {
  const AvatarButton({super.key, required this.onPressed, this.icon});

  final VoidCallback onPressed;
  final Widget? icon;

  AvatarButton.network(String src, {required this.onPressed, super.key})
      : icon = CircleAvatar(
            // backgroundColor: Colors.transparent,
            radius: 18,
            backgroundImage: CachedNetworkImageProvider(
              src,
              // fit: BoxFit.cover,
              maxWidth: 16,
              maxHeight: 16,
            ));

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.all(0),
      onPressed: onPressed,
      icon: icon ?? const Icon(Icons.account_circle_outlined),
    );
  }
}
