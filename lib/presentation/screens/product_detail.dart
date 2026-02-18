import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practica_obligatoria_tema5_fernanshop/models/tech_product_model.dart';
import 'package:practica_obligatoria_tema5_fernanshop/providers/config_provider.dart';
import 'package:practica_obligatoria_tema5_fernanshop/providers/products_provider.dart';
import 'package:practica_obligatoria_tema5_fernanshop/providers/users_provider.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key, required this.producto});

  final TechProduct producto;

  @override
  Widget build(BuildContext context) {
    final configProvider = Provider.of<ConfigProvider>(context);
    final productsProvider = Provider.of<ProductsProvider>(context);
    final usersProvider = Provider.of<UsersProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => context.pop(),
                  icon: Icon(Icons.arrow_back),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              producto.imageUrl,
                              width: 200,
                              height: 200,
                              fit: BoxFit.fill,
                            ),
                          ),

                          SizedBox(width: 20),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${producto.business} ${producto.name}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '${producto.price.toString()}€',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 35,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text('Tipo: ${producto.type}')
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      _botonAniadirCarrito(productsProvider: productsProvider, producto: producto),
                      SizedBox(
                        height: 10,
                      ),
                      if (usersProvider.userLogued!.administrator!)
                      _botonEditarProducto(productsProvider: productsProvider, producto: producto),
                      SizedBox(
                        height: 30,
                      ),
                      Text('Características', style: TextStyle(fontSize: 20),),
                      producto.characteristics != null ?
                      _mostrarCaracteristics(producto: producto) : Text('No disponibles')
                      
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

class _botonAniadirCarrito extends StatelessWidget {
  const _botonAniadirCarrito({
    super.key,
    required this.productsProvider,
    required this.producto,
  });

  final ProductsProvider productsProvider;
  final TechProduct producto;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        productsProvider.aniadirProductoCarro(producto);
        ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Se ha insertado el producto con éxito'),
              action: SnackBarAction(label: 'Ver en el carro', onPressed: () {context.push('/home',extra: 2);}),
              duration: const Duration(seconds: 2),),
              
            );
      },
    
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey[600]
            : Colors.indigo,
      ),
      child: Text(
        'Añadir al carrito🛒',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}

class _botonEditarProducto extends StatelessWidget {
  const _botonEditarProducto({
    super.key,
    required this.productsProvider,
    required this.producto,
  });

  final ProductsProvider productsProvider;
  final TechProduct producto;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: ()=> context.push('/editarProducto',extra: producto),
    
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey[600]
            : Colors.indigo,
      ),
      child: Text(
        'Editar producto',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}

class _mostrarCaracteristics extends StatelessWidget {
  const _mostrarCaracteristics({super.key, required this.producto});

  final TechProduct producto;

  @override
  Widget build(BuildContext context) {
    
    final c = producto.characteristics!;
    print(c.toJson().toString());

    return Column(
      children: [
        // Procesadores / RAM
        _buildRow('Velocidad', c.speed),
        _buildRow('Velocidad máx', c.maxSpeed),
        _buildRow('Voltaje', c.voltage),
        _buildRow('Memoria', c.memory),
        _buildRow('Frecuencia Boost', c.boostClock),
        _buildRow('TDP', c.tdp),
        
        // Placas Base
        _buildRow('Socket', c.socket),
        _buildRow('Chipset', c.chipset),
        _buildRow('Factor de forma', c.formFactor),
        
        // Almacenamiento
        _buildRow('Tipo', c.type),
        _buildRow('Interfaz', c.characteristicsInterface),
        _buildRow('Velocidad Lectura', c.speedRead),
        _buildRow('Velocidad Escritura', c.speedWrite),
        _buildRow('RPM', c.rpm),
        _buildRow('Caché', c.cache),
        
        // Torres / Refrigeración
        _buildRow('Ventiladores', c.fans),
        _buildRow('Ruido', c.noise),
        _buildRow('Altura', c.height),
        _buildRow('Ventilador', c.fan),
        
        // Fuentes de alimentación
        _buildRow('Potencia', c.wattage),
        _buildRow('Eficiencia', c.efficiency),
        _buildRow('Modular', c.modular),
      ],
    );
  }

  Widget _buildRow(String titulo, String? valor) {
    if (valor == null || valor.isEmpty) {
      return const SizedBox.shrink(); //No ocupa espacio si es nulo
    }

    return ListTile(
      title: Text(
        '$titulo: $valor',
        style: const TextStyle(fontSize: 15),
      ),
      leading: const Icon(Icons.info_outline, size: 20),
      visualDensity: VisualDensity.compact,
    );
  }
}
