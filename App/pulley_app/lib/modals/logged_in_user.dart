import 'package:objectbox/objectbox.dart';

@Entity()
class Users{
  Users(this.userId, this.username,this.password);

  @Id()
  int id=0;
  int userId;
  String username;
  String password;


}