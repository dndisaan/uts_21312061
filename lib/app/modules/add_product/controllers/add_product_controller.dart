import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductController extends GetxController {

  late TextEditingController cNpm;
  late TextEditingController cNama;
  late TextEditingController cAlamat;
  late TextEditingController cProgramStudi;
  late TextEditingController cJenisKelamin;

  
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addProduct(String npm, String nama, String alamat, String programStudi, String jenisKelamin) async {
    CollectionReference mahasiswa = firestore.collection("mahasiswa");

    try {
      await mahasiswa.add({
        "NPM":npm,
        "nama": nama,
        "alamat":alamat,
        "program_studi":programStudi,
        "jk":jenisKelamin
      });
      Get.defaultDialog(
        title: "Berhasil",
        middleText: "Berhasil Menyimpan data produk",
        onConfirm: () {
          cNpm.clear();
          cNama.clear();
          cAlamat.clear();
          cProgramStudi.clear();
          cJenisKelamin.clear();
          Get.back();
          Get.back();
          textConfirm:
          "Ok";
        });
    } catch (e) {
      
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    cNpm = TextEditingController();
    cNama = TextEditingController();
    cAlamat = TextEditingController();
    cProgramStudi = TextEditingController();
    cJenisKelamin = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    cNpm.dispose();
    cNama.dispose();
    cAlamat.dispose();
    cProgramStudi.dispose();
    cJenisKelamin.dispose();
    super.onClose();
  }
}
