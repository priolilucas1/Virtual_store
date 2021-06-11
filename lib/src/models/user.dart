class User {
  User(this.name, this.email, [this.password, this.confirmPassword]);

  String name;
  String email;
  String? password;
  String? confirmPassword;
}
