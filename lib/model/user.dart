class User {
  const User({
    this.name,
    this.token,
    this.tokenUpdateTime,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String?,
      token: json['token'] as String?,
      tokenUpdateTime: json['token_update_time'] == null
          ? null
          : DateTime.parse(json['token_update_time'] as String),
    );
  }

  final String? name;
  final String? token;
  final DateTime? tokenUpdateTime;

  User copyWith({
    String? name,
    String? token,
    DateTime? tokenUpdateTime,
  }) {
    return User(
      name: name ?? this.name,
      token: token ?? this.token,
      tokenUpdateTime: tokenUpdateTime ?? this.tokenUpdateTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'token': token,
      'token_update_time': tokenUpdateTime?.toIso8601String(),
    };
  }
}
