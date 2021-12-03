import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../services/database_helper.dart';

class BookmarksProvider with ChangeNotifier {
  List<Map<String, Object>> mangas = [];
  BookmarksProvider(this.mangas);

  void removeManga(String title) {
    DatabaseHelper.db.deleteManga(title);
    mangas.removeWhere((element) => element.containsValue(title));
    notifyListeners();
  }
}
