class ImageConverter {
  static List<int> convert(List<dynamic> list) {
    return list.map<int>((e) => e as int).toList();
  }
}
