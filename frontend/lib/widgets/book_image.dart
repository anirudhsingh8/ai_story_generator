import 'package:flutter/material.dart';

class BookImage extends StatefulWidget {
  final String imagePath;

  const BookImage({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  @override
  State<BookImage> createState() => _BookImageState();
}

class _BookImageState extends State<BookImage> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            transform: isHovered
                ? (Matrix4.identity()..translate(0.0, -5.0))
                : Matrix4.identity(),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: isHovered
                      ? const Color(0xFF2C3E50).withOpacity(0.3)
                      : Colors.black.withOpacity(0.15),
                  offset: const Offset(0, 4),
                  blurRadius: isHovered ? 16 : 10,
                  spreadRadius: isHovered ? 1 : 0,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFFECE0D1),
                    width: isHovered ? 5 : 4,
                  ),
                ),
                child: Image.network(
                  widget.imagePath,
                  fit: BoxFit.contain,
                  frameBuilder:
                      (context, child, frame, wasSynchronouslyLoaded) {
                    if (frame == null) {
                      return Container(
                        height: 250,
                        width: 500,
                        color: const Color(0xFFECE0D1),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF8E44AD),
                          ),
                        ),
                      );
                    }
                    return child;
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
