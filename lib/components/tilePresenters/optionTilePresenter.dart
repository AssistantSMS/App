import 'package:flutter/material.dart';

import '../../contracts/search/dropdownOption.dart';
import '../../helpers/popupMenuButtonHelper.dart';
import 'genericTilePresenter.dart';

Widget optionTilePresenter(BuildContext context, DropdownOption option,
    {Function onDelete}) {
  return Card(
    child: genericListTile(
      context,
      leadingImage: null,
      name: option.title,
      onTap: () {
        Navigator.of(context).pop(option.value);
      },
      trailing: (onDelete != null)
          ? popupMenu(context, onEdit: null, onDelete: onDelete)
          : null,
    ),
    margin: const EdgeInsets.all(0.0),
  );
}
