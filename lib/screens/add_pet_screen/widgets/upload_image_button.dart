// image_upload_button.dart
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_pet_app/provider/pet_provider.dart';
import 'package:provider/provider.dart';
import 'package:mobile_pet_app/constants/color_class.dart';
import 'package:mobile_pet_app/constants/textstyle_class.dart';
import 'package:mobile_pet_app/components/sized_box.dart';

class ImageUploadButton extends StatelessWidget {
  final double height;
  final double width;

  const ImageUploadButton({
    super.key,
    this.height = 150,
    this.width = double.infinity,
  });

  void _showImageSourceSheet(BuildContext context, PetDataProvider provider) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select Image Source',
              style:
                  TextstyleClass.primaryFont500(16, AppColors.textPrimaryLight),
            ),
            kHeight(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildOptionButton(
                  icon: Icons.camera_alt,
                  label: 'Camera',
                  onTap: () {
                    Navigator.pop(context);
                    provider.pickImage(ImageSource.camera);
                  },
                ),
                _buildOptionButton(
                  icon: Icons.photo_library,
                  label: 'Gallery',
                  onTap: () {
                    Navigator.pop(context);
                    provider.pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: AppColors.lightBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              size: 30,
              color: AppColors.textPrimaryLight,
            ),
          ),
          kHeight(8),
          Text(
            label,
            style:
                TextstyleClass.primaryFont500(14, AppColors.textPrimaryLight),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PetDataProvider>(
      builder: (context, provider, _) {
        return InkWell(
          onTap: () => _showImageSourceSheet(context, provider),
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: AppColors.containerBorder,
                width: 1,
              ),
            ),
            child: DottedBorder(
              child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                         provider.selectedImage != null? "Change Photo": 'Upload Photos',
                          style:
                              TextstyleClass.primaryFont500(14, AppColors.blue),
                        ),
                        kWidth(4),
                        provider.selectedImage != null?Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.edit,
                          color: AppColors.textPrimaryLight),
                      onPressed: () =>
                          _showImageSourceSheet(context, provider),
                    ),
                  )
                       : const Icon(
                          Icons.file_upload_outlined,
                          size: 40,
                          color: AppColors.blue,
                        ),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}

// Custom Dotted Border Widget
class _DottedBorderPainter extends CustomPainter {
  final double radius;

  _DottedBorderPainter({this.radius = 30.0});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = AppColors.blue
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const double dashWidth = 5;
    const double dashSpace = 5;

    Path path = Path();

    // Top right corner
    path.moveTo(size.width - radius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, radius);

    // Right side
    path.lineTo(size.width, size.height - radius);

    // Bottom right corner
    path.quadraticBezierTo(
        size.width, size.height, size.width - radius, size.height);

    // Bottom side
    path.lineTo(radius, size.height);

    // Bottom left corner
    path.quadraticBezierTo(0, size.height, 0, size.height - radius);

    // Left side
    path.lineTo(0, radius);

    // Top left corner
    path.quadraticBezierTo(0, 0, radius, 0);

    // Top side
    path.lineTo(size.width - radius, 0);

    // Convert the path to dashed
    double dashLength = dashWidth + dashSpace;
    double totalLength = path.computeMetrics().first.length;
    int dashCount = (totalLength / dashLength).ceil();

    for (int i = 0; i < dashCount; i++) {
      double start = i * dashLength;
      double end = start + dashWidth;

      if (end > totalLength) end = totalLength;

      Path dashPath = Path();
      PathMetric metric = path.computeMetrics().first;

      if (start < metric.length) {
        dashPath.addPath(
          metric.extractPath(start, end),
          Offset.zero,
        );
        canvas.drawPath(dashPath, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Update the DottedBorder widget to accept radius parameter
class DottedBorder extends StatelessWidget {
  final Widget child;
  final double radius;

  const DottedBorder({
    super.key,
    required this.child,
    this.radius = 30.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DottedBorderPainter(radius: radius),
      child: Container(
        padding: const EdgeInsets.all(2),
        child: child,
      ),
    );
  }
}
