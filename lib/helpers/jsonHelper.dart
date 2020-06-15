String readStringSafe(Map<String, dynamic> json, String prop) =>
    (json[prop] == null) ? null : json[prop];

bool readBoolSafe(Map<dynamic, dynamic> json, String prop) =>
    (json[prop] == null) ? false : json[prop] as bool;

int readIntSafe(Map<dynamic, dynamic> json, String prop) {
  if (json == null) return 0;
  dynamic value = json[prop];
  if (value is int) return value;
  return (value == null) ? 0.0 : int.tryParse(json[prop]);
}

double readDoubleSafe(Map<dynamic, dynamic> json, String prop) {
  if (json == null) return 0.0;
  dynamic value = json[prop];
  if (value is double) return value;
  return (value == null) ? 0.0 : double.tryParse(json[prop]);
}
