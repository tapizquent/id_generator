class User {
  final String id;
  final String firstName;
  final String lastName;

  User(this.id, this.firstName, this.lastName);

  /// Builds a User object from a Map/Dictionary. This data is usually coming
  /// from a database.
  static User fromMap(Map<String, Object> data) {
    return User(
      data['id'] as String,
      data['firstName'] as String,
      data['lastName'] as String,
    );
  }

  User copyWith(String id) {
    return User(id, firstName, lastName);
  }

  /// Builds Map/Dictionary from the current User with all of its
  /// properties and fields.
  /// Userful when writing to a database that is expecting certain format
  Map<String, Object> toMap() {
    return {};
  }
}
