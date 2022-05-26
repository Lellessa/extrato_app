import 'package:banco_afro_project/models/transacao_model.dart';

class Cliente {
  final String nome, agencia, conta;
  double saldo = 0;
  List<Transacao> transacoes = [];

  Cliente(this.nome, this.agencia, this.conta);

  void depositar(double valor) {
    saldo += valor;
  }

  bool sacar(double valor) {
    if (saldo >= valor) {
      saldo -= valor;
      return true;
    } else {
      return false;
    }
  }

  void novaTransacao(Transacao transacao) {
    transacoes.add(transacao);
  }
  
}
