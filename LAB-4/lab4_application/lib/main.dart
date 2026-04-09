import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Общежития КубГАУ',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: const Color.fromARGB(255, 33, 94, 1)),
      ),
      home: const MyHomePage(title: 'Общежития КубГАУ'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _countOfLikes = 26;
  bool _isLovedByUser = false;

  int calculateCountOfLikes(bool isLovedByUser, int likesCount) {
    return isLovedByUser ? likesCount - 1 : likesCount + 1;
  }

  bool stateOfHeartChanger(bool isLovedByUser) {
    return !isLovedByUser;
  }

  void toggleLike() {
    final newCountOfLikes = calculateCountOfLikes(_isLovedByUser, _countOfLikes);
    final newStateOfHeartChanger = stateOfHeartChanger(_isLovedByUser);

    setState(() {
      _countOfLikes = newCountOfLikes;
      _isLovedByUser = newStateOfHeartChanger;
    });
  }

  Future<void> openContactOptions(BuildContext context) async {
    final choice = await showModalBottomSheet<String>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Позвонить'),
                onTap: () => Navigator.pop(context, 'phone'),
              ),
              ListTile(
                title: Text('Gmail'),
                onTap: () => Navigator.pop(context, 'gmail'),
              ),
              ListTile(
                title: Text('Сообщение'),
                onTap: () => Navigator.pop(context, 'sms'),
              ),
            ],
          ),
        );
      },
    );

    if (choice == null) return;

    Uri uri;

    switch (choice) {
      case 'phone':
        uri = Uri(scheme: 'tel', path: '+77777777777');
        await launchUrl(uri);
        break;

      case 'gmail':
        uri = Uri(
          scheme: 'mailto',
          path: 'example@gmail.com',
          query: Uri.encodeFull('subject=Hello&body=Hi there'),
        );
        await launchUrl(uri);
        break;

      case 'sms':
        uri = Uri(scheme: 'sms', path: '+77777777777');
        await launchUrl(uri);
        break;

      default:
        return;
    }

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Не удалось открыть $uri';
    }
  }

  Future<void> openMapsApp() async {
    final Uri mapUri = Uri.parse(
      'geo:0,0?q=45.0502933,38.9207626(Комплекс общежитий)',
    );

    await launchUrl(mapUri, mode: LaunchMode.externalApplication);
  }

  Future<void> openShareDialogWindow() async {
    SharePlus.instance.share(
      ShareParams(
        text: 'Комплекс общежитий КубГАУ\nАдрес: Краснодар, ул. Калинина, 13к',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/dormitories.webp'),
            Padding(
              padding: EdgeInsets.all(32),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Комплекс общежитий',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Краснодар, ул. Калинина 13к',
                          style: TextStyle(
                            color: Color.fromARGB(255, 116, 119, 115),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: toggleLike,
                    borderRadius: BorderRadius.circular(20),
                    child: Row(
                      children: [
                        Icon(
                          _isLovedByUser ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                          size: 28,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '$_countOfLikes',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(32),
              child: Column(
                children: [
                  SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          openContactOptions(context);
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Column(
                          children: [
                            Icon(Icons.phone, color: Colors.green, size: 32),
                            SizedBox(height: 4),
                            Text(
                              'Связаться',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          openMapsApp();
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Column(
                          children: [
                            Icon(Icons.near_me, color: Colors.green, size: 32),
                            SizedBox(height: 4),
                            Text(
                              'МАРШРУТ',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          openShareDialogWindow();
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Column(
                          children: [
                            Icon(Icons.share, color: Colors.green, size: 32),
                            SizedBox(height: 4),
                            Text(
                              'ПОДЕЛИТЬСЯ',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 28),
                  Text(
                    'Студенческий городок или так называемый кампус Кубанского ГАУ состоит '
                        'из двадцати общежитий, в которых проживает более 8000 студентов, что составляет '
                        '96% от всех нуждающихся. Студенты первого курса обеспечены местами в общежитии '
                        'полностью. В соответствии с Положением о студенческих общежитиях '
                        'университета, при поселении между администрацией и студентами заключается '
                        'договор найма жилого помещения. Воспитательная работа в общежитиях направлена '
                        'на улучшение быта, соблюдение правил внутреннего распорядка, отсутствия '
                        'асоциальных явлений в молодежной среде. Условия проживания в общежитиях '
                        'университетского кампуса полностью отвечают санитарным нормам и требованиям: '
                        'наличие оборудованных кухонь, душевых комнат, прачечных, читальных залов, '
                        'комнат самоподготовки, помещений для заседаний студенческих советов и '
                        'наглядной агитации. С целью улучшения условий быта студентов активно работает '
                        'система студенческого самоуправления - студенческие советы организуют всю работу '
                        'по самообслуживанию.',
                    style: TextStyle(fontSize: 16, height: 1.5),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
