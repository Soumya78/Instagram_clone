enum FileType {
  image,
  video;
  String get asString {
  switch (this) {
    case FileType.image:
      return "image";
    case FileType.video:
      return "video";
  }
}
}