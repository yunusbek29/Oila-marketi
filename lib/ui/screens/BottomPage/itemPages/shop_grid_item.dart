import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/favorite_bloc/favorite_cubit.dart';
import 'package:flutter_application_1/config/app_colors.dart';
import 'package:flutter_application_1/data/repository/models/product_model.dart';
import 'package:flutter_application_1/ui/screens/pages/detail_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopPageGrid extends StatefulWidget {
  final ProductModel product;
  const ShopPageGrid({super.key, required this.product});

  @override
  State<ShopPageGrid> createState() => _ShopPageGridState();
}

class _ShopPageGridState extends State<ShopPageGrid> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FavoriteCubit>(context).getFavoriteProduct();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () async {
        final back = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(product: widget.product),
          ),
        );
        if (back == "setState") {
          BlocProvider.of<FavoriteCubit>(context).getFavoriteProduct();
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.grey),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 2,
                        right: 4,
                      ),
                      child: CachedNetworkImage(
                        imageUrl: widget.product.image,
                        height: 150,
                        width: 150,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        RatingBar.readOnly(
                          initialRating: widget.product.rate,
                          maxRating: 5,
                          filledIcon: Icons.star,
                          emptyIcon: Icons.star_border,
                          halfFilledIcon: Icons.star_half,
                          filledColor: AppColors.amber,
                          size: 20,
                        ),
                        Text(
                          "(${widget.product.ratingCount})",
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      "${widget.product.title}...",
                      maxLines: 1,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(widget.product.category),
                    Text(
                      "${widget.product.price.toString()}\$",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.green,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
