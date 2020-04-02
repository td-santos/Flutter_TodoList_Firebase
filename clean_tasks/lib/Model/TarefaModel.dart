
class TarefaModel{

  String tarefaConteudo;
  String data;
  bool concluido;

  TarefaModel(this.tarefaConteudo,this.data,this.concluido);

  Map<String,dynamic> toMap(){
    Map<String,dynamic> map={
      "tarefa": tarefaConteudo,
      "data": data,
      "concluido": concluido
    };
    return map;
  }

}