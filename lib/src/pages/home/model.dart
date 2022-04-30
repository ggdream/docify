class BottomNavItemModel {
  final String image;
  final String title;
  final String content;
  final void Function()? onTap;

  BottomNavItemModel({
    required this.image,
    required this.title,
    required this.content,
    this.onTap,
  });
}

class TopNavItemModel {
  final String name;
  final String? path;
  final String? hash;
  final List<TopNavItemModel>? children;

  TopNavItemModel({
    required this.name,
    this.path,
    this.hash,
    this.children,
  });
}

class CenterItemModel {
  final String title;
  final String image;
  final String? content;

  CenterItemModel({
    required this.title,
    required this.image,
    required this.content,
  });
}
