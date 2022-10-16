//

import 'package:flutter/material.dart';

abstract class TreeNode {
  int get id;
  int? get parentId;
  List<TreeNode> get childs;

  String get title;
}
