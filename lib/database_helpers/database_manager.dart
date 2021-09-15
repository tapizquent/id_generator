import 'package:user_id_generator/database_helpers/database_reader.dart';
import 'package:user_id_generator/database_helpers/database_writter.dart';
import 'package:user_id_generator/user.dart';

abstract class IDatabaseManager {
  List<String> getExistingUsersIdsListFromDatabase();
  bool insertNewUserIntoDatabase(User newUser);
}

class DatabaseManager implements IDatabaseManager {
  final IDatabaseReader _databaseReader;
  final IDatabaseWriter _databaseWriter;

  DatabaseManager(this._databaseReader, this._databaseWriter);

  @override
  List<String> getExistingUsersIdsListFromDatabase() {
    return _databaseReader.getExistingUsersIdsListFromDatabase();
  }

  @override
  bool insertNewUserIntoDatabase(User newUser) {
    return _databaseWriter.insertNewUserIntoDatabase(newUser);
  }
}
