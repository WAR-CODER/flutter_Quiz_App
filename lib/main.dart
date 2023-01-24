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
      debugShowCheckedModeBanner: false,
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
  int currentQuestion = 0;
  int score = 0;
  List questions = [

    {
      "question": "What is capital of France? ",
      "answer ": "paris",
      "options": ["paris", "london", "roma", "madrid"]
    },
    {
      "question": "Which country won the fifa world cup 2022? ",
      "answer ": "Argentina",
      "options": ["France", "South Africa", "Argentina", "Spain"]
    },
    {
      "question": "What is capital of UK? ",
      "answer ": "london",
      "options": ["paris", "london", "roma", "madrid"]
    },
    {
      "question": "Who is the president of South Africa? ",
      "answer ": "Cyril Ramamposa",
      "options": ["Jacob Zuma", "Thabo Mbeki", "Cyril Ramamposa", "Bheki Cele"]
    },



  ];
  @override
  void initState() {
    questions.shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Quiz Question: $currentQuestion"),
        actions: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Center(
              child: Text(
                "$score",
              ),
            ),
          )
        ],
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: Text("${currentQuestion + 1} / ${questions.length}")),
        ),
      ),
      body: PageView.builder(
          itemCount: questions.length,
          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
          itemBuilder: (context, index) {
            List options = questions[index]['options'];
            options.shuffle();
            return Column(
              children: [
                Card(
                  margin: EdgeInsets.all(16),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Center(
                      child: Text(
                        questions[index]['question'],
                        style: TextStyle(
                          fontSize: 40,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Center(
                  child: GridView.builder(
                      padding: EdgeInsets.all(16),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 1.7),
                      itemCount: options.length,
                      itemBuilder: (context, i) {
                        String option = options[i];
                        return InkWell(
                          onTap: () {
                            if (index + 1 == questions.length) {
                              if (option == questions[index]['answer']) {
                                score += 1;
                              }
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) {
                                    return WillPopScope(
                                      onWillPop: () async => false,
                                      child: AlertDialog(
                                        title: Text(
                                          "Total Score",
                                          textAlign: TextAlign.center,
                                        ),
                                        content: Text(
                                          "$score / ${questions.length} ",
                                          maxLines: score + 1,
                                          textAlign: TextAlign.center,
                                        ),
                                        actions: [
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                setState(() {
                                                  score = 0;
                                                  questions.shuffle();
                                                  currentQuestion = 0;
                                                  controller.jumpToPage(0);

                                                });
                                              },
                                              child: Text("Retry?"))
                                        ],
                                      ),
                                    );
                                  });
                            } else {
                              if (option == questions[index]["answer"]) {
                                score += 1;
                              }
                              setState(() {
                                currentQuestion += 1;
                              });
                              controller.jumpToPage(index + 1);
                            }
                          },
                          child: Center(
                            child: Text(option),
                          ),
                        );
                      }),
                )),
              ],
            );
          }),
    );
  }
}
