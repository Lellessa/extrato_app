import 'package:banco_afro_project/models/transacao_model.dart';
import 'package:flutter/material.dart';

class Helper {

  final List<String> opcoesTransacao = ['DEPOSITO', 'SAQUE'];
  Color corPrincipal = Colors.purple;

  String formatarDinheiro(double n, {bool possuiSimbolo = false}) {
    String result = '';

    result = n.toStringAsFixed(2).replaceFirst('.', ',');

    String sub = result.substring(0, result.length-3);
    String subCents = result.substring(result.length - 2, result.length);
    
    List<String> subs = [];
    
    int count = 0;
    for (int i = sub.length-1; i >= 0; i--) {
      if (count == 2) {
        subs.add(sub.substring(i, i+3));    
        count = 0;
      } else {
        count++;
      }
    }

    if (count > 0) {
      subs.add(sub.substring(0, count));
    }
    
    result = '';
    for (int i = subs.length-1; i >= 0; i--) {
      if (i>0) {
        result += subs[i]+'.'; 
      } else {
        result += subs[i];
      }
    }
    result += ',$subCents';

    if (possuiSimbolo) {
      result = 'R\$ $result';
    }

    return result;
  }

  String formatarDataHora(DateTime dt) {
    int dia = dt.day;
    int mes = dt.month;
    int hora = dt.hour;
    int min = dt.minute;

    String dataHora = dia.toString().padLeft(2, '0') +'/'+ mes.toString().padLeft(2, '0') +' '+hora.toString().padLeft(2, '0') + ':'+min.toString().padLeft(2, '0');
    return dataHora;
  }

  String formatarOpcao(String opcao) {
    switch (opcao) {
      case 'DEPOSITO':
        return 'Depósito';
      case 'SAQUE':
        return 'Saque';
      default:
        return 'Opção Desconhecida';
    }
  }

  String formatarAgencia(String agencia) {
    String sub = agencia.substring(0, 4);
    String sub2 = agencia.substring(4,5);
    
    String result = sub+'-'+sub2;
    return result;
  }

  String formatarConta(String conta) {
    String sub = conta.substring(0, 2);
    String sub2 = conta.substring(2, 5);
    String sub3 = conta.substring(5, 6);
    
    String result = sub+'.'+sub2+'-'+sub3;
    return result;
  }

  bool seDeposito(Transacao tr) {
    return (tr.opcao == 'DEPOSITO');
  }

}