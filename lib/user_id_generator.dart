abstract class IUserIdGenerator {
  String generateNewUserId(
    String firstName,
    String lastName,
  );

  String generateIdWithNumber(
    String firstName,
    String lastName, {
    int suffixNumber = 1,
  });

  String generateIdFromFirstAndLastName(
    String firstName,
    String lastName, {
    int firstNameLengthToUse = 1,
  });

  bool idExistsInUsersList(String id);
}

class UserIdGenerator implements IUserIdGenerator {
  final List<String> currentUsersIdList;

  UserIdGenerator(this.currentUsersIdList);

  @override
  String generateNewUserId(
    String firstName,
    String lastName,
  ) {
    String generatedId = generateIdFromFirstAndLastName(firstName, lastName);

    int lengthOfFirstName = 1;

    while (idExistsInUsersList(generatedId) && lengthOfFirstName < 3) {
      lengthOfFirstName++;

      generatedId = generateIdFromFirstAndLastName(
        firstName,
        lastName,
        firstNameLengthToUse: lengthOfFirstName,
      );
    }

    int suffixNumber = 1;

    while (idExistsInUsersList(generatedId)) {
      generatedId = generateIdWithNumber(
        firstName,
        lastName,
        suffixNumber: suffixNumber,
      );

      suffixNumber++;
    }

    currentUsersIdList.add(generatedId);
    return generatedId;
  }

  @override
  String generateIdFromFirstAndLastName(
    String firstName,
    String lastName, {
    int firstNameLengthToUse = 1,
  }) {
    if (firstNameLengthToUse > firstName.length) {
      firstNameLengthToUse = firstName.length;
    }

    var idToReturn =
        firstName.toLowerCase().substring(0, firstNameLengthToUse) +
            lastName.toLowerCase();

    if (idToReturn.length > 20) {
      idToReturn = idToReturn.substring(0, 20);
    }

    return idToReturn;
  }

  @override
  bool idExistsInUsersList(String id) {
    return currentUsersIdList.contains(id);
  }

  @override
  String generateIdWithNumber(
    String firstName,
    String lastName, {
    int suffixNumber = 1,
  }) {
    var firstAndLastNameId =
        generateIdFromFirstAndLastName(firstName, lastName);
    var suffixNumberAsString = suffixNumber.toString();
    var idToReturn = firstAndLastNameId + suffixNumberAsString;

    if (idToReturn.length > 20) {
      idToReturn =
          firstAndLastNameId.substring(0, 20 - suffixNumberAsString.length) +
              suffixNumberAsString;
    }

    return idToReturn;
  }
}
