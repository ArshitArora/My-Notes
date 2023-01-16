//login exception

class UserNotFoundException implements Exception {}
class WrongPasswordFoundException implements Exception {}

//regsiter exceptions

class WeakPasswordFoundException implements Exception {}
class EmailAlreadyInUseFoundException implements Exception {}
class InvalidEmailException implements Exception {}

//Generic exceptions

class GenericAuthException implements Exception {}
class UserNotLggedInAuthException implements Exception {}


