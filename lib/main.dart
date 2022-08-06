import 'package:flutter/material.dart';
import 'package:atividade05_quiz/models/questao.dart';
import 'package:atividade05_quiz/repository/repositorio_questao.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Quiz APP",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        primarySwatch: Colors.green,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

enum StatusPergunta { aguardando, respondida }

enum StatusQuiz { ocorrendo, completo, resultados }

class _HomeState extends State<Home> {
  List<Questao> perguntas = QuestaoRepositorio().geraQuestoes(5);
  int perguntaAtual = 0;
  StatusPergunta statusPergunta = StatusPergunta.aguardando;
  String opcaoSelecionada = "";
  StatusQuiz statusQuiz = StatusQuiz.ocorrendo;
  int acertos = 0;
  int erros = 0;

  void registraResposta(String opcao) {
    if (statusPergunta == StatusPergunta.aguardando) {
      setState(() {
        opcaoSelecionada = opcao;
        statusPergunta = StatusPergunta.respondida;
      });
    }
    if (opcao == perguntas[perguntaAtual].respostaCorreta) {
      acertos += 1;
    } else {
      erros += 1;
    }
  }

  void proximaAcao() {
    if (statusQuiz == StatusQuiz.completo) {
      setState(() {
        statusQuiz = StatusQuiz.resultados;
      });
    } else {
      setState(() {
        if (perguntaAtual < perguntas.length - 1) {
          perguntaAtual++;
        }
        if (perguntaAtual == perguntas.length - 1) {
          statusQuiz = StatusQuiz.completo;
        }
        statusPergunta = StatusPergunta.aguardando;
      });
    }
  }

  void novoQuiz() {
    setState(() {
      perguntas = QuestaoRepositorio().geraQuestoes(5);
      perguntaAtual = 0;
      statusPergunta = StatusPergunta.aguardando;
      opcaoSelecionada = "";
      statusQuiz = StatusQuiz.ocorrendo;
      acertos = 0;
      erros = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return statusQuiz == StatusQuiz.resultados
        ? Center(
            child: Column(
              children: [
                Text(
                  "Acertou: ${acertos}",
                  style: const TextStyle(fontSize: 22, color: Colors.black),
                ),
                Text(
                  "Erros: ${erros}",
                  style: const TextStyle(fontSize: 22, color: Colors.black),
                ),
                ElevatedButton(
                  onPressed: () {
                    novoQuiz();
                  },
                  child: Text("Novo Quiz"),
                ),
              ],
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text("Quiz APP"),
              backgroundColor: Colors.green,
            ),
            body: Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Pergunta ${perguntaAtual + 1}/${perguntas.length}",
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const Divider(
                      height: 10,
                      thickness: 2.0,
                      color: Colors.black,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Center(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  perguntas[perguntaAtual].enunciado,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0XFF00ff28)),
                                ),
                              ],
                            ),
                          ),
                        )),
                    const Divider(
                        height: 10, thickness: 2.0, color: Colors.black),
                    ...perguntas[perguntaAtual].opcoes.map(
                      (opcao) {
                        return GestureDetector(
                          onTap: () {
                            registraResposta(opcao);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 50,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0XFF212121),
                              border: Border.all(
                                color:
                                    statusPergunta == StatusPergunta.respondida
                                        ? opcao == opcaoSelecionada
                                            ? opcao ==
                                                    perguntas[perguntaAtual]
                                                        .respostaCorreta
                                                ? Colors.green
                                                : Colors.red
                                            : Colors.black38
                                        : Color(0XFF161616),
                                width: 3.0,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 2.0),
                                  blurRadius: 5,
                                )
                              ],
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              opcao,
                              style: TextStyle(
                                  fontSize: 20, color: Color(0XFFc2c2c2)),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 60),
                    statusPergunta == StatusPergunta.respondida
                        ? GestureDetector(
                            onTap: () {
                              //ir para a próxima pergunta
                              proximaAcao();
                              print("Clicou na próxima ${perguntaAtual}");
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 200,
                              height: 50,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0XFF00FF28),
                                border: Border.all(
                                  color: Color(0XFF00FF28),
                                  width: 3.0,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0, 2.0),
                                    blurRadius: 5,
                                  )
                                ],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Text(
                                statusQuiz == StatusQuiz.completo
                                    ? "Resultado"
                                    : "Proxima",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        : Container(
                            height: 60,
                            color: Colors.transparent,
                          ),
                  ],
                ),
              ),
            ),
          );
  }
}
