import 'package:bloc/bloc.dart';
import 'package:my_budget/database/models/subject_with_childs.dart';
import 'package:my_budget/helpers/constants.dart';

class SubjectsTreeCubit extends Cubit<bool> {
  final List<SubjectWithChilds> _subjects;
  SubjectsTreeCubit({required List<SubjectWithChilds> subjects})
      : _subjects = subjects,
        super(true);

  double heightForNode(SubjectWithChilds node) {
    const tileHeight = Constants.subjectTileHeight;
    if (!node.isExpanded) {
      return tileHeight;
    } else {
      if (node.childs.isEmpty) {
        return tileHeight;
      } else {
        // Tile is Expanded we need to calculate height
        final childsHeights = node.childs.map((e) => heightForNode(e)).toList();
        final totalHeight =
            childsHeights.reduce((value, element) => value + element);
        final double extra = node.parentId == null ? 0 : tileHeight;
        // final double extra = 0;
        final result = totalHeight;

        // print(
        //     'node: ${node.title}, count: ${childsHeights.length} totalHeight: $totalHeight, result: $result');

        return result + tileHeight;
      }
    }

    // return 44 + node.childs.length * 44;
  }

  void toggleExpandedForNode(SubjectWithChilds node) {
    node.isExpanded = !node.isExpanded;
    emit(!state);
  }
}
