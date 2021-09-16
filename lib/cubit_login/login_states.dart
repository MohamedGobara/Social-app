
abstract class social_states{}


class initializedstates extends social_states {}
class withingsignin extends social_states {}
class successsignin extends social_states {

  // final shopsocialModel socialModel ;
  //
  // successgetpost(this.socialModel);

}
class errorsignin extends social_states {}
class withingsignup extends social_states {}
class successsignup extends social_states {

  // final shopsocialModel socialModel ;
  //
  // successgetpost(this.socialModel);

}
class errorsignup extends social_states {}

class login_firebaseExaption_state extends social_states{}
class signup_firebaseExaption_state extends social_states{}

