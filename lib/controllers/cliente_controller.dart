import 'dart:math';

import 'package:banco_afro_project/helper.dart';
import 'package:banco_afro_project/models/cliente_model.dart';
import 'package:banco_afro_project/models/transacao_model.dart';

class ClienteController {

  List<Cliente> clientes = [];
  late Cliente clientePrincipal;

  Cliente mockarDados() {
    clientePrincipal = gerarCliente();

    int n = Random().nextInt(20);
    if (n < 5) {
      n += 5;
    }
    for (int i = 0; i < n; i++) {
      gerarTransacao(clientePrincipal);
    }

    return clientePrincipal;
  }

  Cliente gerarCliente() {
    int agencia = Random().nextInt(90000)+10000;
    int conta = Random().nextInt(900000)+100000;

    Cliente cliente = Cliente('Leonardo', agencia.toString(), conta.toString());
    clientes.add(cliente);

    return cliente;
  }

  void gerarTransacao(Cliente cliente) {
    List<String> opcoesTransacao =  Helper().opcoesTransacao;
    String opcao = opcoesTransacao[Random().nextInt(opcoesTransacao.length)];

    double valor = Random().nextDouble()*1000;
    
    Transacao transacao = Transacao(cliente, valor, opcao);
    if (!transacao.sucessoTransacao) {
      gerarTransacao(cliente);
    }
  }

}