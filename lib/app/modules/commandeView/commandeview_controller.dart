import 'package:get/get.dart';
import 'package:getx_skeleton/app/data/models/command_model.dart';
import 'package:getx_skeleton/app/data/remote/firestore_db.dart';
import 'package:getx_skeleton/utils/constants.dart';
import 'package:logger/logger.dart';

import '../../data/remote/api_call_status.dart';

class CommandeViewController extends GetxController {
  // hold data coming from api
  RxList commandesList = [].obs;
  FireStorDB fireStorDB = FireStorDB();
  // api call status
  ApiCallStatus apiCallStatus = ApiCallStatus.holding;

  // getting data from api
  getData() async {
    //todo Get Commandes From FireBase
    getCommandes();
  }

  Future addcommande(CommandModel commandModel) async {
    commandesList.add(commandModel);
    await fireStorDB.insertDocument(
        commandModel.toMap(), Constants.commandesCollection);
    update();
  }

  getCommandes() async {
    Logger().i("commandesList.length");
    try {
      var commandesData = await fireStorDB.getListDocuments(
          Constants.commandesCollection, true);
      for (var element in commandesData) {
        commandesList.add(CommandModel.fromMap(element));
      }
    } on Exception catch (e) {
      Logger().e(e);
    }

    Logger().i(commandesList.length);
    update();
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
