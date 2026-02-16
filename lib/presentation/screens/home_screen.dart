import 'package:flutter/material.dart';
import 'package:practica_obligatoria_tema5_fernanshop/models/tech_product_model.dart';
import 'package:practica_obligatoria_tema5_fernanshop/services/tech_product_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController controllerSearch = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
                Expanded(
                  child: TextField(
                    controller: controllerSearch,
                    style: TextStyle(color: Colors.grey[600]),
                    decoration: const InputDecoration(
                      hintText: 'Busque un producto...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  color: Colors.indigo,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'FERNANSHOP',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(height: 10),
            Divider(thickness: 2, color: Colors.grey[800]),
            FutureBuilder(
              future: TechProductService().getAllProducts(),
              builder:
                  (
                    BuildContext context,
                    AsyncSnapshot<List<TechProduct>> snapshot,
                  ) {
                    return snapshot.hasData
                        ? _mostrarProductos(productos: snapshot.data!)
                        : Center(child: CircularProgressIndicator());
                  },
            ),
          ],
        ),
      ),
    );
  }
}

class _mostrarProductos extends StatelessWidget {
  const _mostrarProductos({super.key, required this.productos});

  final List<TechProduct> productos;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.7,
        ),
        itemCount: productos.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadiusGeometry.circular(20)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(20),
                    child: Image(image: NetworkImage(productos[index].imageUrl)),
                  ),
                ),
                Text('${productos[index].business} ${productos[index].name}', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),textAlign: TextAlign.start,),
                Text('${productos[index].price.toString()}€',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),textAlign: TextAlign.end,)
              ],
            ),
          );
        },
      ),
    );
  }
}
