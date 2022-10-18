//

abstract class TreeNode {
  int get id;
  int? get parentId;
  String get title;
  List<TreeNode> get childs;

  bool get isExpanded;
  set isExpanded(bool isExpanded);
}
