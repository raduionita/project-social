import 'package:flutter/material.dart' hide BackButton;

class CustomBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomBar({super.key, this.buttons, this.actions, this.title, this.backButton = false, this.onBackPressed});

  final List<Widget>? buttons;
  final List<Widget>? actions;
  final Widget? title;
  final bool backButton;
  final VoidCallback? onBackPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leadingWidth: 0,
      titleSpacing: 0,
      backgroundColor: Colors.black,
      title: Padding(
        padding: const EdgeInsets.only(left: 4, right: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // back button
            if (backButton) CustomBack(onPressed: onBackPressed),
            // leading actions
            Row(children: buttons ?? [const SizedBox.shrink()]),
            // title
            if (title != null) Expanded(child: Padding(padding: const EdgeInsets.only(left: 8, right: 4), child: title!)),
            // trailing actions
            Row(children: actions ?? [const SizedBox.shrink()])
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomBack extends StatelessWidget {
  const CustomBack({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(Icons.arrow_back_ios_outlined),
    );
  }
}
