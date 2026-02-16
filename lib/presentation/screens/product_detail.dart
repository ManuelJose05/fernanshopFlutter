import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practica_obligatoria_tema5_fernanshop/models/tech_product_model.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key, required this.producto});

  final TechProduct producto;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  body: SafeArea(
    child: Column(
      children: [
        // 1. Botón de volver (Esto se queda igual)
        Row(
          children: [
            IconButton(
              onPressed: () => context.pop(),
              icon: Icon(Icons.arrow_back),
            ),
          ],
        ),
        SizedBox(height: 10),

        // 2. Área de contenido con scroll
        Expanded( 
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      producto.imageUrl,
                      width: 200,
                      height: 200, 
                      fit: BoxFit.cover,
                    ),
                  ),

                  SizedBox(width: 20),

            
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, 
                      children: [
                        Text(
                          '${producto.business} ${producto.name}',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                         '${producto.price.toString()}€',
                          style: TextStyle(color: Colors.grey, fontSize: 35),
                        ),
                        // Puedes añadir más cosas aquí...
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  ),
);
  }
}
