import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

enum CustomisationSourceType {
  unknown,
  common,
  rare,
  epic,
}

final customisationSourceValues = EnumValues({
  '0': CustomisationSourceType.unknown,
  '1': CustomisationSourceType.common,
  '2': CustomisationSourceType.rare,
  '3': CustomisationSourceType.epic,
});
