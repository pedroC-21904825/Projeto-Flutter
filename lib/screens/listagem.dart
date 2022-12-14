import 'package:flutter/material.dart';
import 'package:mini_projeto/screens/visualizar.dart';
import '../Format/date_formatter.dart';
import '../alerts/pop_up_fail_delete_or_edit.dart';
import '../alerts/pop_up_success_delete_or_edit.dart';
import '../data/datasource.dart';

class ListagemScreen extends StatefulWidget {
  const ListagemScreen({Key? key}) : super(key: key);

  final String title = "Listar Registos";

  @override
  State<ListagemScreen> createState() => _ListagemScreenState();
}

class _ListagemScreenState extends State<ListagemScreen> {
  DataSource _dataSource = DataSource.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: _dataSource.getAll().length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(UniqueKey().toString()),
            child: Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text("Peso: " + _dataSource.getAll()[index].peso.toString() + " Kg"),
                      subtitle: Text("Bem-estar: " + _dataSource.getAll()[index].nota.toString()
                          + "\n" +
                          "Data: " + formatter9000(_dataSource.getAll()[index].data)),
                      isThreeLine: true,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => VisualizarScreen(index)),
                        );
                      },
                    ),
                  ],
                )
            ),
            background: Container(
              color: Colors.red,
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
              alignment: Alignment.centerRight,
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(() {
                final tipoReturno = _dataSource.delete(index);
                if(tipoReturno == true) {
                  showDialog(context: context,
                    builder: (BuildContext context) => popUpSuccessDeleteOrEdit(context, "eliminado"),
                  );
                } else {
                  showDialog(context: context,
                    builder: (BuildContext context) => popUpFailDeleteOrEdit(context, "eliminados"),
                  );
                }
              });
            },
          );
        },
      ),
    );
  }
}