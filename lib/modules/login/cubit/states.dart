
import 'package:social_app/models/login_model.dart';

abstract class SocialLoginStates {}

class SocialLoginInitial extends SocialLoginStates {}

class SocialLoginLoading extends SocialLoginStates {}

class SocialLoginSucess extends SocialLoginStates
{
  late final String uId;
  SocialLoginSucess(this.uId);
}

class SocialLoginError extends SocialLoginStates
{
  late final String error;
  SocialLoginError(this.error);
}

class SocialLoginChangePasswordVisibility extends SocialLoginStates {}