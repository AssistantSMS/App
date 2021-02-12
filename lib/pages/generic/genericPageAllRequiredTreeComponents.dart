import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';

import '../../components/tilePresenters/recipeIngredientTreePresenter.dart';
import '../../contracts/recipeIngredient/recipeIngredientTreeDetails.dart';
import '../../helpers/sortHelper.dart';

TreeView getTree(context, List<RecipeIngredientTreeDetails> node) {
  List<TreeNode> parents = List.empty(growable: true);
  // TreeController controller = TreeController(allNodesExpanded: false);
  for (RecipeIngredientTreeDetails child in node) {
    parents.add(TreeNode(
      content: Expanded(
        child: requiredItemTreeDetailsRowPresenter(
          context,
          child,
          child.cost,
        ),
      ),
      children: child.children.map((ttn) => mapChildren(context, ttn)).toList(),
    ));
  }
  // return TreeView(nodes: parents, indent: 30, treeController: controller);
  return TreeView(nodes: parents, indent: 25);
}

TreeNode mapChildren(BuildContext context, RecipeIngredientTreeDetails node) {
  List<TreeNode> children = List.empty(growable: true);

  for (RecipeIngredientTreeDetails child in node.children) {
    var childList = child.children;
    // childList.sort((a, b) => a.children.length.compareTo(b.children.length));
    childList.sort((ttna, ttnb) => boolToInt(ttna.children.length > 0)
        .compareTo(boolToInt(ttnb.children.length > 0)));
    children.add(TreeNode(
      content: Expanded(
        child: requiredItemTreeDetailsRowPresenter(
          context,
          child,
          child.cost,
        ),
      ),
      children: childList.map((ttn) => mapChildren(context, ttn)).toList(),
    ));
  }
  return TreeNode(
    content: Expanded(
      child: requiredItemTreeDetailsRowPresenter(
        context,
        node,
        node.cost,
      ),
    ),
    children: children,
  );
}
