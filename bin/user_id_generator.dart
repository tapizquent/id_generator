import 'package:user_id_generator/user.dart';
import 'package:user_id_generator/user_id_generator.dart';

void main(List<String> arguments) {
  // I'm guessing these come from temp table or csv file
  var usersToGenerateIdsFor = <User>[];

  // Here just read from database the existing ids on final table
  var currentUsersIdList = <String>[];

  var userIdGenerator = UserIdGenerator(currentUsersIdList);

  for (var user in usersToGenerateIdsFor) {
    var generatedId =
        userIdGenerator.generateNewUserId(user.firstName, user.lastName);

    // Here write to database to insert user with generated id
    // database.write(User(generatedId, blah blah blah));
  }
}
