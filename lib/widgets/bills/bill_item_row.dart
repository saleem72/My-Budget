//

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

import '../../helpers/constants.dart';
import '../../helpers/localization/locale_cubit/locale_cubit.dart';
import '../../models/bill_item_model.dart';
import '../../styling/styling.dart';
import '../popup_widget.dart';

class BillItemRow extends StatelessWidget {
  const BillItemRow({
    Key? key,
    required this.item,
  }) : super(key: key);

  final BillItemModel item;

  @override
  Widget build(BuildContext context) {
    return _buildContent(context);
    // return _buildContent(context, formatter, locale);
  }

  Container _buildContent(BuildContext context) {
    final locale = context.read<LocaleCubit>().state;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      // height: Constants.billRowHeight(context, Topology.darkMeduimBody) + 8,
      height: Constants.billMaxRowHeight(
            context,
            title: item.subject,
            style: Topology.darkMeduimBody,
            direction: (locale.languageCode == 'ar'
                ? ui.TextDirection.rtl
                : ui.TextDirection.ltr),
          ) +
          8,
      // "بيجاما ولادي حمراء"
      // "بيجاما ولادي حمراء وصفراء"
      // "سيارة فورملا وان اخر موديل لون اسود"
      // "بي" "سي"
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Slidable(
            key: ValueKey(item),
            endActionPane: ActionPane(
              extentRatio: 0.2,
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  borderRadius: BorderRadius.only(
                    topRight: Platform.localeName == 'ar'
                        ? Radius.zero
                        : const Radius.circular(12),
                    bottomRight: Platform.localeName == 'ar'
                        ? Radius.zero
                        : const Radius.circular(12),
                    topLeft: Platform.localeName == 'ar'
                        ? Radius.zero
                        : const Radius.circular(12),
                    bottomLeft: Platform.localeName == 'ar'
                        ? Radius.zero
                        : const Radius.circular(12),
                  ),
                  flex: 1,
                  onPressed: (context) {
                    debugPrint('Item will be deleted!');
                  },
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                ),
              ],
            ),
            child: _buildPopupContent(context),
          ),
        ],
      ),
    );
  }

  Widget _buildPopupContent(BuildContext context) {
    final locale = context.read<LocaleCubit>().state;
    NumberFormat formatter = NumberFormat("#,##0.##");
    return PopupWidget(
      child: SizedBox(
        height: Constants.billMaxRowHeight(
          context,
          title: item.subject,
          style: Topology.darkMeduimBody,
          direction: (locale.languageCode == 'ar'
              ? ui.TextDirection.rtl
              : ui.TextDirection.ltr),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                item.subject,
                style: Topology.darkMeduimBody,
              ),
            ),
            SizedBox(width: Constants.billRowGap),
            SizedBox(
              width: Constants.billQantityWidth,
              child: Text(
                formatter.format(item.quantity),
                style: Topology.darkMeduimBody,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(width: Constants.billRowGap),
            SizedBox(
              width: Constants.billPriceWidth,
              child: Text(
                formatter.format(item.price),
                style: Topology.darkMeduimBody,
                textAlign: TextAlign.center,
              ),
            ),
            // const SizedBox(width: 8),
            Container(
              padding: EdgeInsets.only(
                left: locale.languageCode == 'ar' ? 0 : 8,
                right: locale.languageCode == 'ar' ? 8 : 0,
              ),
              width: Constants.billTotalWidth,
              child: Stack(
                children: [
                  Align(
                    alignment: locale.languageCode == 'ar'
                        ? Alignment.center
                        : Alignment.center,
                    child: Text(
                      formatter.format(item.total),
                      style: Topology.darkMeduimBody,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  item.notes == null
                      ? const SizedBox.shrink()
                      : Align(
                          alignment: locale.languageCode == 'ar'
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          child: const Icon(
                            Icons.info,
                            size: 20,
                          )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
