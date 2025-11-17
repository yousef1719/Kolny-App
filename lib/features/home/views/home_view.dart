// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/constants/size_config.dart';
import 'package:hungry_app/features/auth/data/auth_repo.dart';
import 'package:hungry_app/features/auth/data/user_model.dart';
import 'package:hungry_app/features/home/data/models/product_model.dart';
import 'package:hungry_app/features/home/data/repo/product_repo.dart';
import 'package:hungry_app/features/home/widgets/card_item.dart';
import 'package:hungry_app/features/home/widgets/food_category.dart';
import 'package:hungry_app/features/home/widgets/search_field.dart';
import 'package:hungry_app/features/home/widgets/user_header.dart';
import 'package:hungry_app/features/product/views/product_details_view.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List category = ['All', 'Combo', 'Sliders', 'Classic'];
  int selectedIndex = 0;
  final AuthRepo authRepo = AuthRepo();
  UserModel? user;

  List<ProductModel>? products;
  ProductRepo productRepo = ProductRepo();

  Future<void> getProducts() async {
    final res = await productRepo.getProducts();
    setState(() {
      products = res.cast<ProductModel>();
    });
  }

  // Future<void> getProducts () async {
  //   final res = await productRepo.getProducts();
  //   setState(() {
  //     products = res;
  //   });
  // }

  @override
  void initState() {
    getProducts();
    super.initState();
    user = authRepo.currentUser;
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        bottom: false,
        child: Skeletonizer(
          enabled: products == null,
          child: Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  stretch: false,
                  pinned: false,
                  floating: true,
                  elevation: 0,
                  scrolledUnderElevation: 10,
                  surfaceTintColor: Colors.transparent,
                  backgroundColor: AppColors.secondary,
                  foregroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  automaticallyImplyLeading: false,
                  expandedHeight: screenWidth(context) * 0.40,
                  toolbarHeight: screenWidth(context) * 0.40,
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white,
                          AppColors.secondary,
                          AppColors.primary.withOpacity(0.8),
                          AppColors.primary,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                    child: SafeArea(
                      bottom: false,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: screenHeight(context) * 0.02,
                          right: screenWidth(context) * 0.03,
                          left: screenWidth(context) * 0.03,
                        ),
                        child: Column(
                          children: [
                            UserHeader(userModel: user),
                            Gap(screenHeight(context) * 0.02),
                            SearchField(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: paddingHorizontal(context, 16),
                      // vertical: paddingVertical(context, 5),
                    ),
                    child: FoodCategory(
                      selectedIndex: selectedIndex,
                      category: category,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: paddingHorizontal(context, 16),
                    vertical: paddingVertical(context, 5),
                  ),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: paddingAll(context, 10),
                      crossAxisSpacing: paddingAll(context, 10),
                      childAspectRatio: screenWidth(context) < 360
                          ? 0.82
                          : screenWidth(context) < 400
                          ? 0.85
                          : screenWidth(context) < 500
                          ? 0.8
                          : 0.75,
                    ),

                    delegate: SliverChildBuilderDelegate(
                      childCount: products?.length ?? 6,
                      (context, index) {
                        final product = products?[index];

                        if (product == null) {
                          return CupertinoActivityIndicator();
                        }
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ProductDetailsView(
                                    productImage: product.image,
                                  );
                                },
                              ),
                            );
                          },
                          child: CardItem(
                            text: product.name,
                            image: product.image,
                            desc: product.desc,
                            rate: product.rating,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: screenHeight(context) * 0.14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
