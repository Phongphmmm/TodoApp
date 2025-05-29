import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String email;
  final String token;

  const UserEntity({required this.email, required this.token});

  @override
  List<Object> get props => [email, token];
}
