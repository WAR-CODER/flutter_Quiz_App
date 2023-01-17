import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vuyani Quiz game app',
      theme: ThemeData(
        primaryColor: Colors.grey,
      ),
      home: HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController controller = PageController(initialPage: 0);
  int currentQuestion =0;
  int score = 0;
  List questions = [
    {
      "question" : "What is capital of France ",
      "answer " : "paris",
      "options" : ["paris", "london", "roma", "madrid"]

    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Quiz Question: $currentQuestion"),
        actions: [
          Padding(padding: EdgeInsets.all(8),
          child: Text(
            "$score",
          ),)
        ],
      ),
      body: PageView.builder(
        itemCount: questions.length,
          physics: NeverScrollableScrollPhysics(),
          controller: controller,

          itemBuilder: (context, index){
          List options =questions[index]['options'];
          options.shuffle();
        return Column(
          children: [
          Card(
            margin: EdgeInsets.all(16),
            child: Container(
              padding: EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height * 0.4,
              child: Center(
                child: Text(),
              ),
            ),
          )
          ],
        );
      }),
    );
  }
}





