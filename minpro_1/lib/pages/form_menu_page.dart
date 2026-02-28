import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/menu_provider.dart';
import '../models/menu_model.dart';

class FormMenuPage extends StatefulWidget {
  final MenuModel? menu;
  const FormMenuPage({super.key, this.menu});

  @override
  State<FormMenuPage> createState() => _FormMenuPageState();
}

class _FormMenuPageState extends State<FormMenuPage> {
  final namaController = TextEditingController();
  final hargaController = TextEditingController();
  final deskripsiController = TextEditingController();
  final gambarController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.menu != null) {
      namaController.text = widget.menu!.nama;
      hargaController.text = widget.menu!.harga;
      deskripsiController.text = widget.menu!.deskripsi;
      gambarController.text = widget.menu!.gambar;
    }
  }

  @override
  void dispose() {
    namaController.dispose();
    hargaController.dispose();
    deskripsiController.dispose();
    gambarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.menu == null ? "Tambah Menu" : "Edit Menu"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ✅ MINIMAL 3 TEXTFIELD (di sini ada 4)
            TextField(
              controller: namaController,
              decoration: const InputDecoration(labelText: "Nama Menu"),
            ),
            TextField(
              controller: hargaController,
              decoration: const InputDecoration(labelText: "Harga (misal: 20k / 15k–20k)"),
              keyboardType: TextInputType.text,
            ),
            TextField(
              controller: deskripsiController,
              decoration: const InputDecoration(labelText: "Deskripsi"),
            ),
            TextField(
              controller: gambarController,
              decoration: const InputDecoration(labelText: "Link Gambar"),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final nama = namaController.text.trim();
                  final harga = hargaController.text.trim();
                  final deskripsi = deskripsiController.text.trim();
                  final gambar = gambarController.text.trim();

                  if (nama.isEmpty || harga.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Nama & harga wajib diisi")),
                    );
                    return;
                  }

                  if (widget.menu == null) {
                    menuProvider.tambahMenu(nama, harga, deskripsi, gambar);
                  } else {
                    menuProvider.editMenu(widget.menu!.id, nama, harga, deskripsi, gambar);
                  }

                  Navigator.pop(context);
                },
                child: Text(widget.menu == null ? "Tambah" : "Update"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}