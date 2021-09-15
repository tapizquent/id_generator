import 'package:user_id_generator/database_helpers/database.dart';

abstract class IDatabaseReader {
  List<String> getExistingUsersIdsListFromDatabase();
}

class DatabaseReader implements IDatabaseReader {
  final IDatabase _database;

  DatabaseReader(this._database);

  @override
  List<String> getExistingUsersIdsListFromDatabase() {
    /// Gets users from database, returns a list of only the IDs
    var existingUsersIdList =
        _database.getExistingUsersList().map((e) => e.id).toList();
    return existingUsersIdList;
  }
}
