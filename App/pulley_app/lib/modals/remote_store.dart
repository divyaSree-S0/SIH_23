import 'package:mongo_dart/mongo_dart.dart';
import 'package:pulley_app/modals/constant.dart';
import 'package:pulley_app/modals/detected_pulleys.dart';
import 'package:pulley_app/modals/local_store.dart';
import 'package:pulley_app/objectbox.g.dart';

class RemoteStore {
  final Db _db = Db('//Mongo Url');
  late DbCollection _usersColl;
  late DbCollection _userColl;
  late DbCollection _conveyorColl;
  late List<(String, Object)> _conveyors;
  late List<Map<String, Object>> _pulleysStatus;
  late List<Map<String, Object>> _damagedPulleys;
  late List<Map<String, Object>> _pulleysToBeDamaged;
  late List<Map<String, Object>> _pulleysWorkingFine;
  late Map<String, dynamic>? _userdetail;
  late int _pulleysToBeInStock;
  late String _conveyorName;

  ///to create object of Remote Store
  RemoteStore.create() {
    _create();
  }

  Future<void> _create() async {
    await _db.open();
    // ignore: await_only_futures
    _usersColl = await _db.collection('Users');
    // ignore: await_only_futures
    _conveyorColl = await _db.collection('Conveyors');
  }

  Future<int> isValidUser(String user, String password) async {
    final users =
        await _usersColl.find(where.eq('username', user.trim())).toList();
    if (users.isEmpty) {
      return -1;
    }
    return users[0]['password'] == password ? 1 : users[0]['_id'];
  }

  void setUsersCollection(String collection) {
    _userColl = _db.collection(collection);
    print(_userColl.collectionName);
  }

  Future<void> createConveyor({
    required String name,
    required int totalPulleys,
    required int pulleysInShoe,
    required double beltThickness,
    required double beltLength,
    required double beltWidth,
    required String mine,
    required String industry,
  }) async {
    final Map<String, Object> newConveyor = {
      "userId": last_user!.userId,
      "name": name,
      "totalPulleys": totalPulleys,
      "pulleysInShoe": pulleysInShoe,
      "beltThickness": beltThickness,
      "beltLength": beltLength,
      "beltWidth": beltWidth,
      "mine": mine,
      "industry": industry,
    };
    var index = await _conveyorColl.insertOne(newConveyor);
    print(_usersColl.findOne());
    print(last_user!.userId);
    await _usersColl.update(
        where.eq('_id', last_user!.userId), modify.inc("noConveyorSystem", 1));
    await _usersColl.update(where.eq('_id', last_user!.userId),
        modify.addToSet('conveyors', index.id));
    print('update hua shayad');
    final List<Map<String, Object>> pulleys = [];
    for (int i = 1; i <= totalPulleys; i++) {
      final Map<String, Object> pulley = {
        "pulleyId": i,
        "status": [100],
        "image": [
          'https://th.bing.com/th/id/R.7b81022e20ae02e32d3dc2ecbd5e1aa5?rik=kZVSr7N3PylPlw&riu=http%3a%2f%2fwww.fehr.com%2fimg%2fproduct%2fSHV3HD_1-Z.jpg&ehk=n173gTjEoB0pAks5xcaqn3UtcCOaUtq9lyFMrP3Omjw%3d&risl=&pid=ImgRaw&r=0'
        ],
        "conveyorId": index.id,
      };
      pulleys.add(pulley);
    }
    await _userColl.insertAll(pulleys);
  }

  List<(String, Object)> get conveyors {
    return _conveyors;
  }

  void setConveyors() {
    List<(String, Object)> items = [];
    _conveyorColl
        .find(where.eq("userId", last_user!.userId))
        .forEach((document) {
      items.add((document['name'], document['_id']));
    });
    _conveyors = items;
  }

  List<Map<String, Object>> get pulleysStatus {
    return _pulleysStatus;
  }

  Future<void> setPulleyStatus(Object conveyorId) async {
    List<Map<String, Object>> pulleys = [];

    final pipeline = AggregationPipelineBuilder()
        .addStage(Match(where.eq("conveyorId", conveyorId).map['\$query']))
        .addStage(Project({"_id": 0, "conveyorId": 0}))
        .build();
    await _userColl.aggregateToStream(pipeline).forEach((pulleyDocument) {
      print(pulleyDocument);
      pulleys.add({
        "conveyorId": conveyorId,
        "pulleyLocation": pulleyDocument["pulleyId"],
        "status": pulleyDocument["status"][0],
        "image": pulleyDocument["image"][0]
      });
    });
    _pulleysStatus = pulleys;
  }

