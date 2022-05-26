import 'package:dartz/dartz.dart';
import 'package:ddd_tutorial/domain/auth/auth_failure.dart';
import 'package:ddd_tutorial/domain/auth/value_objects.dart';
import 'package:injectable/injectable.dart';

// FirebaseAuth, GoogleSignIn



abstract class IAuthFacade{
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({required EmailAddress emailAddress, required Password password});

  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({required EmailAddress emailAddress, required Password password});

  Future<Either<AuthFailure, Unit>> signInWithGoogle();
}