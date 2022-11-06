abstract class LoginStates{}

class LoginInitState extends LoginStates {}

class LoginIsEmailValidState extends LoginStates {}

class LoginChangPassVisibilityState extends LoginStates {}

class LoginSocialRegisterLoadingState extends LoginStates {}
class LoginSocialRegisterSuccessState extends LoginStates {}
class LoginSocialRegisterErrorState extends LoginStates {}

class LoginSocialCreateUserLoadingState extends LoginStates {}
class LoginSocialCreateUserSuccessState extends LoginStates {}
class LoginSocialCreateUserErrorState extends LoginStates {}