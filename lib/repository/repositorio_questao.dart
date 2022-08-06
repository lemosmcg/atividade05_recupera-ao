import 'package:atividade05_quiz/models/questao.dart';

List<Map> _conjuntoQuestoes = [
  {
    "enunciado": "Qual era o nome da filha de Dom Pedro II?",
    "respostaCorreta": "Isabel",
    "outrasOpcoes": ["Maria", "Mariana", "Antonieta"]
  },
  {
    "enunciado": "Qual a data da chegada da família real portuguesa ao Brasil?",
    "respostaCorreta": "22 de janeiro de 1808",
    "outrasOpcoes": [
      "22 de fevereiro de 1808",
      "15 de abril de 1809",
      "01 de janeiro de 1809"
    ]
  },
  {
    "enunciado": "É correto afirmar que Tiradentes foi:",
    "respostaCorreta": "Líder da Inconfidência Mineira",
    "outrasOpcoes": [
      "Líder da Guerra dos Emboabas",
      "Líder da Guerra dos Canudos",
      "Protestante"
    ]
  },
  {
    "enunciado": "Na mitologia grega, quem é considerado o Rei dos Deuses?",
    "respostaCorreta": "Zeus",
    "outrasOpcoes": ["Dionisio", "Ares", "Apolo"]
  },
  {
    "enunciado":
        "Qual é a forma de governo adotada no Brasil até os dias atuais?",
    "respostaCorreta": "República",
    "outrasOpcoes": ["Monarquia", "Parlamento", "Regime Militar"]
  },
  {
    "enunciado":
        "Antes de receber o nome de Brasil, nosso país teve quantos nomes?",
    "respostaCorreta": "8",
    "outrasOpcoes": ["3", "6", "5"]
  },
  {
    "enunciado": "O período mais extenso da Pré-História é:",
    "respostaCorreta": "Paleolítico",
    "outrasOpcoes": ["Neolítico", "Idade das Pedras", "Idade dos Metais"]
  },
  {
    "enunciado": "O período Neolítico também é chamado de:",
    "respostaCorreta": "Pedra Polida",
    "outrasOpcoes": ["Pedra Lascada", "Pedra Afiada", "Idade das Pedras"]
  },
  {
    "enunciado": "Uma das grandes descobertas do período Paleolítico foi:",
    "respostaCorreta": "Fogo",
    "outrasOpcoes": ["Sedentarismo", "A roda", "Utilidade para o metal"]
  },
  {
    "enunciado": "Com que idade Dom Pedro II tornou-se imperador do Brasil?",
    "respostaCorreta": "5 anos",
    "outrasOpcoes": ["8 anos", "10 anos", "11 anos"]
  },
];

class QuestaoRepositorio {
  List<Questao> geraQuestoes(int qtde) {
    List<Questao> questoes = [];

    _conjuntoQuestoes.shuffle();

    for (int i = 0; (i < qtde) && (i < _conjuntoQuestoes.length); i++) {
      var selecionada = _conjuntoQuestoes[i];

      var questao = Questao(
          enunciado: selecionada["enunciado"],
          respostaCorreta: selecionada["respostaCorreta"],
          opcoes: [
            ...selecionada["outrasOpcoes"],
            selecionada["respostaCorreta"]
          ]..shuffle());

      questoes.add(questao);
    }

    return questoes;
  }
}
