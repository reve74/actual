import 'package:actual/common/const/data.dart';
import 'package:actual/common/dio/dio.dart';
import 'package:actual/common/model/cursor_pagination_model.dart';
import 'package:actual/common/utils/pagination_utils.dart';
import 'package:actual/restaurant/component/restaurant_card.dart';
import 'package:actual/restaurant/model/restaurant_model.dart';
import 'package:actual/restaurant/provider/restaurant_provider.dart';
import 'package:actual/restaurant/repository/restaurant_repository.dart';
import 'package:actual/restaurant/view/restaurant_detail_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends ConsumerStatefulWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends ConsumerState<RestaurantScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(scrollListener);
  }

  void scrollListener() {
    PaginationUtils.paginate(
      controller: controller,
      provider: ref.read(restaurantProvider.notifier),
    );

    // 현재 위치가
    // 최대 길이보다 조금 덜되는 위치까지 왔다면
    // 새로운 데이터를 추가요청

    // if (controller.offset > controller.position.maxScrollExtent - 300) {
    //   // controller.offset - 현재 스크롤
    //   // controller.position.maxScrollExtent - 현재 최대 스크롤 가능 크기
    //   ref.read(restaurantProvider.notifier).paginate(
    //         fetchMore: true,
    //       );
    // }
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(restaurantProvider);

    // 완전 처음 로딩일때
    if (data is CursorPaginationLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // 에러
    if (data is CursorPaginationError) {
      return Center(
        child: Text(data.message),
      );
    }

    // CursorPagination
    // CursorPaginationFetchingMore
    // CursorPaginationReFetching

    final cp = data as CursorPagination;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.separated(
        controller: controller,
        itemCount: cp.data.length + 1,
        itemBuilder: (context, index) {
          if (index == cp.data.length) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Center(
                child: data is CursorPaginationFetchingMore
                    ? CircularProgressIndicator()
                    : Text('마지막 데이터 입니다.'),
              ),
            );
          }

          final pItem = cp.data[index];
          // final pItem = RestaurantModel.fromJson(item);

          return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RestaurantDetailScreen(
                          id: pItem.id,
                        )));
              },
              child: RestaurantCard.fromModel(model: pItem));
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 16);
        },

        // FutureBuilder<CursorPagination<RestaurantModel>>(
        //   future: ref.watch(restaurantRepositoryProvider).paginate(),
        //   builder: (context,
        //       AsyncSnapshot<CursorPagination<RestaurantModel>> snapshot) {
        //     if (!snapshot.hasData) {
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     }
        //
        //     return ListView.separated(
        //       itemBuilder: (context, index) {
        //         final pItem = snapshot.data!.data[index];
        //         // final pItem = RestaurantModel.fromJson(item);
        //
        //         return GestureDetector(
        //             onTap: () {
        //               Navigator.of(context).push(MaterialPageRoute(
        //                   builder: (context) => RestaurantDetailScreen(
        //                     id: pItem.id,
        //                   )));
        //             },
        //             child: RestaurantCard.fromModel(model: pItem));
        //       },
        //       separatorBuilder: (context, index) {
        //         return SizedBox(height: 16);
        //       },
        //       itemCount: snapshot.data!.data.length,
        //     );
        //   },
        // ),
      ),
    );
  }
}
