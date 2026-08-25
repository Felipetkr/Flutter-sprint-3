import 'package:flutter/material.dart';

import '../config/app_routes.dart';
import '../theme/app_colors.dart';

class LatteAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LatteAppBar({
    super.key,
    this.title,
    this.showBack = false,
    this.showDashboard = false,
  });

  final String? title;
  final bool showBack;
  final bool showDashboard;

  @override
  Size get preferredSize => const Size.fromHeight(74);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: preferredSize.height,
      automaticallyImplyLeading: false,
      leading: showBack
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              tooltip: 'Voltar',
              onPressed: () => Navigator.of(context).maybePop(),
            )
          : null,
      titleSpacing: showBack ? 0 : 20,
      title: title == null ? const LatteLogo() : Text(title!),
      actions: [
        if (showDashboard)
          IconButton.filledTonal(
            tooltip: 'Painel',
            onPressed: () => Navigator.pushNamed(context, AppRoutes.dashboard),
            icon: const Icon(Icons.dashboard_outlined),
          ),
        const SizedBox(width: 12),
      ],
    );
  }
}

class LatteLogo extends StatelessWidget {
  const LatteLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 44,
          width: 44,
          decoration: const BoxDecoration(
            color: AppColors.sky,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.favorite_border, color: AppColors.navy),
        ),
        const SizedBox(width: 10),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'latteConect',
              style: TextStyle(
                color: AppColors.navy,
                fontSize: 21,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              'banco de leite',
              style: TextStyle(
                color: AppColors.blue,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
