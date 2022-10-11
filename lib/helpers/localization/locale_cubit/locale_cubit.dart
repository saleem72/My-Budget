import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:my_budget/helpers/safe/safe.dart';

class LocaleCubit extends Cubit<Locale> {
  final Safe _safe;
  LocaleCubit({required Safe safe})
      : _safe = safe,
        super(safe.getLocal());

  Future<Locale> setLocal(BuildContext context, String languageCode) async {
    final local = await _safe.setLocal(languageCode);
    emit(local);
    return local;
  }

  Locale getLocal() {
    final local = _safe.getLocal();
    return local;
  }
}
