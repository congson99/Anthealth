class LoginData {
  LoginData(this._username, this._password);

  String _username;
  String _password;

  String getUsername() => _username;

  String getPassword() => _password;

  static Object getObject(LoginData data) {
    return {"account": data.getUsername(), "password": data.getPassword() };
  }

  static String getStringObject(LoginData data) => getObject(data).toString();
}
