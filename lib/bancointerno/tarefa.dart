//tarefa.dart REPRESENTA O REGISTRO QUE SERÁ NO AREMAZENADO NA TABELA
class Tarefa {
  int? id;
  String descricao;
  String prioridade; 
  String status;

  Tarefa({

    this.id,
    required this.descricao,
    required this.prioridade,
    required this.status,
  });

  //converte o objeto Tarefa para um Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'descricao': descricao,
      'prioridade': prioridade,
      'status': status,
    };
  }

  //Converter um registro do SQLite 
  //Novamente para um objeto Tarefa.
  factory Tarefa.fromMap(Map<String, dynamic> map) {
    return Tarefa(
      id: map['id'],
      descricao: map['descricao'],
      prioridade: map['prioridade'],
      status: map['status'],
    );
  }
}