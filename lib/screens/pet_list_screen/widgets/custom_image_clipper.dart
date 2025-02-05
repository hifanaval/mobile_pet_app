import 'dart:ui' as ui;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_pet_app/constants/image_class.dart';

class CustomShapeClipper extends CustomClipper<Path> {
  final double originalWidth = 158;
  final double originalHeight = 106;

  @override
  Path getClip(Size size) {
    // Calculate scale factors
    double scaleX = size.width / originalWidth;
    double scaleY = size.height / originalHeight;

    Path path = Path();
    // Scale each coordinate
    path.moveTo(158 * scaleX, 14 * scaleY);
    path.cubicTo(
        158 * scaleX, 6.26801 * scaleY, 151.732 * scaleX, 0, 144 * scaleX, 0);
    path.lineTo(14 * scaleX, 0);
    path.cubicTo(6.26801 * scaleX, 0, 0, 6.26802 * scaleY, 0, 14 * scaleY);
    path.lineTo(0, 92 * scaleY);
    path.cubicTo(0, 99.732 * scaleY, 6.26801 * scaleX, 106 * scaleY,
        14 * scaleX, 106 * scaleY);
    path.lineTo(114 * scaleX, 106 * scaleY);
    path.cubicTo(121.732 * scaleX, 106 * scaleY, 128 * scaleX, 99.732 * scaleY,
        128 * scaleX, 92 * scaleY);
    path.lineTo(128 * scaleX, 89 * scaleY);
    path.cubicTo(128 * scaleX, 81.268 * scaleY, 134.268 * scaleX, 75 * scaleY,
        142 * scaleX, 75 * scaleY);
    path.lineTo(144 * scaleX, 75 * scaleY);
    path.cubicTo(151.732 * scaleX, 75 * scaleY, 158 * scaleX, 68.732 * scaleY,
        158 * scaleX, 61 * scaleY);
    path.lineTo(158 * scaleX, 14 * scaleY);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class RPSCustomPainter extends CustomPainter {
  final double originalWidth = 158;
  final double originalHeight = 106;

  @override
  void paint(Canvas canvas, Size size) {
    // Calculate scale factors
    double scaleX = size.width / originalWidth;
    double scaleY = size.height / originalHeight;

    Path path_0 = Path();
    path_0.moveTo(158 * scaleX, 14 * scaleY);
    path_0.cubicTo(
        158 * scaleX, 6.26801 * scaleY, 151.732 * scaleX, 0, 144 * scaleX, 0);
    path_0.lineTo(14 * scaleX, 0);
    path_0.cubicTo(6.26801 * scaleX, 0, 0, 6.26802 * scaleY, 0, 14 * scaleY);
    path_0.lineTo(0, 92 * scaleY);
    path_0.cubicTo(0, 99.732 * scaleY, 6.26801 * scaleX, 106 * scaleY,
        14 * scaleX, 106 * scaleY);
    path_0.lineTo(114 * scaleX, 106 * scaleY);
    path_0.cubicTo(121.732 * scaleX, 106 * scaleY, 128 * scaleX,
        99.732 * scaleY, 128 * scaleX, 92 * scaleY);
    path_0.lineTo(128 * scaleX, 89 * scaleY);
    path_0.cubicTo(128 * scaleX, 81.268 * scaleY, 134.268 * scaleX, 75 * scaleY,
        142 * scaleX, 75 * scaleY);
    path_0.lineTo(144 * scaleX, 75 * scaleY);
    path_0.cubicTo(151.732 * scaleX, 75 * scaleY, 158 * scaleX, 68.732 * scaleY,
        158 * scaleX, 61 * scaleY);
    path_0.lineTo(158 * scaleX, 14 * scaleY);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.stroke;
    paint0Fill.color = Colors.black.withOpacity(0.1);
    paint0Fill.strokeWidth = 1;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class CustomShapedImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;

  const CustomShapedImage({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // The clipped image
        ClipPath(
            clipper: CustomShapeClipper(),
            child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: width,
                height: height,
                placeholder: (context, url) =>
                    Image.asset(ImageClass.noDataFound),
                errorWidget: (context, url, error) =>
                    Image.asset(ImageClass.noDataFound),
                fit: BoxFit.cover)),
        // Custom painter for border
        CustomPaint(
          size: Size(width, height),
          painter: RPSCustomPainter(),
        ),
      ],
    );
  }
}
