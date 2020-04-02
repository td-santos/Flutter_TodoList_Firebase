

import 'package:clean_tasks/Model/TarefaModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseController{

  Firestore bd = Firestore.instance;
  

  FirebaseController();

  saveFirebase(TarefaModel tarefa, FirebaseUser fbUser, String data)async{

    await bd.collection("tarefa_bd")
            .document(fbUser.uid)
            .collection(data.replaceAll("/", "-"))
            .add(tarefa.toMap());
  }

  getTarefasFirebase(FirebaseUser fbUser,String data)async{
    bd.collection("tarefa_bd")
            .document(fbUser.uid)
            .collection(data.replaceAll("/", "-"))
            .snapshots()
            .listen((onData) {
              onData.documents.forEach((d) {
            print("FIREBASE:" + d.data.toString());
          });
    });
  }

}