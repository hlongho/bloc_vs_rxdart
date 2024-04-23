import 'package:rxdart/rxdart.dart';

class CounterBloc {
  int _initialCount = 0;
  TestModel _testModel = TestModel();
  late BehaviorSubject<int> _subjectCounter;
  late BehaviorSubject<TestModel> _subjectTestModel;

  CounterBloc({required int initialCount, required TestModel testModel}) : _testModel = testModel, _initialCount = initialCount {
    _subjectCounter = BehaviorSubject<int>.seeded(_initialCount);
    _subjectTestModel = BehaviorSubject<TestModel>.seeded(_testModel);
  }

  Stream<int> get counterObservable => _subjectCounter.stream;
  Stream<TestModel> get testModelObservable => _subjectTestModel.stream;

  void increment() {
    _initialCount++;
    _subjectCounter.sink.add(_initialCount);
  }

  void decrement() {
    _initialCount--;
    _subjectCounter.sink.add(_initialCount);
  }

  void incrementModel() {
    _testModel.count =
        _testModel.count != null ? _testModel.count! + 1 : _testModel.count = 1;
    _subjectTestModel.sink.add(_testModel);
  }

  void dispose() {
    _subjectCounter.close();
    _subjectTestModel.close();
  }
}

class TestModel {
  int? count;
}
