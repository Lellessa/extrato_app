import 'package:banco_afro_project/controllers/cliente_controller.dart';
import 'package:banco_afro_project/helper.dart';
import 'package:banco_afro_project/models/cliente_model.dart';
import 'package:banco_afro_project/models/transacao_model.dart';
import 'package:flutter/material.dart';

class ExtratoPage extends StatelessWidget {
  
  const ExtratoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Cliente cliente = ClienteController().mockarDados();
    Color corPrincipal = Helper().corPrincipal;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Header
          Container(
            padding: EdgeInsets.fromLTRB(10, MediaQuery.of(context).viewPadding.top+15, 10, 15),
            decoration: BoxDecoration(
              color: corPrincipal,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: const Offset(3, 5), // changes position of shadow
                ),
              ]
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Olá, '+cliente.nome , style: const TextStyle(fontSize: 18, color: Colors.white)),
                    const Icon(Icons.menu, color: Colors.white, size: 30),
                  ],
                ),
                Row(
                  children: [
                    Text(Helper().formatarConta(cliente.conta) , style: const TextStyle(fontSize: 12, color: Colors.white)),
                    const SizedBox(width: 10),
                    Text(Helper().formatarAgencia(cliente.agencia) , style: const TextStyle(fontSize: 12, color: Colors.white)),
                  ],
                ),
                const SizedBox(height: 20),

                // Saldo Text
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                            text: 'R\$ ',
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(
                                  text: Helper().formatarDinheiro(cliente.saldo), style: const TextStyle(fontSize: 35)),
                            ]),
                      ),
                      const SizedBox(height: 10),
                      const Text('Saldo atual', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w100),),
                    ],
                  ),
                ),
                
              ],
            ),
          ),

          
          // Transacoes List
          Expanded(
            child: ListView.builder(
              itemCount: cliente.transacoes.length+1,
              itemBuilder: (BuildContext context, int index) {

                if (index == 0) {
                  // Extratos Title
                  return Container(
                    margin: const EdgeInsets.all(20),
                    child: Text('Extratos', style: TextStyle(fontSize: 23, color: corPrincipal, fontWeight: FontWeight.w500),),
                  );
                }

                Transacao tr = cliente.transacoes[index-1];
                return CardTransacao(tr);
              }
            )
          ),

        ],
      )
    );
  }
}

// Card Transacao
class CardTransacao extends StatelessWidget {
  final Transacao tr;
  const CardTransacao(this.tr, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double deviceWidth = MediaQuery.of(context).size.width;
    Color corPrincipal = Helper().corPrincipal;

    Color color = Helper().seDeposito(tr)?corPrincipal:Colors.red;
    String valor =  Helper().seDeposito(tr)?'':'- ';
    valor += Helper().formatarDinheiro(tr.valor);

    return Container(
      margin: EdgeInsets.fromLTRB(deviceWidth * 0.03, 0, deviceWidth * 0.03, 20),
      padding: const EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: corPrincipal.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(3, 3), // changes position of shadow
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
        ),
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(Helper().formatarOpcao(tr.opcao), style: const TextStyle(fontSize: 18),),
              Text(Helper().formatarDataHora(tr.dataHora)),
            ],
          ),
          subtitle: Container(
            margin: const EdgeInsets.only(left: 10, top: 10),
            child: Text(valor, style: TextStyle(fontSize: 18, color: color),),
          ),
        ),
      ),
    );
  }
}
