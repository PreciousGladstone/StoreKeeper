import 'dart:io';
import 'package:flutter/material.dart';

class TakePhotoBox extends StatelessWidget {
  final VoidCallback onPickImage;
  final List<File> images;

  const TakePhotoBox({
    super.key,
    required this.onPickImage,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPickImage,
      child: Container(
        height: 180,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400, width: 1.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: images.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt_outlined,
                        size: 40, color: Colors.grey.shade500),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F2FD),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'TAKE PHOTO OR UPLOAD',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text('Maximum up to 5 Images',
                        style:
                            TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                  ],
                ),
              )
            : ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(8),
                itemCount: images.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) => ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: [
                      Image.file(
                        images[index],
                        width: 120,
                        height: 160,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        right: 6,
                        top: 6,
                        child: InkWell(
                          onTap: () {
                            // Not removing here, handled in parent
                          },
                          child: const CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.black54,
                            child: Icon(Icons.close,
                                color: Colors.white, size: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}