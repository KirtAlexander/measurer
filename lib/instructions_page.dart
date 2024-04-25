import 'package:flutter/material.dart';
import 'package:measurer/footer.dart';
import 'package:measurer/home.page.dart';

class InstructionsPage extends StatefulWidget {
  @override
  _InstructionsPageState createState() => _InstructionsPageState();
}

class _InstructionsPageState extends State<InstructionsPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instrucciones de Uso'),
        backgroundColor: Colors.blue, // Cambia el color de fondo del appbar
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        children: [
          Page1(pageController: _pageController),
          Page2(pageController: _pageController),
          Page3(pageController: _pageController),
          Page4(pageController: _pageController),
        ],
      ),
      bottomNavigationBar: MyFooter(),
    );
  }
}

class Page1 extends StatelessWidget {
  final PageController pageController;

  Page1({required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue.shade200, Colors.white], // Fondo degradado
        ),
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                '¡Bienvenido a la aplicación para riesgo de desnutrición de Innahealt!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900, // Color del texto
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Esta aplicación te permite registrar la información de los niños y realizar un seguimiento del riesgo de desnutrición utilizando el perímetro braquial y la edad del niño en meses.',
                style: TextStyle(fontSize: 20, color: Colors.black87),
              ),
              const SizedBox(height: 20),
              const Text(
                'La aplicación trabajará de la mano con uno de nuestros dispositivos los cuales se encargan de tomar el perimetro braquial y enviar las medidas a la aplicación para hacer los calculos respectivos y dar un reporte sobre el estado del niño',
                style: TextStyle(fontSize: 20, color: Colors.black87),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                },
                child: const Text('Siguiente'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  final PageController pageController;

  Page2({required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue.shade200, Colors.white], // Fondo degradado
        ),
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                '¿Cómo usamos este dispositivo?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'El dispositivo se conectara por bluetooth al celular para asi dar ordenes desde el celular al dispositivo.',
                style: TextStyle(fontSize: 21, color: Colors.black87),
              ),
              const SizedBox(height: 20),
              const Text(
                'Luego de tomar las medidas se harán los calculos para clasificar los niños según su riesgo de desnutrición',
                style: TextStyle(fontSize: 21, color: Colors.black87),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    pageController.previousPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: const Text('Anterior'),
                ),
                ElevatedButton(
                  onPressed: () {
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: const Text('Siguiente'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  final PageController pageController;

  Page3({required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue.shade200, Colors.white], // Fondo degradado
        ),
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                'Uso de la aplicación',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900, // Color del texto
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Al iniciar la aplicación podremos ver dos botones los cuales serán: ',
                style: TextStyle(fontSize: 21, color: Colors.black87),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Center(
                  child: Container(
                    color: Color.fromARGB(255, 229, 234, 255),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            "Listado de niños",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.view_list),
                            iconSize: 64.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                  style: TextStyle(fontSize: 18),
                  "Este boton se encarga de enviarnos a la lista donde veremos todos los niños que hemos registrado con toda su información detallada y su riesgo de desnutrición. "),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Center(
                  child: Container(
                    color: Color.fromARGB(255, 229, 234, 255),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            "Agregar niño",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.add),
                            iconSize: 64.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                  style: TextStyle(fontSize: 18),
                  "Este boton se encarga de enviarnos a la vista donde recolectaremos toda la información necesaria del niño para hacer el proceso y descubrir cual es su riesgo de desnutrición"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  pageController.previousPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                },
                child: const Text('Anterior'),
              ),
              ElevatedButton(
                onPressed: () {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                },
                child: const Text('Siguiente'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Page4 extends StatelessWidget {
  final PageController pageController;

  Page4({required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue.shade200, Colors.white], // Fondo degradado
        ),
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                'Información sobre registros: ',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900, // Color del texto
                ),
              ),
              const SizedBox(height: 20),
              Text(
                  style: TextStyle(fontSize: 18),
                  "Mas abajo de los botones podremos ver algunos graficos que son los registros que se llevan hasta la fecha de los niños que ya han sido evaluados para el riesgo de desnutrición"),
              const SizedBox(height: 20),
              Text(
                  style: TextStyle(fontSize: 18),
                  "El primer grafico mostrará cuantos niños han sido encontrados con riesgo de desnutricion alto, moderado o bajo, lo dividirá por colores y se actualizará al registrar otro niño"),
              const SizedBox(height: 20),
              Text(
                  style: TextStyle(fontSize: 18),
                  "El segundo grafico mostrará los registros de los niños con riesgo de desnutrición segun su edad"),
            ],
          ),
          Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  pageController.previousPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                },
                child: const Text('Anterior'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
                child: const Text('Entendido!'),
              ),
            ],
          )),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: InstructionsPage(),
  ));
}
