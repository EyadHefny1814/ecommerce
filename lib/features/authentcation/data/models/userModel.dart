import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    
    required super.id,
    required super.name ,
    required super.email,
    required super.token,
  });
}