import 'package:cashcontrol/src/models/partner.model.dart';
import 'package:cashcontrol/src/utils/colores.dart';
import 'package:cashcontrol/src/widgets/custom_card.widget.dart';
import 'package:cashcontrol/src/widgets/drawer_menu.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ConsortiumCreatePage extends StatefulWidget {
  ConsortiumCreatePage({Key key}) : super(key: key);

  @override
  _ConsortiumCreatePageState createState() => _ConsortiumCreatePageState();
}

class _ConsortiumCreatePageState extends State<ConsortiumCreatePage> {
  final _formKey = GlobalKey<FormState>();
  bool _expandPartners = false;
  double _currentSliderValue = 0;
  List<PartnerModel> partnersData = [
    PartnerModel(
        id: 1,
        name: "Mateo",
        lastName: "Renteria Lujan",
        percentParticipation: .2),
  ];
  double _partnersTop = 400;
  List<InputConfig> _formCtrl = [];
  List<int> usersSelected = [];
  List<PartnerModel> _datalFiltered = [];
  List<PartnerModel> _datalAll = List.generate(
      10,
      (i) => PartnerModel(
          id: i + 3,
          name: "User $i",
          lastName: "Name-${i * 5}",
          phone: "${i + 2}${i * 3}${i / 5}${i * 5}${i - 2}"));
  TextEditingController searchCtrl;

  @override
  void initState() {
    _formCtrl.add(InputConfig("Nombre"));
    ["Capital Mesual", "Tiempo (# de meses)", "Rentabilidad Esperada"]
        .forEach((key) {
      _formCtrl.add(InputConfig(key, keyboardType: TextInputType.number));
    });
    searchCtrl = new TextEditingController();
    _datalAll.forEach((el) {
      print(el.phone);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: SharedMenu(),
        appBar: AppBar(
          title: Text("Consortium", style: TextStyle(color: Colors.white)),
          backgroundColor: Color(0xff2406d6),
          shadowColor: Colors.transparent,
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
          onPressed: () {},
          backgroundColor: Color(0xff2406d6),
        ),
        body: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              gradient: LinearGradient(
                  begin: FractionalOffset.topLeft,
                  end: FractionalOffset.bottomRight,
                  colors: [
                    Color(0xff2406d6),
                    Color(0xff0af5ca),
                  ],
                  stops: [
                    0,
                    4
                  ])),
          child: Stack(children: [form(), partnersWidget()]),
        ),
      );

  Widget form() => Container(
        padding: EdgeInsets.all(15),
        child: Builder(
          builder: (context) => Form(
            key: _formKey,
            child: Column(
              children: _formCtrl
                  .map<Widget>((item) => textBox(item.title, item.controller,
                      keyboardType: item.keyboardType))
                  .toList(),
            ),
          ),
        ),
      );

  Widget textBox(String title, TextEditingController cotroller,
          {TextInputType keyboardType: TextInputType.text}) =>
      SizedBox(
        height: 100,
        child: TextFormField(
          keyboardType: keyboardType,
          style: TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          decoration: InputDecoration(
            labelText: title,
            labelStyle: TextStyle(
              color: Colors.white,
            ),
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(
                color: Colors.blue,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
          ),
          controller: cotroller,
          validator: (value) {
            if (value.isEmpty) {
              return 'el campo $title, es obligatorio';
            }
          },
        ),
      );

  Widget partnersWidget() {
    final size = MediaQuery.of(context).size;
    return AnimatedPositioned(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        top: _partnersTop,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            height: _expandPartners ? size.height * .9 : size.height * 0.45,
            width: size.width,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(.8),
                borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
            child: Column(
              children: [
                expander(),
                partnersContracted(),
                (_expandPartners ? addPartners() : Container())
              ],
            )));
  }

