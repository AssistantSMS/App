String joinStringList(List<String> array, String separator) {
  if (array.length == 1) return array[0];

  String result = '';
  int maxIndex = array.length - 1;
  for (var index = 0; index < maxIndex; index++) {
    result += array[index] + separator;
  }
  return result + array[maxIndex];
}