  List<Map<String, Object>> get damagedPulleys {
    return _damagedPulleys;
  }

  List<Map<String, Object>> get pulleysToBeDamaged {
    return _pulleysToBeDamaged;
  }

  List<Map<String, Object>> get pulleysWorkingFine {
    return _pulleysWorkingFine;
  }

  int get pulleysToBeInStock {
    return _pulleysToBeInStock;
  }

  void setPulleysCondition() {
    _pulleysToBeDamaged = [];
    _damagedPulleys = [];
    _pulleysWorkingFine = [];
    _pulleysToBeInStock = 0;
    _pulleysStatus.map((pulley) {
      print(pulley);
      String status = pulley["status"] as String;
      switch (status) {
        case "bad": //case _ when status >= 0 && status <= 20:
          _damagedPulleys.add(pulley);
          _pulleysToBeInStock++;
        case "good": //case _ when status <= 60:
          _pulleysWorkingFine.add(pulley); //_pulleysToBeDamaged.add(pulley);
        //_pulleysToBeInStock++;
        //case _ when status <= 80:
        //  _pulleysToBeDamaged.add(pulley);
        case _:
          _pulleysWorkingFine.add(pulley);
      }
    }).toList();
    _pulleysToBeInStock += 5;

    final DamagedPulleys storeDamagedPulleys = DamagedPulleys(
        _damagedPulleys[0]["conveyorId"].toString(),
        _damagedPulleys
            .map((pulley) => pulley["pulleyLocation"] as int)
            .toList());

    if (damagedPulleysBox.getAll().isEmpty) {
      damagedPulleysBox.put(storeDamagedPulleys);
    } else {
      query = damagedPulleysBox
          .query(DamagedPulleys_.conveyorId.equals(""))
          .build();
      query.param(DamagedPulleys_.conveyorId).value =
          storeDamagedPulleys.conveyorId;
      final result = query.find();
      if (result.isEmpty) {
        damagedPulleysBox.put(storeDamagedPulleys);
      } else {
        damagedPulleysBox.remove(result[0].id);
        damagedPulleysBox.put(storeDamagedPulleys);
      }
    }
  }

  Future<void> removeConveyor(Object conveyorId) async {
    await _conveyorColl.deleteOne(where.eq("_id", conveyorId));
    print(last_user!.userId);
    final result = await _usersColl.updateOne(
        where.eq("_id", last_user!.userId), modify.inc("noConveyorSystem", -1));
    print(result.document);
    final res = await _usersColl.updateOne(where.eq("_id", last_user!.userId),
        modify.pull("conveyors", conveyorId));
    print(res.document);
    final data = await _userColl.remove(where.eq("conveyorId", conveyorId));
    print(data);
    _conveyors.removeWhere((conveyor) => conveyor.$2 == conveyorId);
    print(_conveyors);
  }

  String get conveyorName {
    return _conveyorName;
  }

  Future<void> setConveyorName(Object conveyorId) async {
    await _conveyorColl
        .findOne(where.eq("_id", conveyorId))
        .then((document) => _conveyorName = document!["name"]);
  }

  bool isNotified() {
    final storedData = damagedPulleysBox.getAll();
    final remoteData = _userColl.find();
    var notify = false;

    for (int i = 0; i < storedData.length; i++) {
      final result = remoteData.map((pulley) =>
          pulley["conveyorId"] == storedData[i].conveyorId &&
          pulley["status"][0] == "bad" &&
          storedData[i]
              .damagedPulleys
              .where((pulleyId) => pulleyId == pulley["pulleyId"])
              .isEmpty);
      result.any((element) => element == true).then((value) {
        notify = value;
      });
      if (notify) {
        return notify;
      }
    }
    return false;
  }

  Future<void> userdetail() async {
    _userdetail = await _usersColl.findOne(where.eq('_id', last_user!.userId));
  }

  get industryName {
    return _userdetail!["industryName"];
  }

  get industryLocation {
    return _userdetail!["industryLocation"];
  }

  get email {
    return _userdetail!["email"];
  }
}
