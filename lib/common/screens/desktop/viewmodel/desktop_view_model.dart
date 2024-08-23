import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../teste_draggable.dart';
import '../../../domain/entities/weather_response_model.dart';
import '../../../utils/icons_app.dart';
import '../../calculadora/view/calculator.dart';
import '../../contacts/view/another_contact_page.dart';
import '../../data/repositories/weather_repository.dart';
import '../models/draggable_widget.dart';
import '../view/about_me_page.dart';

class DesktopViewModel extends ChangeNotifier {
  final WeatherRepositorySecond weatherRepository;

  DesktopViewModel({required this.weatherRepository}) {
    _initializeWidgets();
  }

  final ValueNotifier<String> appName = ValueNotifier<String>('');

  final Stream<DateTime> _timeStream = Stream<DateTime>.periodic(const Duration(seconds: 1), (_) => DateTime.now());

  Stream<DateTime> get timeStream => _timeStream;

  final DateTime _now = DateTime.now();

  WeatherResponseModel? weatherResponseModel;

  DateTime get now => _now;

  int get currentDayIndex => _now.weekday % 7;

  final List<String> daysOfWeek = ['D', 'S', 'T', 'Q', 'Q', 'S', 'S'];

  String formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  bool isAboutMePageVisible = false;
  bool assistiveTouchExpanded = true;

  Offset assistiveTouchPosition = const Offset(0, 0);

  double? latitude;
  double? longitude;

  void toggleAboutMePageVisibility() {
    isAboutMePageVisible = !isAboutMePageVisible;
    notifyListeners();
  }

  void assistiveTouchToggleExpanded() {
    assistiveTouchExpanded = !assistiveTouchExpanded;
    notifyListeners();
  }

  List<Widget> get aplicativosBottom => [
        AppWidget(
          name: "Contatos",
          assetName: IconsApp.contact,
          onPressed: () {
            toggleVisibility('Contatos');
            bringToFront('Contatos');
          }, // POSICAO 1
        ),
        AppWidget(
          name: "Calculadora",
          assetName: IconsApp.calculator,
          onPressed: () {
            toggleVisibility('Calculadora');
            bringToFront('Calculadora');
          }, // POSICAO 0
        ),
      ];

  late List<DraggableWidget> widgets;

  void _initializeWidgets() {
    widgets = [
      DraggableWidget(
        id: 'Contatos', // posicao 1
        widget: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: AnotherContactPage(
            onMinimize: () => toggleVisibility('Contatos'),
          ),
        ),
        position: const Offset(120, 120),
      ),
      DraggableWidget(
        id: 'Calculadora', // posicao 0
        widget: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Calculator(
            maximizado: ValueNotifier<bool>(false),
            onMinimize: () => toggleVisibility('Calculadora'),
            onClose: () => toggleVisibility('Calculadora'),
          ),
        ),
        position: const Offset(400, 80),
      ),
      DraggableWidget(
        id: '',
        widget: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: AboutMePage(
            // onTap: () {
            //   toggleVisibility('');
            // },
            onTap: () => toggleVisibility(''),
          ),
        ),
        position: const Offset(500, 100),
      ),
      // DraggableWidget(
      //   id: 'Games',
      //   widget: ClipRRect(
      //     borderRadius: BorderRadius.circular(8),
      //     child: const GamesPage(),
      //   ),
      //   position: const Offset(100, 100),
      // )
    ];
  }

  void bringToFront(String id) {
    final index = widgets.indexWhere((widget) => widget.id == id);
    if (index != -1) {
      final widget = widgets.removeAt(index);
      // widgets.insert(0, widget);
      widgets.add(widget);
      _updateAppName();
      notifyListeners();
    }
  }

  void toggleVisibility(String id) {
    final index = widgets.indexWhere((widget) => widget.id == id);
    if (index != -1) {
      final widget = widgets[index];
      widget.isVisible = !widget.isVisible;
      _updateAppName();
      notifyListeners();
    }
  }

  void _updateAppName() {
    if (widgets.any((widget) => widget.isVisible)) {
      appName.value = widgets.lastWhere((widget) => widget.isVisible).id;
    } else {
      appName.value = '';
    }
  }

  Future<void> getWeather() async {
    await getCurrentLocation();

    if (latitude == null || longitude == null) {
      return Future.error('Não foi possível obter a localização.');
    }

    weatherResponseModel = await weatherRepository.execute(latitude, longitude);

    notifyListeners();
  }

  Future<void> getCurrentLocation() async {
    bool isServiceEnabled;
    LocationPermission permission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isServiceEnabled) {
      return Future.error('Serviço de localização desativado.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      return Future.error('Permissão de localização negada permanentemente.');
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Permissão de localização negada permanentemente.');
    }

    Position position = await Geolocator.getCurrentPosition();

    latitude = position.latitude;
    longitude = position.longitude;
  }
}
