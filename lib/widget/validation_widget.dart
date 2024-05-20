class ValidiationWidget{
  static String? validateEmail(String?value){
    if(value==null || value.isEmpty){
      return "Email is required";
    }
    final emailRegExp=RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if(!emailRegExp.hasMatch(value)){
      return "invalid email address";
    }
    return null;


  }


  static String? validatePassword(String?value){
    if(value==null || value.isEmpty){
      return "password is required";
    }
    if(value.length <6){
      return "password must be at least 6 character long.";

    }
    //check for upper letters
    if(!value.contains(RegExp(r'[A-Z]'))){
      return "password must containg at least one uppercase letter";
    }
    if(!value.contains(RegExp(r'[0-9]'))){
      return "password must containg at least one number";
    }
    if(!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))){
      return "password must containg at least one special character.";
    }
    return null;
  }

  static String? validateEmtyText(String? fieldName,String?value){
    if(value==null || value.isEmpty){
      return "$fieldName is required";
    }
  }

  static String? validatePhoneNumber(String?value){
    if(value==null || value.isEmpty){
      return "Phone number is required";
    }
    final phoneRegExp=RegExp(r'^\d{10}$');
    if(!phoneRegExp.hasMatch(value)){
      return "Invalid phone number format(10 digit required";
    }
    return null;
  }

}