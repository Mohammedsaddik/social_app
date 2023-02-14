import 'package:social_app/models/login_model.dart';

abstract class SocialState {}

class SocialInitial extends SocialState {}

class SocialChangeBottomNavState extends SocialState {}

class SocialNewPosttate extends SocialState {}

class SocialGetUserLoadindState extends SocialState {}

class SocialGetUserSucessState extends SocialState {}

class SocialGetUserErrorState extends SocialState {
  late final String error;

  SocialGetUserErrorState(this.error);
}

class SocialGetAllUserLoadindState extends SocialState {}

class SocialGetAllUserSucessState extends SocialState {}

class SocialGetAllUserErrorState extends SocialState {
  late final String error;

  SocialGetAllUserErrorState(this.error);
}

class SocialGetPostLoadindState extends SocialState {}

class SocialGetPostSucessState extends SocialState {}

class SocialGetPostErrorState extends SocialState {
  late final String error;

  SocialGetPostErrorState(this.error);
}

class SocialLikePostLoadindState extends SocialState {}

class SocialLikePostSucessState extends SocialState {}

class SocialLikePostErrorState extends SocialState {
  late final String error;

  SocialLikePostErrorState(this.error);
}

class SocialCommentPostLoadindState extends SocialState {}

class SocialCommentPostSucessState extends SocialState {}

class SocialCommentPostErrorState extends SocialState {
  late final String error;

  SocialCommentPostErrorState(this.error);
}

class SocialProfileImagePickedLoadingState extends SocialState {}

class SocialProfileImagePickedSucessState extends SocialState {}

class SocialProfileImagePickedErrorState extends SocialState {}

class SocialUploadProfileImageSucessState extends SocialState {}

class SocialUploadProfileImageErrorState extends SocialState {}

class SocialCoverImagePickedLoadingState extends SocialState {}

class SocialCoverImagePickedSucessState extends SocialState {}

class SocialCoverImagePickedErrorState extends SocialState {}

class SocialUploadCoverImageSucessState extends SocialState {}

class SocialUploadCoverImageErrorState extends SocialState {}

class UpdateUserDataLoadingState extends SocialState {}

class UpdateUserDataSucessState extends SocialState {}

class UpdateUserDataErrorState extends SocialState {}

class SocialCreatePostLoadingState extends SocialState {}

class SocialCreatePostSucessState extends SocialState {}

class SocialCreatePostErrorState extends SocialState {}

class SocialPostImagePickedLoadingState extends SocialState {}

class SocialPostImagePickedSucessState extends SocialState {}

class SocialPostImagePickedErrorState extends SocialState {}

class SocialRemovePostImageState extends SocialState {}

/////////////////////////chats/////////////////////////////

class SocialSendMessageLoadingState extends SocialState {}

class SocialSendMessageSucessState extends SocialState {}

class SocialSendMessageErrorState extends SocialState {}

class SocialGetMessageLoadingState extends SocialState {}

class SocialGetMessageSucessState extends SocialState {}
