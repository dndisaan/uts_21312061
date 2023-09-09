import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateProductController extends GetxController {
  late TextEditingController cNpm;
  late TextEditingController cNama;
  late TextEditingController cAlamat;
  late TextEditingController cProgramStudi;
  late TextEditingController cJenisKelamin;
  

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Object?>> getData(String id) async {
    DocumentReference docRef = firestore.collection("mahasiswa").doc(id);

    return docRef.get();
  }

  void updateProduct(String npm, String nama, String alamat, String programStudi, String jenisKelamin, String id) async {
    DocumentReference productById = firestore.collection("mahasiswa").doc(id);

    try {
      await productById.update({
        "NPM":npm,
        "nama": nama,
        "alamat":alamat,
        "program studi":programStudi,
        "jenis Kelamin":jenisKelamin

      });

      Get.defaultDialog(
        title: "Berhasil",
        middleText: "Berhasil mengubah data product. ",
        onConfirm: () {
          cNpm.clear();
          cNama.clear();
          cAlamat.clear();
          cProgramStudi.clear();
          cJenisKelamin.clear();
          Get.back();
          Get.back();
          
        },
        textConfirm: "OK",
      );
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Gagal Menambahkan product."
      );
    }
  }

  @override
  void onInit() {
    // TODO: implement initState
    cNpm = TextEditingController();
    cNama = TextEditingController();
    cAlamat = TextEditingController();
    cProgramStudi = TextEditingController();
    cJenisKelamin = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    //    print("onClose");
    cNpm.dispose();
    cNama.dispose();
    cAlamat.dispose();
    cProgramStudi.dispose();
    cJenisKelamin.dispose();
    super.onClose();
  }
}
