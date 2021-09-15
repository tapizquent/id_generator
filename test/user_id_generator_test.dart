import 'package:user_id_generator/user_id_generator.dart';
import 'package:test/test.dart';

void main() {
  IUserIdGenerator userIdGenerator;
  List<String> currentUsersIdLists;

  group('idExistsInUsersList', () {
    test('when id in list, returns true', () {
      var existingId = 'jdoe';
      currentUsersIdLists = <String>[existingId];
      userIdGenerator = UserIdGenerator(currentUsersIdLists);

      expect(userIdGenerator.idExistsInUsersList(existingId), isTrue);
    });

    test('when id not in list, returns false', () {
      var existingId = 'jdoe';
      var notInListId = 'johnny';
      currentUsersIdLists = <String>[existingId];
      userIdGenerator = UserIdGenerator(currentUsersIdLists);

      expect(userIdGenerator.idExistsInUsersList(notInListId), isFalse);
    });
  });

  group('generateIdFromFirstAndLastName', () {
    test(
        'when firstNameLengthToUse is 1, combines first letter of first name '
        'with full last name', () {
      var firstName = 'John';
      var lastName = 'Doe';

      currentUsersIdLists = <String>[];
      userIdGenerator = UserIdGenerator(currentUsersIdLists);

      expect(
          userIdGenerator.generateIdFromFirstAndLastName(firstName, lastName),
          'jdoe');
    });

    test(
        'when firstNameLengthToUse is N, combines first N letters of first name '
        'with full last name', () {
      var firstName = 'John';
      var lastName = 'Doe';

      currentUsersIdLists = <String>[];
      userIdGenerator = UserIdGenerator(currentUsersIdLists);

      expect(
          userIdGenerator.generateIdFromFirstAndLastName(firstName, lastName,
              firstNameLengthToUse: 2),
          'jodoe');
      expect(
          userIdGenerator.generateIdFromFirstAndLastName(firstName, lastName,
              firstNameLengthToUse: 3),
          'johdoe');
      expect(
          userIdGenerator.generateIdFromFirstAndLastName(firstName, lastName,
              firstNameLengthToUse: 4),
          'johndoe');
      expect(
          userIdGenerator.generateIdFromFirstAndLastName(firstName, lastName,
              firstNameLengthToUse: 10),
          'johndoe');
    });

    test(
        'when combination of first and last name exceeds 20 characters, trims '
        'id to 20 characters', () {
      var firstName = 'John';
      var lastName = 'TapizquentTapizquentTapizquent';

      currentUsersIdLists = <String>[];
      userIdGenerator = UserIdGenerator(currentUsersIdLists);

      var generatedId =
          userIdGenerator.generateIdFromFirstAndLastName(firstName, lastName);

      expect(generatedId, 'jtapizquenttapizquen');
      expect(generatedId.length, 20);
    });
  });

  group('generateIdWithNumber', () {
    test(
        'generates id with first letter of first name, full last name and number',
        () {
      var firstName = 'John';
      var lastName = 'Doe';

      currentUsersIdLists = <String>[];
      userIdGenerator = UserIdGenerator(currentUsersIdLists);

      expect(
          userIdGenerator.generateIdWithNumber(firstName, lastName), 'jdoe1');
      expect(
          userIdGenerator.generateIdWithNumber(firstName, lastName,
              suffixNumber: 2),
          'jdoe2');
      expect(
          userIdGenerator.generateIdWithNumber(firstName, lastName,
              suffixNumber: 10),
          'jdoe10');
    });

    test(
        'when generated id exceeds 20 characters, trims first and last name '
        'combination id to enough characters to fit numbers at end', () {
      var firstName = 'John';
      var lastName = 'TapizquentTapizquentTapizquent';

      currentUsersIdLists = <String>[];
      userIdGenerator = UserIdGenerator(currentUsersIdLists);

      var generatedId =
          userIdGenerator.generateIdWithNumber(firstName, lastName);

      var generatedIdWithSuffix2 = userIdGenerator
          .generateIdWithNumber(firstName, lastName, suffixNumber: 2);

      var generatedIdWithSuffix20000 = userIdGenerator
          .generateIdWithNumber(firstName, lastName, suffixNumber: 20000);

      expect(generatedId, 'jtapizquenttapizque1');
      expect(generatedId.length, 20);

      expect(generatedIdWithSuffix2, 'jtapizquenttapizque2');
      expect(generatedIdWithSuffix2.length, 20);

      expect(generatedIdWithSuffix20000, 'jtapizquenttapi20000');
      expect(generatedIdWithSuffix20000.length, 20);
    });
  });

  group('generateNewUserId', () {
    test('when id does not exist in list, generates id with correct format',
        () {
      var firstName = 'John';
      var lastName = 'Doe';

      currentUsersIdLists = <String>[];
      userIdGenerator = UserIdGenerator(currentUsersIdLists);

      expect(userIdGenerator.generateNewUserId(firstName, lastName), 'jdoe');
      expect(userIdGenerator.generateNewUserId(firstName, lastName), 'jodoe');
      expect(userIdGenerator.generateNewUserId(firstName, lastName), 'johdoe');
      expect(userIdGenerator.generateNewUserId(firstName, lastName), 'jdoe1');
      expect(userIdGenerator.generateNewUserId(firstName, lastName), 'jdoe2');
      expect(userIdGenerator.generateNewUserId(firstName, lastName), 'jdoe3');
      expect(userIdGenerator.generateNewUserId(firstName, lastName), 'jdoe4');
      expect(userIdGenerator.generateNewUserId(firstName, lastName), 'jdoe5');
    });

    test(
        'when id exists in list, generates with first 2 letters of first '
        'name and full last name', () {
      var firstName = 'John';
      var lastName = 'Doe';

      currentUsersIdLists = <String>['jdoe'];
      userIdGenerator = UserIdGenerator(currentUsersIdLists);

      expect(userIdGenerator.generateNewUserId(firstName, lastName), 'jodoe');
    });

    test(
        'when id exists in list with 2 or more letters of first name, generates '
        'with respective first name letters (up to 3) and full last name', () {
      var firstName = 'John';
      var lastName = 'Doe';

      currentUsersIdLists = <String>['jdoe'];
      userIdGenerator = UserIdGenerator(currentUsersIdLists);

      expect(userIdGenerator.generateNewUserId(firstName, lastName), 'jodoe');
      expect(userIdGenerator.generateNewUserId(firstName, lastName), 'johdoe');
    });

    test(
        'when id exists in list with 3 letters of first name, generates '
        'with first name letter and full last name and number at end', () {
      var firstName = 'John';
      var lastName = 'Doe';

      currentUsersIdLists = <String>['jdoe', 'jodoe', 'johdoe'];
      userIdGenerator = UserIdGenerator(currentUsersIdLists);

      expect(userIdGenerator.generateNewUserId(firstName, lastName), 'jdoe1');
      expect(userIdGenerator.generateNewUserId(firstName, lastName), 'jdoe2');
      expect(userIdGenerator.generateNewUserId(firstName, lastName), 'jdoe3');
      expect(userIdGenerator.generateNewUserId(firstName, lastName), 'jdoe4');
      expect(userIdGenerator.generateNewUserId(firstName, lastName), 'jdoe5');
      expect(userIdGenerator.generateNewUserId(firstName, lastName), 'jdoe6');
    });

    test(
        'when id exceeds max characters of 20, trims to 20 characters '
        'with first name letter and full last name and number at end', () {
      var firstName = 'John';
      var lastName = 'TapizquentTapizquent';

      currentUsersIdLists = <String>[];
      userIdGenerator = UserIdGenerator(currentUsersIdLists);

      expect(userIdGenerator.generateNewUserId(firstName, lastName),
          'jtapizquenttapizquen');
      expect(userIdGenerator.generateNewUserId(firstName, lastName),
          'jotapizquenttapizque');
      expect(userIdGenerator.generateNewUserId(firstName, lastName),
          'johtapizquenttapizqu');
      expect(userIdGenerator.generateNewUserId(firstName, lastName),
          'jtapizquenttapizque1');
      expect(userIdGenerator.generateNewUserId(firstName, lastName),
          'jtapizquenttapizque2');
      expect(userIdGenerator.generateNewUserId(firstName, lastName),
          'jtapizquenttapizque3');
    });
  });
}
