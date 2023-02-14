
import 'package:social_app/models/login_model.dart';

abstract class SocialRegisterStates {}

class SocialRegisterInitial extends SocialRegisterStates {}

class SocialRegisterLoading extends SocialRegisterStates {}

class SocialRegisterSucess extends SocialRegisterStates
{
}

class SocialRegisterError extends SocialRegisterStates
{
  late final String error;
  SocialRegisterError(this.error);
}

class SocialCreateSucess extends SocialRegisterStates
{
}

class SocialCreateError extends SocialRegisterStates
{
  late final String error;
  SocialCreateError(this.error);
}

class SocialRegisterChangePasswordVisibility extends SocialRegisterStates {}