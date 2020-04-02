import 'package:mobx/mobx.dart';
part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {

  
    
      
    
  

  @observable
  double alturaCalendar = 0;

  @observable
  bool visibleCalendar = false;

  @action
  void setAlturaCalendar(double value) => alturaCalendar = value;

  @action
  bool setVisibleCalendar()=> visibleCalendar = !visibleCalendar;

  @observable
  double alturaData = 15;

  @observable
  double alturaHOJE = 50;

  @observable
  String dataFormatada ="";

  @action
  void setAturaData(double valor) => alturaData = valor;

  @action
  void setAturaHOJE(double valor) => alturaHOJE = valor;

  @action
  void setDataFormatada(String valor) => dataFormatada = valor;

  @observable
  double alturaListView ;

  

  @action
  void resetAlturaListView(double valor) {
    
    alturaListView = valor;
    print("Valor : $valor");
    }

  @action
  Future<void> setAlturaListView(double valor)async{

    
    print("Valor : $valor");
    resetAlturaListView(0);    
    

    Future.delayed(Duration(milliseconds: 200),(){
      alturaListView = valor;
    });

    //alturaListView = valor;
    print("Valor : $valor");

  }
  
}

//flutter packages pub run build_runner watch