  Widget expander() {
    final size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.topCenter,
      child: FlatButton(
        onPressed: expandPartners,
        child: Container(
          height: 1,
          width: size.width * .1,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white,
                width: 3.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget addPartners() {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        textboxSearch(),
        Container(
            height: size.height * .53,
            child: ListView(
                children: _datalFiltered
                    .map<Widget>((partner) => customCard(
                        ListTile(
                          leading: Image.asset("assets/images/user-avatar.PNG"),
                          title: Text(partner.fullName,
                              style: TextStyle(fontSize: 20)),
                          subtitle: Slider(
                            value: _currentSliderValue,
                            min: 0,
                            max: 100,
                            divisions: 20,
                            label: _currentSliderValue.round().toString(),
                            onChanged: (double value) {
                              setState(() {
                                _currentSliderValue = value;
                              });
                            },
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () => addPartner(partner),
                          ),
                        ),
                        height: size.height * .1,
                        color1: Colores.blue2,
                        color2: Colores.blue3))
                    .toList()))
      ],
    );
  }

  Widget textboxSearch() => SizedBox(
        height: 65,
        child: Align(
          alignment: Alignment.topCenter,
          child: TextFormField(
            style: TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: search,
              ),
              labelText: "Buscar Socios",
              labelStyle: TextStyle(
                color: Colores.blue1,
              ),
              filled: true,
              fillColor: Colors.black.withOpacity(.2),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
            ),
            controller: searchCtrl,
          ),
        ),
      );

  Widget partnersContracted() => Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.only(bottom: 5),
        child: Column(
          children: [
            partnersHeader(),
            Container(
              height: partnersData.length == 1 ? 100 : 200,
              child: partnersAdded(),
            )
          ],
        ),
      );

  Widget partnersAdded() {
    final size = MediaQuery.of(context).size;
    return ListView(
      children: partnersData
          .map<Widget>((partner) => customCard(
              ListTile(
                leading: Image.asset("assets/images/user-avatar.PNG"),
                title: Text(partner.fullName, style: TextStyle(fontSize: 20)),
                subtitle: Text(
                    "${partner.percentParticipation * 100}% de particiáción",
                    style: TextStyle(fontSize: 16)),
                trailing: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => removePartner(partner),
                ),
              ),
              height: size.height * .1,
              color1: Colores.blue2,
              color2: Colores.blue3))
          .toList(),
    );
  }

  Widget partnersHeader() => Column(children: [
        Text("Agregar Socios",
            style: TextStyle(fontSize: 22, color: Colors.black)),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            padding: const EdgeInsets.all(1.0),
            decoration: BoxDecoration(color: Colors.white.withOpacity(.5)),
            child: LinearProgressIndicator(
              minHeight: 10,
              backgroundColor: Color(0xff069fd6),
              valueColor: new AlwaysStoppedAnimation<Color>(Color(0xff2406d6)),
              value: getPercentParticipation(),
            ),
          ),
        ),
      ]);

  void expandPartners() {
    final size = MediaQuery.of(context).size;
    setState(() {
      _expandPartners = !_expandPartners;
      _partnersTop = _expandPartners ? 0 : 400;
    });
  }

  void removePartner(PartnerModel partner) {}

  double getPercentParticipation() =>
      partnersData.map((e) => e.percentParticipation).reduce((a, b) => a + b);

  void save() {
    final form = _formKey.currentState;
    if (form.validate()) {
      // print(model);
      // model.save();
      // model = PersonModel();
      // form.save();
      // form.reset();
      // getData();
    }
  }

  void search() {
    if (searchCtrl.text.length <= 3) return;

    _datalAll.where((el) => el.phone.contains(searchCtrl.text)).forEach((el) {
      _datalFiltered.add(el);
    });
    setState(() {});
  }

  void addPartner(PartnerModel partner) {
    partnersData.add(partner);
    _datalFiltered.removeWhere((el) => el.id == partner.id);
    setState(() {
      
    });
  }
}

class InputConfig {
  String title;
  TextEditingController controller;
  TextInputType keyboardType;

  InputConfig(this.title, {this.keyboardType: TextInputType.text}) {
    this.controller = new TextEditingController();
  }
}
