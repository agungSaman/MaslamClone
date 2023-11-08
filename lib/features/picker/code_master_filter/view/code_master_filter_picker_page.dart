import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../view/widgets/pickable_header_item_widget.dart';
import '../../view/widgets/pickable_item_widget.dart';
import '../data/models/pickable_code_master_filter.dart';
import 'code_master_filter_picker_controller.dart';

//ignore: must_be_immutable
class CodeMasterFilterPickerPage
    extends GetView<CodeMasterFilterPickerController> {
  static const routeName = '/code-mstr-picker';

  late String controllerTag;

  @override
  String? get tag => controllerTag;

  CodeMasterFilterPickerPage({Key? key, required this.controllerTag})
      : super(key: key);

  Widget searchBar() => Container(
        decoration: const BoxDecoration(
            color: Color.fromRGBO(117, 74, 199, 0.35),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              const Icon(
                Icons.search,
                size: 16,
                color: Colors.white,
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: TextField(
                  controller: controller.searchTextController,
                  onChanged: (value) =>
                      controller.onChangeSearchTextField(value),
                  style: GoogleFonts.sourceSansPro(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.white),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Search by ${controller.label}',
                      hintStyle: GoogleFonts.sourceSansPro(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.4)),
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none),
                ),
              )
            ],
          ),
        ),
      );

  Widget buildEmptyState() => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(
              Icons.summarize_outlined,
              size: 56,
              color: Color.fromRGBO(7, 56, 130, 1.0),
            ),
            const SizedBox(height: 12),
            Text(
              'No data found',
              textAlign: TextAlign.center,
              style: GoogleFonts.sourceSansPro(
                  fontSize: 16, fontWeight: FontWeight.w500),
            )
          ]),
        ),
      );

  Widget buildPickerList() {
    return PagedListView(
        pagingController: controller.pagingController,
        builderDelegate: PagedChildBuilderDelegate(
            firstPageProgressIndicatorBuilder: (context) => const Center(
                    child: CircularProgressIndicator(
                  color: Color.fromRGBO(7, 56, 130, 1.0),
                )),
            newPageProgressIndicatorBuilder: (context) => const Center(
                    child: CircularProgressIndicator(
                  color: Color.fromRGBO(7, 56, 130, 1.0),
                )),
            firstPageErrorIndicatorBuilder: (context) => buildErrorState(),
            itemBuilder: (BuildContext context, PickableCodeMasterFilter item,
                int index) {
              if (index != 0 &&
                  item.value[0] ==
                      controller
                          .pagingController.itemList![index - 1].value[0]) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: const Color.fromRGBO(244, 245, 247, 1.0),
                    ),
                    PickableItemWidget(
                        value: item.value,
                        onTapItem: () => controller.onTapPickerItem(item)),
                  ],
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PickableHeaderItemWidget(title: item.value[0]),
                    PickableItemWidget(
                        value: item.value,
                        onTapItem: () => controller.onTapPickerItem(item)),
                  ],
                );
              }
            },
            noItemsFoundIndicatorBuilder: (context) => buildEmptyState()));
  }

  Widget buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(
            Icons.error,
            size: 56,
            color: Colors.red,
          ),
          const SizedBox(height: 12),
          Text(
            'An error occurred while processing the data',
            textAlign: TextAlign.center,
            style:
                GoogleFonts.sourceSansPro(fontSize: 16, fontWeight: FontWeight.w500),
          )
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [0.1, 0.5],
                colors: [
                  Color.fromRGBO(7, 56, 130, 1.0),
                  Color.fromRGBO(7, 56, 130, 1.0)
                ],
              ),
            ),
          ),
          title: Text(
            'Select ${controller.label}',
            style: GoogleFonts.sourceSansPro(
                fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white),
          ),
          bottom: PreferredSize(
            preferredSize: const Size(60, 60),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: searchBar(),
            ),
          ),
        ),
        body: buildPickerList());
  }
}
