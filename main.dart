import 'package:flutter/material.dart';
import 'package:tasks/tarefa.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

main() => runApp(const MainApp());

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  TextEditingController edtTarefa = TextEditingController();
  List<Tarefa> tarefas = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(appBarTheme: AppBarTheme(color: Colors.black)),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: appBar(),
          body: body(),
          floatingActionButton: buildFloatingActionButton()),
    );
  }

  body() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(5),
        child: Column(
          children: [
            TextFormField(
              controller: edtTarefa,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.shopping_cart, color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.5),
                      borderRadius: BorderRadius.circular(15)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.5),
                      borderRadius: BorderRadius.circular(15)),
                  hintText: "Adicione um item na lista",
                  labelText: "Item",
                  labelStyle: TextStyle(color: Colors.black)),
            ),
            Scrollbar(
              child: ListView.builder(
                primary: true,
                  shrinkWrap: true,
                  itemCount: tarefas.length,
                  itemBuilder: (context, index) {
                    return buildItem(index);
                  }),
            )
          ],
        ),
      ),
    );
  }

  appBar() {
    return AppBar(
      centerTitle: true,
      title: const Text("Lista da Feira"),
    );
  }

  buildItem(index) {
    return Container(
      margin: const EdgeInsets.all(1),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.grey.shade300,
        child: Slidable(
          key: UniqueKey(),
          startActionPane: ActionPane(
            dismissible: DismissiblePane(
              onDismissed: () {
                setState(() {
                  tarefas.removeAt(index);
                });
              },
            ),
            motion: ScrollMotion(),
            children: [
              SlidableAction(
                  label: "Excluir",
                  backgroundColor: Colors.black,
                  icon: Icons.delete,
                  onPressed: (context) {})
            ],
          ),
          child: CheckboxListTile(      
            title: Text(tarefas[index].tarefa,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.black,
                    decoration: tarefas[index].estado
                        ? TextDecoration.lineThrough
                        : TextDecoration.none)),
            value: tarefas[index].estado,
            onChanged: (value) {
              setState(() {
                tarefas[index].estado = !tarefas[index].estado;
                tarefas.sort((a, b) {
                  if (b.estado) {
                    return -1;
                  }
                  return 1;
                });
              });
            },
            activeColor: Colors.black,
          ),
        ),
      ),
    );
  }

  void cadastrarElemento() {
    setState(() {
      tarefas.add(Tarefa(edtTarefa.text, false));
      edtTarefa.clear();
      
    });
  }

  buildFloatingActionButton() {
    return FloatingActionButton(
        onPressed: () {
          cadastrarElemento();
        },
        child: Icon(Icons.add_rounded, color: Colors.white),
        backgroundColor: Colors.black);
  }
}
