class LoginData {
  LoginData(this._username, this._password);

  String _username;
  String _password;

  String getUsername() => _username;

  String getPassword() => _password;

  static Object getObject(LoginData data) {
    return {"account": data.getUsername(), "password": data.getPassword()};
  }

  static String getStringObject(LoginData data) => getObject(data).toString();
}

class RegisterData {
  RegisterData(
      this._name, this._username, this._password, this._confirmPassword);

  String _name;
  String _username;
  String _password;
  String _confirmPassword;

  String getName() => _name;

  String getUsername() => _username;

  String getPassword() => _password;

  String confirmPassword() => _confirmPassword;

  static Object getObject(RegisterData data) {
    return {
      "name": data.getName(),
      "account": data.getUsername(),
      "password": data.getPassword()
    };
  }

  static String getStringObject(RegisterData data) =>
      getObject(data).toString();
}
