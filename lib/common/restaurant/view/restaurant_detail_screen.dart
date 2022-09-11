import 'package:actual/common/layout/defalut_layout.dart';
import 'package:actual/common/product/component/product_card.dart';
import 'package:actual/common/restaurant/component/restaurant_card.dart';
import 'package:flutter/material.dart';

class RestaurantDetailScreen extends StatelessWidget {
  const RestaurantDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '불타는 떡볶이',
      child: Column(
        children: [
          RestaurantCard(
            isDetail: true,
            image: Image.asset('asset/img/food/ddeok_bok_gi.jpg'),
            name: '불타는 떡볶이',
            tags: ['dd', '맛있음', '치즈'],
            ratingsCount: 100,
            deliveryTime: 30,
            deliveryFee: 3000,
            ratings: 4.76,
            detail: '맛있는 떡볶이',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ProductCard(),
          ),
        ],
      ),
    );
  }
}
