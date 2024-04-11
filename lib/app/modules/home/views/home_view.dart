import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:get/get.dart';
import 'package:ongkir_fast_track_beginner/app/constant/color.dart';
import 'package:ongkir_fast_track_beginner/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';
import '../../../data/models/province_model.dart';
import '../../../data/models/city_model.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ongkos Kirim'),
        centerTitle: true,
        actions: [
          ElevatedButton(
            onPressed: () => Get.toNamed(Routes.OTHER),
            child: const Icon(Icons.more_vert),
          ),
          ElevatedButton(
            onPressed: () {
              Get.changeTheme(Get.isDarkMode ? light : dark);
            },
            child: const Icon(Icons.dark_mode),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          DropdownSearch<Province>(
            popupProps: PopupProps.dialog(
              showSearchBox: true,
              itemBuilder: (context, item, isSelected) => ListTile(
                title: Text("${item.province}"),
              ),
            ),
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Provinsi Asal",
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            asyncItems: (String filter) async {
              var response = await Dio().get(
                "https://api.rajaongkir.com/starter/province",
                queryParameters: {
                  "key": dotenv.env['RAJAONGKIR_API_KEY'],
                },
              );
              return Province.fromJsonList(
                  response.data['rajaongkir']['results']);
            },
            onChanged: (value) =>
                controller.provAsalId.value = value?.provinceId ?? "0",
          ),
          const SizedBox(height: 20),
          DropdownSearch<City>(
            popupProps: PopupProps.dialog(
              showSearchBox: true,
              itemBuilder: (context, item, isSelected) => ListTile(
                title: Text("${item.type} ${item.cityName}"),
              ),
            ),
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Kota/Kabupaten Asal",
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            asyncItems: (String filter) async {
              var response = await Dio().get(
                "https://api.rajaongkir.com/starter/city?province=${controller.provAsalId}",
                queryParameters: {
                  "key": dotenv.env['RAJAONGKIR_API_KEY'],
                },
              );
              return City.fromJsonList(response.data['rajaongkir']['results']);
            },
            onChanged: (value) =>
                controller.cityAsalId.value = value?.cityId ?? "0",
          ),
          const SizedBox(height: 20),
          DropdownSearch<Province>(
            popupProps: PopupProps.dialog(
              showSearchBox: true,
              itemBuilder: (context, item, isSelected) => ListTile(
                title: Text("${item.province}"),
              ),
            ),
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Provinsi Tujuan",
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            asyncItems: (String filter) async {
              var response = await Dio().get(
                "https://api.rajaongkir.com/starter/province",
                queryParameters: {
                  "key": dotenv.env['RAJAONGKIR_API_KEY'],
                },
              );
              return Province.fromJsonList(
                  response.data['rajaongkir']['results']);
            },
            onChanged: (value) =>
                controller.provTujuanId.value = value?.provinceId ?? "0",
          ),
          const SizedBox(height: 20),
          DropdownSearch<City>(
            popupProps: PopupProps.dialog(
              showSearchBox: true,
              itemBuilder: (context, item, isSelected) => ListTile(
                title: Text("${item.type} ${item.cityName}"),
              ),
            ),
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Kota/Kabupaten Tujuan",
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            asyncItems: (String filter) async {
              var response = await Dio().get(
                "https://api.rajaongkir.com/starter/city?province=${controller.provTujuanId}",
                queryParameters: {
                  "key": dotenv.env['RAJAONGKIR_API_KEY'],
                },
              );
              return City.fromJsonList(response.data['rajaongkir']['results']);
            },
            onChanged: (value) =>
                controller.cityTujuanId.value = value?.cityId ?? "0",
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: controller.beratC,
            autocorrect: false,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Berat (gram)",
              contentPadding: EdgeInsets.symmetric(
                vertical: 25,
                horizontal: 15,
              ),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          DropdownSearch<Map<String, dynamic>>(
            items: const [
              {"code": "jne", "name": "JNE"},
              {"code": "pos", "name": "POS Indonesia"},
              {"code": "tiki", "name": "TIKI"},
            ],
            popupProps: PopupProps.dialog(
              showSearchBox: true,
              itemBuilder: (context, item, isSelected) => ListTile(
                title: Text("${item["name"]}"),
              ),
            ),
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Pilih Kurir",
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            dropdownBuilder: (context, selectedItem) =>
                Text("${selectedItem?["name"] ?? "Pilih Kurir"}"),
            onChanged: (value) =>
                controller.codeKurir.value = value?["code"] ?? "",
          ),
          const SizedBox(height: 30),
          Obx(
            () => ElevatedButton(
              onPressed: () {
                if (controller.isLoading.isFalse) {
                  controller.cekOngkir();
                }
              },
              child: Text(controller.isLoading.isFalse
                  ? "CEK ONGKOS KIRIM"
                  : "Loading..."),
            ),
          ),
          const Text("* Data yang ditampilkan bersifat realtime"),
        ],
      ),
    );
  }
}
