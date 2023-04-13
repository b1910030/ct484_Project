import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './category_screen.dart';


class CategoryTile extends StatelessWidget {
  const CategoryTile(
      {required this.title,
      required this.imageUrl,
      this.imageAlignment = Alignment.center,
      Key? key})
      : super(key: key);
  final String imageUrl;
  final String title;

  /// Which part of the image to prefer
  final Alignment imageAlignment;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => categoryDetail(brand: title),
              ),
            );
          },
      child: Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                imageUrl,
                color: Colors.grey[200],
                colorBlendMode: BlendMode.darken,
                alignment: imageAlignment,
                fit: BoxFit.cover,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  title.toUpperCase(),
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
                ],
              ),
            ),
    );
  }
}