import 'package:flutter/material.dart';
import 'menu_model.dart';

class MenuProvider with ChangeNotifier {
  final List<MenuModel> _menus = [
    MenuModel(
      id: "1",
      nama: "Cilok Kriwil",
      harga: "15k–20k",
      deskripsi: "Cilok kriwil lembut",
      gambar: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAaw4_B6Z5ITfMXpxd-Ru3391lJp2wL0b3Kw&s",
    ),
    MenuModel(
      id: "2",
      nama: "Cilok",
      harga: "15k–20k",
      deskripsi: "Cilok original",
      gambar: "https://pict.sindonews.net/dyn/850/pena/news/2021/01/17/185/303880/resep-cilok-ternyata-gampang-lho-yuk-coba-bikin-mwa.jpg",
    ),
    MenuModel(
      id: "3",
      nama: "Batagor",
      harga: "25k–30k",
      deskripsi: "Batagor saus kacang",
      gambar: "https://upload.wikimedia.org/wikipedia/commons/d/d4/Batagor.jpg",
    ),
    MenuModel(
      id: "4",
      nama: "Siomay",
      harga: "25k–30k",
      deskripsi: "Siomay saus kacang",
      gambar: "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e2/Siomay_Bandung.jpg/1280px-Siomay_Bandung.jpg",
    ),
    MenuModel(
      id: "5",
      nama: "Cireng Original",
      harga: "15k–20k",
      deskripsi: "Cireng gurih crispy",
      gambar: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRcg8Xv_nMtW5NZW094WiLBksqKiDD-EHXzBw&s",
    ),
    MenuModel(
      id: "6",
      nama: "Cireng Suir Pedas",
      harga: "20k",
      deskripsi: "Cireng isi ayam suir pedas",
      gambar: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSVKCaVge_rR5MuM1JJuJ48iVYa5gVA32qKJw&s",
    ),
    MenuModel(
      id: "7",
      nama: "Cireng Lada Hitam",
      harga: "20k",
      deskripsi: "Cireng isi ayam lada hitam",
      gambar: "https://assets.pikiran-rakyat.com/crop/0x194:1066x1006/720x0/webp/photo/2022/11/05/2987617237.jpg",
    ),
    MenuModel(
      id: "8",
      nama: "Cireng Sosis Pedas",
      harga: "20k",
      deskripsi: "Cireng isi sosis pedas",
      gambar: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmRsRWGo5n4VLyblWhUYkuxm79tkEklUueAg&s",
    ),
    MenuModel(
      id: "9",
      nama: "Cireng Mozzarella",
      harga: "25k",
      deskripsi: "Cireng isi mozzarella lumer",
      gambar: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzOl2Q7MAeloHbwE3yYkkHcIVc2NZ562l-_Q&s",
    ),
  ];

  List<MenuModel> get menus => List.unmodifiable(_menus);

  // ✅ CREATE
  void tambahMenu(String nama, String harga, String deskripsi, String gambar) {
    final newMenu = MenuModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      nama: nama,
      harga: harga,
      deskripsi: deskripsi,
      gambar: gambar,
    );
    _menus.add(newMenu);
    notifyListeners();
  }

  // ✅ UPDATE
  void editMenu(String id, String nama, String harga, String deskripsi, String gambar) {
    final index = _menus.indexWhere((m) => m.id == id);
    if (index == -1) return;

    _menus[index] = MenuModel(
      id: id,
      nama: nama,
      harga: harga,
      deskripsi: deskripsi,
      gambar: gambar,
    );
    notifyListeners();
  }

  // ✅ DELETE
  void hapusMenu(String id) {
    _menus.removeWhere((m) => m.id == id);
    notifyListeners();
  }
}