import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../login/data/datasources/auth_datasource.dart';
import '../../shared/user/data/models/user.dart';
import '../data/datasources/picker_datasource.dart';
import '../data/models/pickable.dart';

class PickerController extends GetxController {
  final AuthDatasource _authDatasource;
  final PickerDatasource _pickerDatasource;
  final String objectLabel;

  static const _pageSize = 20;

  final PagingController<int, Pickable> pagingController =
      PagingController(firstPageKey: 0);

  PickerController(
      this._authDatasource, this.objectLabel, this._pickerDatasource);

  final searchTextController = TextEditingController();

  final query = ''.obs;

  late User userInfo;

  void fetchPickableList(int entityId, int branchId, int page) {
    _pickerDatasource
        .getPickableList(entityId, branchId, page, _pageSize, query.value)
        .then((value) {
      final isLastPage = value.length < _pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(value);
      } else {
        pagingController.appendPage(value, page + 1);
      }
    }, onError: (error) {
      pagingController.error = error;
    });
  }

  @override
  void onInit() {
    super.onInit();

    var param = Get.arguments as PickerPageParam;

    debounce(query, (String value) {
      pagingController.refresh();
    }, time: const Duration(seconds: 1));

    pagingController.addPageRequestListener((pageKey) {
      fetchPickableList(param.entityId, param.branchId, pageKey);
    });

    userInfo = _authDatasource.getUserInfo()!;
  }

  void onChangeSearchTextField(String value) {
    query.value = value;
  }

  void onTapPickerItem(Pickable pickable) {
    Get.back(result: pickable);
  }
}

class PickerPageParam {
  final int entityId;
  final int branchId;

  PickerPageParam({required this.entityId, required this.branchId});
}
