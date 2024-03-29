

part of 'setup.dart';


/// Thrown if during the sign up process if a failure occurs.
class SignUpFailure implements Exception {}

class SignUpWithEmailAndPasswordFailure implements Exception {
  /// {@macro sign_up_with_email_and_password_failure}
  const SignUpWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  /// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/createUserWithEmailAndPassword.html
  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          'Please enter a stronger password.',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }

  /// The associated error message.
  final String message;
}


/// Thrown during the login process if a failure occurs.
class LogInWithEmailAndPasswordFailure implements Exception {
  /// {@macro log_in_with_email_and_password_failure}
  const LogInWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithEmailAndPasswordFailure(
          'Incorrect password, please try again.',
        );
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }

  /// The associated error message.
  final String message;
}

/// Thrown during the login process if a failure occurs.
class LogInAnonymouslyFailure implements Exception {}

class LogInWithFacebookFailure implements Exception {}

/// Thrown during the sign in with google process if a failure occurs.
class LogInWithGoogleFailure implements Exception {
  /// {@macro log_in_with_google_failure}
  const LogInWithGoogleFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithGoogleFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const LogInWithGoogleFailure(
          'Account exists with different credentials.',
        );
      case 'invalid-credential':
        return const LogInWithGoogleFailure(
          'The credential received is malformed or has expired.',
        );
      case 'operation-not-allowed':
        return const LogInWithGoogleFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'user-disabled':
        return const LogInWithGoogleFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithGoogleFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithGoogleFailure(
          'Incorrect password, please try again.',
        );
      case 'invalid-verification-code':
        return const LogInWithGoogleFailure(
          'The credential verification code received is invalid.',
        );
      case 'invalid-verification-id':
        return const LogInWithGoogleFailure(
          'The credential verification ID received is invalid.',
        );
      default:
        return const LogInWithGoogleFailure();
    }
  }

  /// The associated error message.
  final String message;
}

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}




/// {@template cache_client}
/// An in-memory cache client.
/// {@endtemplate}
class CacheClient {
  /// {@macro cache_client}
  CacheClient() : _cache = <String, Object>{};

  final Map<String, Object> _cache;

  Future<void> _save(User user) async {
    // Create a box collection
    final collection = await BoxCollection.open(
      'LoggedUserBox', // Name of your database
      {'users', 'credentials'}, // Names of your boxes
    );

    // Open your boxes. Optional: Give it a type.
    final catsBox = await collection.openBox<Map<String, dynamic>>('users');

    // Put something in

    await catsBox.put(user.email, user.toMap());
    //await catsBox.put('loki', {'name': 'Loki', 'age': 2});

    // Get values of type (immutable) Map?
    final loki = await catsBox.get(user.email);
    //print('Loki is ${loki?['age']} years old.');

    // Returns a List of values
    final cats = await catsBox.getAll(['loki', 'fluffy']);
    //print(cats);
  }

  /// Writes the provide [key], [value] pair to the in-memory cache.
  void write<T extends Object>({required String key, required T value}) {
    // todo : listen to my hive database

    _cache[key] = value;
  }

  /// Looks up the value for the provided [key].
  /// Defaults to `null` if no value exists for the provided key.
  T? read<T extends Object>({required String key}) {
    final value = _cache[key];
    if (value is T) return value;
    return null;
  }
}

/// {@template authentication_repository}
/// Repository which manages user authentication_bloc.
/// {@endtemplate}
///
class AuthRepository {
  /// {@macro authentication_repository}
  AuthRepository({
    CacheClient? cache,
    firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _cache = cache ?? CacheClient(),
        //_firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final CacheClient _cache;
  //final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;


  // Create a stream controller for connectivity status
  final StreamController<User> _userLoginController = StreamController.broadcast();



  /// Whether or not the current environment is web
  /// Should only be overriden for testing purposes. Otherwise,
  /// defaults to [kIsWeb]
  @visibleForTesting
  bool isWeb = kIsWeb;

  /// User cache key.
  /// Should only be used for testing purposes.
  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [User.empty] if the user is not authenticated.
  Stream<User> get user {

    return _userLoginController.stream..listen((User user) {
       _cache.write(key: userCacheKey, value: user);
    });

    /*return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      _cache.write(key: userCacheKey, value: user);
      return user;
    });*/


  }

  /// Returns the current cached user.
  /// Defaults to [User.empty] if there is no cached user.
  User get currentUser {
    return _cache.read<User>(key: userCacheKey) ?? User.empty;
  }

  /// Creates a new user with the provided [email] and [password].
  ///
  /// Throws a [SignUpWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> _signUp({required String email, required String password}) async {
    try {

      //http.post();
      /*await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );*/
    } on Exception catch (e) {
      throw SignUpWithEmailAndPasswordFailure(e.toString());
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  /// Starts the Sign In with Google Flow.
  ///
  /// Throws a [LogInWithGoogleFailure] if an exception occurs.
  Future<void> logInWithGoogle() async {
    try {
      //late final firebase_auth.AuthCredential credential;
      if (isWeb) {
        //final googleProvider = firebase_auth.GoogleAuthProvider();
        //_firebaseAuth.signInWithProvider(provider)
        //final userCredential = await _firebaseAuth.signInWithPopup(googleProvider);
        //credential = userCredential.credential!;
      } else {
        final googleUser = await _googleSignIn.signIn();
        final googleAuth = await googleUser!.authentication;

        /*credential = firebase_auth.GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );*/
      }

      //await _firebaseAuth.signInWithCredential(credential);
    } on Exception catch (e) {
      debugPrint("FirebaseAuthException : LogInWithGoogleFailure.fromCode($e)");

      throw LogInWithGoogleFailure(e.toString());
    } catch (_) {
      debugPrint("### ### LogInWithGoogleFailure() => Error: $_ ");
      throw const LogInWithGoogleFailure();

    }
  }

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> logInWithEmailAndPassword({
    required String employeeID,
    required String email,
    required String password,
  }) async {
    try {
      BackendServer databaseAccess = BackendServer(
          "/user",
          data: {
            "id" : "lordyhas",
            "reg_no" : employeeID,
            "email" : email,
            "password" : password,
          }
      );

      /*await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );*/
      databaseAccess.login().then((user) => _userLoginController.add(user));

    } on Exception catch (e) {
      debugPrint("FirebaseAuthException : LogInWithEmailAndPasswordFailure.fromCode($e)");
      throw LogInWithEmailAndPasswordFailure(e.toString());
    } catch (_) {
      debugPrint("### ### LogInWithEmailAndPasswordFailure() => Error: $_ ");
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await Future.wait([
        //_firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (_) {
      throw LogOutFailure();
    }
  }
}

/*
extension on firebase_auth.User {
  //bool get emailNotVerified => !emailVerified;
  User get toUser {
    return User(
        id: uid,
        email: email,
        name: displayName,
        photoMail: photoURL,
        phoneNumber: phoneNumber,
        lastDate: metadata.lastSignInTime,
        creationDate: metadata.creationTime,
        isAnonymous: isAnonymous,
        isCheckMail: emailVerified,

    );
  }
}*/
