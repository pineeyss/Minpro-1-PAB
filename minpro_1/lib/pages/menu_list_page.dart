import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/menu_provider.dart';
import '../models/menu_model.dart';
import 'form_menu_page.dart';

class MenuListPage extends StatelessWidget {
  const MenuListPage({super.key});

  Future<void> _confirmDelete(BuildContext context, MenuModel menu) async {
    final menuProvider = Provider.of<MenuProvider>(context, listen: false);

    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Hapus Menu?"),
        content: Text("Yakin mau hapus '${menu.nama}'?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Hapus"),
          ),
        ],
      ),
    );

    if (ok == true) {
      menuProvider.hapusMenu(menu.id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Menu berhasil dihapus")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final menus = context.watch<MenuProvider>().menus;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FormMenuPage()),
          );
        },
        child: const Icon(Icons.add),
      ),

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180,
            collapsedHeight: 70,
            toolbarHeight: 70,
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            clipBehavior: Clip.hardEdge,
            flexibleSpace: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset("assets/images/bg.jpg", fit: BoxFit.cover),
                Container(color: Colors.black.withOpacity(0.10)),
              ],
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
              child: Text(
                "Daftar Menu Batagorku",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final menu = menus[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FormMenuPage(menu: menu),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ✅ gambar fixed height
                          Image.network(
                            menu.gambar,
                            height: 110,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 110,
                                width: double.infinity,
                                color: Colors.grey[200],
                                alignment: Alignment.center,
                                child: const Icon(Icons.image_not_supported),
                              );
                            },
                          ),

                          // ✅ bagian bawah dibuat "kunci tinggi" biar icon sejajar
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    menu.nama,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    menu.harga,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    menu.deskripsi,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey,
                                    ),
                                  ),

                                  const Spacer(), // 🔥 bikin area bawah selalu sama

                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(20),
                                      onTap: () => _confirmDelete(context, menu),
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.12),
                                              blurRadius: 4,
                                            ),
                                          ],
                                        ),
                                        child: const Icon(
                                          Icons.delete_outline,
                                          size: 16,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: menus.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.68,
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 90)),
        ],
      ),
    );
  }
}