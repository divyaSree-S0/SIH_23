import 'package:objectbox/objectbox.dart';

@Entity()
class DamagedPulleys {
  @Id()
  int id = 0;
  @Index()
  String conveyorId;
  @Property(type: PropertyType.intVector)
  List<int> damagedPulleys;

  DamagedPulleys(this.conveyorId, this.damagedPulleys);
}
