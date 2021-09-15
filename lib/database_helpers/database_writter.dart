import 'package:user_id_generator/database_helpers/database.dart';
import 'package:user_id_generator/user.dart';

abstract class IDatabaseWriter {
  bool insertNewUserIntoDatabase(User newUserId);
}

class DatabaseWriter implements IDatabaseWriter {
  final IDatabase database;

  DatabaseWriter(this.database);

  @override
  bool insertNewUserIntoDatabase(User newUser) {
    return database.insertNewUser(newUser);
  }
}
