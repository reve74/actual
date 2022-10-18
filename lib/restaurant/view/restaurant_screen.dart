import 'package:actual/product/component/pagination_list_view.dart';
import 'package:actual/restaurant/component/restaurant_card.dart';
import 'package:actual/restaurant/provider/restaurant_provider.dart';
import 'package:actual/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PaginationListView(
      provider: restaurantProvider,
      itemBuilder: <RestaurantModel>(_, index, model) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => RestaurantDetailScreen(
                  id: model.id,
                ),
              ),
            );
          },
          child: RestaurantCard.fromModel(
            model: model,
          ),
        );
      },
    );

    // final data = ref.watch(restaurantProvider);
    //
    // // 완전 처음 로딩일때
    // if (data is CursorPaginationLoading) {
    //   return const Center(
    //     child: CircularProgressIndicator(),
    //   );
    // }
    //
    // // 에러
    // if (data is CursorPaginationError) {
    //   return Center(
    //     child: Text(data.message),
    //   );
    // }
    //
    // // CursorPagination
    // // CursorPaginationFetchingMore
    // // CursorPaginationReFetching
    //
    // final cp = data as CursorPagination;
    //
    // return Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
    //   child: ListView.separated(
    //     controller: controller,
    //     itemCount: cp.data.length + 1,
    //     itemBuilder: (context, index) {
    //       if (index == cp.data.length) {
    //         return Padding(
    //           padding:
    //               const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    //           child: Center(
    //             child: data is CursorPaginationFetchingMore
    //                 ? CircularProgressIndicator()
    //                 : Text('마지막 데이터 입니다.'),
    //           ),
    //         );
    //       }
    //
    //       final pItem = cp.data[index];
    //       // final pItem = RestaurantModel.fromJson(item);
    //
    //       return GestureDetector(
    //           onTap: () {
    //             Navigator.of(context).push(MaterialPageRoute(
    //                 builder: (context) => RestaurantDetailScreen(
    //                       id: pItem.id,
    //                     )));
    //           },
    //           child: RestaurantCard.fromModel(model: pItem));
    //     },
    //     separatorBuilder: (context, index) {
    //       return SizedBox(height: 16);
    //     },
    //
    //     // FutureBuilder<CursorPagination<RestaurantModel>>(
    //     //   future: ref.watch(restaurantRepositoryProvider).paginate(),
    //     //   builder: (context,
    //     //       AsyncSnapshot<CursorPagination<RestaurantModel>> snapshot) {
    //     //     if (!snapshot.hasData) {
    //     //       return Center(
    //     //         child: CircularProgressIndicator(),
    //     //       );
    //     //     }
    //     //
    //     //     return ListView.separated(
    //     //       itemBuilder: (context, index) {
    //     //         final pItem = snapshot.data!.data[index];
    //     //         // final pItem = RestaurantModel.fromJson(item);
    //     //
    //     //         return GestureDetector(
    //     //             onTap: () {
    //     //               Navigator.of(context).push(MaterialPageRoute(
    //     //                   builder: (context) => RestaurantDetailScreen(
    //     //                     id: pItem.id,
    //     //                   )));
    //     //             },
    //     //             child: RestaurantCard.fromModel(model: pItem));
    //     //       },
    //     //       separatorBuilder: (context, index) {
    //     //         return SizedBox(height: 16);
    //     //       },
    //     //       itemCount: snapshot.data!.data.length,
    //     //     );
    //     //   },
    //     // ),
    //   ),
    // );
  }
}
