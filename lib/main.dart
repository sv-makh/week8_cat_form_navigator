import 'package:flutter/material.dart';

enum GenderList { male, female }

void main() => runApp(MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: const Text("🐈 Опрос для владельцев кошек"),
            centerTitle: true),
        body: MyForm(),
      ),
    ));

class MyForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyFormState();
}

class MyFormState extends State {
  final _formKey = GlobalKey<FormState>();

  GenderList _catGender = GenderList.female;

  //виды корма
  bool _feedDry = false;
  bool _feedWet = false;
  bool _feedNatural = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10.0),
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(//прокрутка колонки
              child: Column(children: [
              const Text("Ваш питомец",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              Row(children: [
                const SizedBox(
                    width: 80,
                    child: Text(
                      "Кличка",
                      style: TextStyle(fontSize: 15.0),
                    )),
                Expanded(child: TextFormField(validator: (value) {
                  if (value!.isEmpty) return 'Пожалуйста введите кличку питомца';
                }))
              ]),
              Row(children: [
                const SizedBox(
                    width: 80,
                    child: Text(
                      "Порода",
                      style: TextStyle(fontSize: 15.0),
                    )),
                Expanded(child: TextFormField(validator: (value) {
                  if (value!.isEmpty) return 'Пожалуйста введите породу питомца';
                }))
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: 150,
                      child: RadioListTile(
                          title: const Text("самка"),
                          value: GenderList.female,
                          groupValue: _catGender,
                          onChanged: (GenderList? value) =>
                              setState(() => _catGender = value!))),
                  SizedBox(
                      width: 150,
                      child: RadioListTile(
                          title: const Text("самец"),
                          value: GenderList.male,
                          groupValue: _catGender,
                          onChanged: (GenderList? value) =>
                              setState(() => _catGender = value!))),
                ],
              ),
              Row(children: [
                const SizedBox(
                    width: 50,
                    child: Text(
                      "Корм",
                      style: TextStyle(fontSize: 15.0),
                    )),
                Column(
                  children: [
                    SizedBox(
                        width: 300,
                        child: CheckboxListTile(
                          value: _feedDry,
                          title: const Text("сухой"),
                          onChanged: (bool? value) =>
                              setState(() => _feedDry = value!),
                          controlAffinity: ListTileControlAffinity.leading,
                        )),
                    SizedBox(
                        width: 300,
                        child: CheckboxListTile(
                          value: _feedWet,
                          title: const Text("влажный"),
                          onChanged: (bool? value) =>
                              setState(() => _feedWet = value!),
                          controlAffinity: ListTileControlAffinity.leading,
                        )),
                    SizedBox(
                        width: 300,
                        child: CheckboxListTile(
                          value: _feedNatural,
                          title: const Text("натуральный"),
                          onChanged: (bool? value) =>
                              setState(() => _feedNatural = value!),
                          controlAffinity: ListTileControlAffinity.leading,
                        )),
                  ],
                )
              ]),
              const Text("Вы",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              Row(children: [
                const SizedBox(
                    width: 80,
                    child: Text(
                      "Имя",
                      style: TextStyle(fontSize: 15.0),
                    )),
                Expanded(child: TextFormField(validator: (value) {
                  if (value!.isEmpty) return 'Пожалуйста введите ваше имя';
                }))
              ]),
              Row(children: [
                const SizedBox(
                    width: 80,
                    child: Text(
                      "Телефон",
                      style: TextStyle(fontSize: 15.0),
                    )),
                Expanded(
                    child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) return 'Пожалуйста введите ваш телефон';
                          if (value.contains(RegExp(r'[a-zA-Z]'))) return 'Это не телефон';
                        },
                        keyboardType: TextInputType.phone))
              ]),
              Row(children: [
                const SizedBox(
                    width: 80,
                    child: Text(
                      "E-mail",
                      style: TextStyle(fontSize: 15.0),
                    )),
                Expanded(child: TextFormField(validator: (value) {
                  if (value!.isEmpty) return 'Пожалуйста введите ваш e-mail';
                  if (!value.contains('@')) return 'Это не E-mail';
                }))
              ]),
              ElevatedButton(
                child: const Text("Сохранить"),
                onPressed: () {
                  String message = "Данные успешно сохранены";
                  Color messageColor = Colors.green;

                  if (!_formKey.currentState!.validate() ||
                  !_feedDry && !_feedWet && !_feedNatural) {
                    message = "Данные неполны";
                    messageColor = Colors.red;
                  }

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(message),
                    duration: const Duration(seconds: 3),
                    backgroundColor: messageColor,
                    action: SnackBarAction(
                      label: "Ok",
                      textColor: Colors.black,
                      onPressed: () {},
                    ),
                  ));
                },
              )
            ]))));
  }
}
