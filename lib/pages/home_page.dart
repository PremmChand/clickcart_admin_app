import 'package:clickcart/controller/home_controller.dart';
import 'package:clickcart/pages/add_product_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Footware Admin'),
          centerTitle: true,
          backgroundColor: Colors.indigoAccent,
          foregroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: ctrl.products.isEmpty
              ? const Center(child: Text('No products added yet'))
              : ListView.separated(
            itemCount: ctrl.products.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final p = ctrl.products[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                child: ListTile(
                  // constrain the leading to 56x56
                  leading: SizedBox(
                    width: 56,
                    height: 56,
                    child: p.image != null && p.image!.isNotEmpty
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        p.image!,
                        fit: BoxFit.cover,
                      ),
                    )
                        : Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.image_not_supported,
                        color: Colors.grey,
                      ),
                    ),
                  ),

                  // reduce left padding now that leading is fixed
                  minLeadingWidth: 56,
                  contentPadding: const EdgeInsets.all(12),

                  title: Text(
                    p.name ?? '-',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    '₹${(p.price ?? 0).toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      Get.defaultDialog(
                        title: 'Confirm Delete',
                        middleText:
                        'Are you sure you want to delete "${p.name}"?',
                        textCancel: 'No',
                        textConfirm: 'Yes',
                        confirmTextColor: Colors.white,
                        onConfirm: () {
                          ctrl.deleteProducts(p.id ?? '');
                          Get.back();
                        },
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.indigoAccent,
          onPressed: () => Get.to(() => const AddProductPage()),
          child: const Icon(Icons.add, size: 28),
        ),
      );
    });
  }
}





/*
import 'package:clickcart/controller/home_controller.dart';
import 'package:clickcart/pages/add_product_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return Scaffold(
        appBar: AppBar(title: Text('Footware Admin'),),
        body: ListView.builder(
            itemCount: ctrl.products.length,
            itemBuilder: (context, index) {
              return ListTile(title: Text(ctrl.products[index].name ?? ''),
                subtitle: Text((ctrl.products[index].price ?? 0).toString()),
                trailing: IconButton(icon: Icon(Icons.delete), onPressed: () {
                  ctrl.deleteProducts(ctrl.products[index].id ?? '');
                },),
              );
            }),
        floatingActionButton: FloatingActionButton(onPressed: () {
          Get.to(AddProductPage());
        }, child: Icon(Icons.add),),
      );
    });
  }
}


*/
