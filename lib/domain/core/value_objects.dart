import 'package:dartz/dartz.dart';
import 'package:ddd_tutorial/domain/core/errors.dart';
import 'package:ddd_tutorial/domain/core/failures.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class ValueObject<T> {
  const ValueObject();

  Either<ValueFailure<T>, T> get value;

  bool isValid() => value.isRight();

  T getOrCrash() {
    // id = identity - same as writing the right side
    return value.fold((l) => throw UnexpectedValueError(l), id) ;
  }

  @override
  String toString() => 'Value($value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ValueObject<T> &&
      other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

}