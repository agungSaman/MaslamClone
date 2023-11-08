import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../login/data/datasources/auth_datasource.dart';
import '../../../shared/user/data/models/user.dart';
import '../data/datasources/code_master_filter_picker_datasource.dart';
import '../data/models/pickable_code_master_filter.dart';

class CodeMasterFilterPickerController extends GetxController {
  final AuthDatasource _authDatasource;
  final CodeMasterFilterPickerDatasource _codeMasterFilterPickerDatasource;
  final String objectLabel;

  static const _pageSize = 20;

  final PagingController<int, PickableCodeMasterFilter> pagingController =
      PagingController(firstPageKey: 0);

  CodeMasterFilterPickerController(this._authDatasource, this.objectLabel,
      this._codeMasterFilterPickerDatasource);

  final searchTextController = TextEditingController();

  final query = ''.obs;
  final label = ''.obs;

  late User userInfo;

  void fetchPickableList(int entityId, String codeField, int page) {
    _codeMasterFilterPickerDatasource
        .getPickableList(entityId, codeField, page, _pageSize, query.value)
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

    var param = Get.arguments as CodeMasterFilterPickerPageParam;

    debounce(query, (String value) {
      pagingController.refresh();
    }, time: const Duration(seconds: 1));

    label.value = param.label;
    pagingController.addPageRequestListener((pageKey) {
      fetchPickableList(param.entityId, param.codeField, pageKey);
    });

    userInfo = _authDatasource.getUserInfo()!;
  }

  void onChangeSearchTextField(String value) {
    query.value = value;
  }

  void onTapPickerItem(PickableCodeMasterFilter pickableCodeMasterFilter) {
    Get.back(result: pickableCodeMasterFilter);
  }
}

class CodeMasterFilterPickerPageParam {
  final int entityId;
  final String codeField;
  final String label;

  CodeMasterFilterPickerPageParam(
      {required this.entityId, required this.codeField, required this.label});
}
