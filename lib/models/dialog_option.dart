// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class DialogOption extends Equatable {
  final int id;
  final Widget dialog;
  final bool isVisible;
  final Function onClose;
  final DialogOperation operation;
  const DialogOption({
    required this.id,
    required this.dialog,
    required this.isVisible,
    required this.onClose,
    required this.operation,
  });

  @override
  List<Object?> get props => [id, operation, isVisible];

  DialogOption copyWith({
    int? id,
    Widget? dialog,
    bool? isVisible,
    Function? onClose,
    DialogOperation? operation,
  }) {
    return DialogOption(
      id: id ?? this.id,
      dialog: dialog ?? this.dialog,
      isVisible: isVisible ?? this.isVisible,
      onClose: onClose ?? this.onClose,
      operation: operation ?? this.operation,
    );
  }

  @override
  String toString() =>
      'ScreenWithDialog(id: $id, isVisible: $isVisible, operation: ${operation.toString()})';

  @override
  bool get stringify => true;
}

enum DialogOperation { none, cancel, save }
