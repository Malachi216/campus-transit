class Validators {
  static Pattern phoneNumberPattern = r'[0-9]$'; //r'^(?:[+0]9)?[0-9]{10}$';
  static RegExp _specialCharactersExp = RegExp(r"[$&+,:;=?@#|'<>.^*()%!-]");
  static RegExp _upperCaseExp = RegExp("[A-Z]");
  static RegExp _numberExp = RegExp("[0-9]");
  static RegExp _emailExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  Validators._();

  //sign in
  static String passwordValidator(String value) {
    if (value == null || value.isEmpty) {
      return 'Please fill in this field';
    }
    return null;
  }

  static String phoneNumberValidator(String phoneNumber) {
    RegExp regex = RegExp(phoneNumberPattern);
    if (!phoneNumber.startsWith('0')) {
      return 'Phone number should start with 0';
    } else if (regex.hasMatch(phoneNumber) && phoneNumber.length >= 10) {
      return null;
    } else if (phoneNumber.length < 10) {
      return 'Digits cannot be less than 10';
    } else {
      return 'Field can only contain digits';
    }
  }

//sign up
  static String signUpPasswordValidator(String password) {
    if (password.length <= 6) {
      return "Must be greater than 6 characters.";
    } else if (!password.contains(_specialCharactersExp)) {
      return "Must contain at least a special character";
    } else if (!password.contains(_upperCaseExp)) {
      return 'Must contain at least a upper case';
    } else if (!password.contains(_numberExp)) {
      return 'Must contain at least a number';
    }
    return null;
  }

  static String signUpEmailValidator(String emailAddress) {
    if (!_emailExp.hasMatch(emailAddress)) {
      return ('Enter a valid email address');
    }
    return null;
  }

  static String signUpPhoneNumberValidator(String phoneNumber) {
    RegExp regex = RegExp(phoneNumberPattern);
    if (!phoneNumber.startsWith('0')) {
      return 'Phone number should start with 0';
    } else if (regex.hasMatch(phoneNumber) && phoneNumber.length >= 10) {
      return null;
    } else if (phoneNumber.length < 10) {
      return 'Digits cannot be less than 10';
    } else {
      return 'Field can only contain digits';
    }
  }

  static String bvnValidator(String bvn) {
    if (bvn.length != 11) {
      return "Enter a valid bvn";
    }
    return null;
  }

  static String accountValidator(String accountNumber) {
    if (accountNumber.length != 10) {
      return "Enter a valid account number";
    }
    return null;
  }

  static String randomValidator(String value) {
    if (value == null || value.isEmpty) {
      return 'Please fill in this field';
    }
    return null;
  }

  static String loanAmountValidator(String value, String currencySymbol) {
    num moneyValue = num.tryParse(value.replaceAll(',', ''));

    try {
      if (moneyValue == null || moneyValue == 0) {
        return 'Please enter a loan amount';
      } else if (moneyValue > 50000.00) {
        return 'Enter a valid amount(maximum is ${currencySymbol}50, 000)';
      }
    } catch (e) {
      print(e);
      return 'Enter a valid amount';
    }
    return null;
  }
}
