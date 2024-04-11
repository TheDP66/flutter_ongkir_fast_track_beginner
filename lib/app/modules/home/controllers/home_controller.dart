import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/models/ongkir_model.dart';

class HomeController extends GetxController {
  TextEditingController beratC = TextEditingController();

  List<Ongkir> ongkosKirim = [];

  RxString provAsalId = "0".obs;
  RxString cityAsalId = "0".obs;
  RxString provTujuanId = "0".obs;
  RxString cityTujuanId = "0".obs;

  RxString codeKurir = "".obs;

  RxBool isLoading = false.obs;

  void cekOngkir() async {
    if (provAsalId != "0" &&
        provTujuanId != "0" &&
        cityAsalId != "0" &&
        cityTujuanId != "0" &&
        codeKurir != "" &&
        beratC.text != "") {
      try {
        isLoading.value = true;

        var response = await http.post(
          Uri.parse("https://api.rajaongkir.com/starter/cost"),
          headers: {
            "key": dotenv.env['RAJAONGKIR_API_KEY']!,
            'content-type': 'application/x-www-form-urlencoded'
          },
          body: {
            "origin": cityAsalId.value,
            "destination": cityTujuanId.value,
            "weight": beratC.text,
            "courier": codeKurir.value,
          },
        );

        var ongkir = json.decode(response.body)['rajaongkir']['results'][0]
            ['costs'] as List;
        ongkosKirim = Ongkir.fromJsonList(ongkir);

        isLoading.value = false;

        Get.defaultDialog(
          title: "ONGKOS KIRIM",
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: ongkosKirim
                .map(
                  (e) => ListTile(
                    title: Text(e.service!.toUpperCase()),
                    subtitle: Text("Rp ${e.cost![0].value}"),
                  ),
                )
                .toList(),
          ),
        );
      } catch (e) {
        Get.defaultDialog(
          title: "TERJADI KESALAHAN",
          middleText: "Tidak dapat memeriksa ongkos kirim",
        );
      }
    } else {
      Get.defaultDialog(
        title: "TERJADI KESALAHAN",
        middleText: "Data input belum lengkap",
      );
    }
  }
}
