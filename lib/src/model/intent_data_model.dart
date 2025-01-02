class IntentDataModel {
  const IntentDataModel({
    required this.action,
    required this.categories,
    required this.data,
    required this.package,
  });

  final String action;
  final List<String> categories;
  final String data;
  final String package;

  factory IntentDataModel.empty() => const IntentDataModel(
    action: '',
    categories: [],
    data: '',
    package: '',
  );

  @override
  String toString() {
    return '{ action = $action, categories = $categories, data = $data, package = $package }';
  }
}