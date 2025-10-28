import 'dart:io';

import 'package:flutter/material.dart';

class Viewimage extends StatelessWidget {
  const Viewimage({super.key, required this.isEditing, required this.pickImage, required this.newImagePath});

final bool isEditing ;
final void Function() pickImage;
final String? newImagePath;

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
              onTap: isEditing ? pickImage : null,
              child: newImagePath != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Image.file(
                            File(newImagePath!),
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          if (isEditing)
                            Container(
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.black45,
                                shape: BoxShape.circle,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(6),
                                child: Icon(Icons.edit,
                                    color: Colors.white, size: 20),
                              ),
                            ),
                        ],
                      ),
                    )
                  : GestureDetector(
                      onTap: isEditing ? pickImage : null,
                      child: Container(
                        height: 180,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: isEditing
                            ? const Icon(Icons.add_a_photo_outlined,
                                size: 50, color: Colors.black54)
                            : const Icon(Icons.image_not_supported_outlined,
                                size: 50, color: Colors.black38),
                      ),
                    ),
            );
  }
}