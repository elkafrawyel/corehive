class RegisterRequest {
  RegisterRequest({
    this.name,
    this.email,
    this.phone,
    this.password,
  });

  RegisterRequest.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
  }

  String? name;
  String? email;
  String? phone;
  String? password;

  RegisterRequest copyWith({
    String? name,
    String? email,
    String? phone,
    String? password,
  }) =>
      RegisterRequest(
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        password: password ?? this.password,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['password'] = password;

    return map;
  }
}
