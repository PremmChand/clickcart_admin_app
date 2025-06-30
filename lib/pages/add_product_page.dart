import 'package:clickcart/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:clickcart/widgets/drop_down_btn.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GetBuilder<HomeController>(builder: (ctrl) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Add Product'),
          backgroundColor: Colors.indigoAccent,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 2,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Add New Product',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: Colors.indigoAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  _buildTextField('Product Name', 'Enter your product name',
                    controller:ctrl.productNameCtrl
                  ),
                  const SizedBox(height: 16),

                  _buildTextField(
                      'Product Description', 'Enter description',
                      controller: ctrl.productDescriptionCtrl,
                      maxLines: 4),
                  const SizedBox(height: 16),

                  _buildTextField('Image URL', 'Enter image URL',
                  controller: ctrl.productImgCtrl),
                  const SizedBox(height: 16),

                  _buildTextField('Price', 'Enter price',
                      keyboardType: TextInputType.number,
                  controller: ctrl.productPriceCtrl),
                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: DropdownBtn(
                          items: const ['Sneakers', 'Heels','Slippers','Crocs', 'Boots','Sandals','Loafers',],
                          selectedItemText: 'Category',
                          selectedValue: ctrl.category,
                          onSelected: (selectedValue) {
                            ctrl.category = selectedValue ?? 'general';
                            ctrl.update();
                           // print("Selected category: $selectedValue");
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DropdownBtn(
                          items: const ['Nike','Adidas','Fila', 'Crocs', 'Puma','Centrino','SPARX','Reebok','Bata','Bacca Bucci','DOCTOR','Woodland'],
                          selectedItemText: 'Brand',
                          selectedValue: ctrl.brand,
                          onSelected: (selectedValue) {
                            ctrl.brand = selectedValue ?? 'un branded';
                            ctrl.update();
                          //  print("Selected brand: $selectedValue");
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  Text(
                    'Is this an offer product?',
                    style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),

                  DropdownBtn(
                    items: const ['true', 'false'],
                    selectedItemText:  ctrl.offer.toString(),
                    selectedValue: ctrl.offer.toString(),
                    onSelected: (selectedValue) {
                      ctrl.offer = bool.tryParse(selectedValue ?? 'false') ?? false;
                      ctrl.update();
                     // print("Selected offer: $selectedValue");
                    },
                  ),

                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: Colors.indigoAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        ctrl.addProducts();
                      },
                      icon: const Icon(Icons.add),
                      label: const Text(
                        'Add Product',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildTextField(
      String label,
      String hint, {
        required TextEditingController controller,
        int maxLines = 1,
        TextInputType keyboardType = TextInputType.text,
      }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.indigoAccent),
        ),
      ),
    );
  }

}
