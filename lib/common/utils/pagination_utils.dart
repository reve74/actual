import 'package:actual/common/provider/pagination_provider.dart';
import 'package:flutter/material.dart';

class PaginationUtils {
  static void paginate({
    required ScrollController controller,
    required PaginationProvider provider,
  }) {
    if (controller.offset > controller.position.maxScrollExtent - 300) {
      // controller.offset - 현재 스크롤
      // controller.position.maxScrollExtent - 현재 최대 스크롤 가능 크기
      provider.paginate(
            fetchMore: true,
          );
    }
  }
}
