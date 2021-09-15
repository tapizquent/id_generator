import 'package:user_id_generator/user.dart';

/// Class that serves as a mock database.
/// We can pretend this is a MySQL database
abstract class IDatabase {
  /// Returns a list of the Users that are currently in the database
  List<User> getExistingUsersList();

  /// Inserts a new User into database
  bool insertNewUser(User newUserId);
}

class Database implements IDatabase {
  final List<User> users = [];

  @override
  List<User> getExistingUsersList() {
    // TODO: implement getExistingUsersList
    throw UnimplementedError();
  }

  @override
  bool insertNewUser(User newUserId) {
    // TODO: implement insertNewUser
    throw UnimplementedError();
  }
}
