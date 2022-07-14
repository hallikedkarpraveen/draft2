import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class ProjectDraft2FirebaseUser {
  ProjectDraft2FirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

ProjectDraft2FirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<ProjectDraft2FirebaseUser> projectDraft2FirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<ProjectDraft2FirebaseUser>(
            (user) => currentUser = ProjectDraft2FirebaseUser(user));
