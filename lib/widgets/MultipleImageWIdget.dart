// ignore_for_file: public_member_api_docs, sort_constructors_first, sort_child_properties_last
// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MultipleImageComponent extends StatefulWidget {
  final String? label;
  final List<File>? imagesFile;
  final List<String>? images;
  final ValueChanged<File> pickedImage;
  final String slug;
  final Function(String imgIndex, String slug) onDeleteImage;

  const MultipleImageComponent({
    Key? key,
    required this.label,
    required this.imagesFile,
    this.images,
    required this.pickedImage,
    required this.slug,
    required this.onDeleteImage,
  }) : super(key: key);

  @override
  _MultipleImageComponentState createState() => _MultipleImageComponentState();
}

class _MultipleImageComponentState extends State<MultipleImageComponent> {
  File? pickedImage;

  Future<void> onPickImages() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          pickedImage = File(pickedFile.path);
          widget.pickedImage(File(pickedImage!.path));
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label!,
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            height: 250,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black54),
              borderRadius: BorderRadius.circular(12),
            ),
            width: 550,
            child: Stack(alignment: Alignment.topLeft, children: [
              if (pickedImage != null)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Row(
                          children: widget.images!
                              .map((item) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.network(
                                            item,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: GestureDetector(
                                            onTap: () {
                                              print(
                                                  'Close button tapped for image: $item');
                                            },
                                            child: Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Icon(
                                                Icons.close,
                                                color: Colors.white,
                                                size: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                              .toList()),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                pickedImage!,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Positioned(
                              top:
                                  8, // Adjust the top position to add some margin
                              right:
                                  8, // Adjust the right position to add some margin
                              child: GestureDetector(
                                onTap: () {
                                  print('Close button tapped for image: ');
                                },
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              else if (widget.images!.isNotEmpty)
                ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.images!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              widget.images![index],
                              fit: BoxFit.contain,
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                widget.onDeleteImage(
                                    widget.images![index], widget.slug);
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              else
                Center(child: CircularProgressIndicator()),
              InkWell(
                onTap: () {
                  onPickImages();
                },
                child: Icon(
                  Icons.image_search,
                  size: 80,
                  color: Colors.black,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
