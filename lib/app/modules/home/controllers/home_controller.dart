import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Object?>> GetData() async {
    CollectionReference mahasiswa = firestore.collection('mahasiswa');

    return mahasiswa.get();
  }

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference mahasiswa = firestore.collection('mahasiswa');
    return mahasiswa.snapshots();
  }

void deleteProduct(String id) async {
  DocumentReference docRef = firestore.collection("mahasiswa").doc(id);

  try {
    Get.defaultDialog(
      title: "Info",
      middleText: "Apakah anda yakin ingin menghapus data ini?",
      onConfirm: () {
        docRef.delete();
        Get.back();
      },
      textConfirm: "Hapus",
      textCancel: "Batal",
    );
  } catch (e) {
    print(e);
    Get.defaultDialog(
      title: "Terjadi Kesalahan",
      middleText: "Tidak Berhasil Menghapus data",
    );
  }
}


}