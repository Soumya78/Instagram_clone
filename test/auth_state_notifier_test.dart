import 'package:flutter_test/flutter_test.dart';

// Fake Storage for saving user info
class FakeUserInfoStorage {
  bool shouldThrow = false;

  Future<void> saveUserInfo({required String uid, required String email, required String displayname}) async {
    if (shouldThrow) throw Exception('Failed to save user info');
    if (uid.isEmpty) throw ArgumentError('UID cannot be empty');
    // Simulate saving user info
    print('Saving user info: $uid, $email, $displayname');
  }
}

// Fake Authenticator to simulate user credentials
class FakeAuthenticator {
  String get email => 'fake@example.com';
  String get displayName => 'Fake User';
}

void main() {
  group('saveUserInfo', () {
    test('should save user info successfully', () async {
      // Arrange: Create fakes and configure them
      final fakeStorage = FakeUserInfoStorage();
      final fakeAuth = FakeAuthenticator();

      // Act: Call the function
      final userId = '12345';
      await fakeStorage.saveUserInfo(
        uid: userId,
        email: fakeAuth.email,
        displayname: fakeAuth.displayName,
      );

      // Assert: If no exception is thrown, it passes
      print('Test passed! User info saved correctly.');
    });

    test('should fail when uid is empty', () async {
      // Arrange
      final fakeStorage = FakeUserInfoStorage();
      final fakeAuth = FakeAuthenticator();

      // Act & Assert: Expect an ArgumentError
      expect(
            () => fakeStorage.saveUserInfo(
          uid: '', // Invalid UID
          email: fakeAuth.email,
          displayname: fakeAuth.displayName,
        ),
        throwsArgumentError,
      );
    });

    test('should fail when storage throws an exception', () async {
      // Arrange
      final fakeStorage = FakeUserInfoStorage()..shouldThrow = true; // Simulate failure
      final fakeAuth = FakeAuthenticator();

      // Act & Assert: Expect an Exception
      expect(
            () => fakeStorage.saveUserInfo(
          uid: '12345',
          email: fakeAuth.email,
          displayname: fakeAuth.displayName,
        ),
        throwsException,
      );
    });
  });
}
