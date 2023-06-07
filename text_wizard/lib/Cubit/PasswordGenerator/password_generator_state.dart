part of 'password_generator_cubit.dart';

abstract class PasswordGeneratorState {}

class PasswordGeneratorInitialState extends PasswordGeneratorState {}

class PasswordGeneratorOptionChange extends PasswordGeneratorState {}

class PasswordGeneratorGeneratingPassword extends PasswordGeneratorState {}

class PasswordGeneratorGeneratedPassword extends PasswordGeneratorState {}
