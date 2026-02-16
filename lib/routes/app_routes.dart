import 'package:go_router/go_router.dart';
import 'package:practica_obligatoria_tema5_fernanshop/models/tech_product_model.dart';
import 'package:practica_obligatoria_tema5_fernanshop/presentation/screens/home_screen.dart';
import 'package:practica_obligatoria_tema5_fernanshop/presentation/screens/product_detail.dart';

final appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(path: '/home',builder: (context,state) => HomeScreen()),
    GoRoute(path: '/detail',builder: (context, state){

      final producto = state.extra as TechProduct; 
    
    // 2. Se lo pasamos al constructor de la pantalla
    return ProductDetail(producto: producto);
    })
  ]
);