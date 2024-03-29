class LoginData {
  LoginData(this.username, this.password);

  String username;
  String password;

  static Map<String, dynamic> getObject(LoginData data) {
    return {"account": data.username, "password": data.password};
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

  static Map<String, dynamic> getObject(RegisterData data) {
    return {
      "name": data.getName(),
      "account": data.getUsername(),
      "password": data.getPassword()
    };
  }
}
