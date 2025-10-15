import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  final Color heartColor;
  final double size;
  final bool isFavorited;
  final VoidCallback onFavorited;
  final VoidCallback onUnfavorited;

  const FavoriteButton({
    super.key,
    required this.heartColor,
    required this.size,
    required this.onFavorited,
    required this.onUnfavorited,
    required this.isFavorited,
  });

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton>
    with SingleTickerProviderStateMixin {
  late bool isFavorite;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorited; // initialize from parent

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.4,
    ).chain(CurveTween(curve: Curves.easeOut)).animate(_controller);
  }

  void _onTap() {
    if (isFavorite) {
      _controller.reverse();
      widget.onUnfavorited();
    } else {
      _controller.forward().then((_) => _controller.reverse());
      widget.onFavorited();
    }

    setState(() {
      isFavorite = !isFavorite; // Toggle here
    });
  }

  @override
  void didUpdateWidget(covariant FavoriteButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isFavorited != oldWidget.isFavorited) {
      // ✅ Keep sync with external changes
      setState(() {
        isFavorite = widget.isFavorited;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Color(0xFF2d2d2d), Color(0xFF1c1c1c)],
          ),
        ),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_outline,
            color: widget.heartColor,
            size: widget.size,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
