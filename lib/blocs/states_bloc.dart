import 'dart:async';

import 'package:zxplore_app/blocs/provider.dart';
import 'package:zxplore_app/data/database.dart';
import 'package:zxplore_app/data/entities/state_entity.dart';
import 'package:zxplore_app/models/state_model.dart';

class StatesBloc extends BlocBase {

  final _statesController = StreamController<List<StateEntity>>.broadcast();

  StreamSink<List<StateEntity>> get _inStates =>
      _statesController.sink;

  Stream<List<StateEntity>> get states => _statesController.stream;


  final _addStateController = StreamController<List<Menu>?>.broadcast();
  StreamSink<List<Menu>?> get inAddStates => _addStateController.sink;


  StatesBloc() {
    getStates();

    _addStateController.stream.listen(_handleAddStates);
  }

  @override
  void dispose() {
    _statesController.close();
    _addStateController.close();

  }

  void getStates() async {
    // Retrieve all the notes from the database
    List<StateEntity> notes = await DBProvider.db.getStates();

    _inStates.add(notes);
  }


  void _handleAddStates(List<Menu>? values) async {
    DBProvider.db.insertStates(values!);

    getStates();
  }

}
