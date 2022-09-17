import 'package:actual/common/model/cursor_pagination_model.dart';
import 'package:actual/restaurant/model/restaurant_model.dart';
import 'package:actual/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>(
  (ref) {
    final repository = ref.watch(restaurantRepositoryProvider);

    final notifier = RestaurantStateNotifier(repository: repository);

    return notifier;
  },
);

// 캐시를 관리하려면 statenotifierprovider 사용 -> 메소드를 만들어서 클래스안에 집어넣음
class RestaurantStateNotifier extends StateNotifier<CursorPaginationBase> {
  final RestaurantRepository repository;

  RestaurantStateNotifier({
    required this.repository,
  }) : super(CursorPaginationLoading()) {
    paginate();
  }

  paginate() async {
    final resp = await repository.paginate();
    state = resp;
  }
}
