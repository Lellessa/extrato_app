import 'cliente_model.dart';

class Transacao {
  final Cliente cliente;
  final double valor;
  final String opcao;
  final DateTime dataHora = DateTime.now();

  late bool sucessoTransacao;

  Transacao(this.cliente, this.valor, this.opcao) {
    switch (opcao) {
      case 'DEPOSITO':
        cliente.depositar(valor);
        sucessoTransacao = true;
        break;

      case 'SAQUE':
        sucessoTransacao = cliente.sacar(valor);
        break;

      default:
        sucessoTransacao = false;
        break;
    }

    if (sucessoTransacao) {
      cliente.novaTransacao(this);
    }
  }
}
