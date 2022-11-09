import 'package:converter_money/repository/repository_api.dart';
import 'package:converter_money/widgets/field.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Map<String, dynamic> data;
  late double dollar;
  late double euro;
  late double bitcoin;

  @override
  void initState() {
    super.initState();
    infoData();
  }

  infoData() async {
    data = await getData();
    dollar = double.parse(await data['USDBRL']['bid']);
    euro = double.parse(await data['EURBRL']['bid']);
    bitcoin = double.parse(await data['BTCBRL']['bid']);
  }

  final moneyRealController = TextEditingController();
  final moneyDollarController = TextEditingController();
  final moneyEuroController = TextEditingController();
  final moneyBitcoinController = TextEditingController();

  void _onChangeReal(String text) {
    late double real;
    text.isEmpty ? real = 0 : real = double.parse(text.replaceAll(',', '.'));

    moneyDollarController.text = (real / dollar).toStringAsFixed(2);
    moneyEuroController.text = (real / euro).toStringAsFixed(2);
    moneyBitcoinController.text = (real / bitcoin).toStringAsFixed(2);
  }

  void _onChangeDollar(String text) {
    late double dollar;
    text.isEmpty
        ? dollar = 0
        : dollar = double.parse(text.replaceAll(',', '.'));

    moneyRealController.text = (dollar * this.dollar).toStringAsFixed(2);
    moneyEuroController.text = (dollar * this.dollar / euro).toStringAsFixed(2);
    moneyBitcoinController.text =
        (dollar * this.dollar / bitcoin).toStringAsFixed(2);
  }

  void _onChangeEuro(String text) {
    late double euro;
    text.isEmpty ? euro = 0 : euro = double.parse(text.replaceAll(',', '.'));

    moneyRealController.text = (euro * this.euro).toStringAsFixed(2);
    moneyDollarController.text = (euro * this.euro / dollar).toStringAsFixed(2);
    moneyBitcoinController.text =
        (euro * this.euro / bitcoin).toStringAsFixed(2);
  }

  void _onChangeBitcoin(String text) {
    late double bitcoin;
    text.isEmpty
        ? bitcoin = 0
        : bitcoin = double.parse(text.replaceAll(',', '.'));

    moneyRealController.text = (bitcoin * this.bitcoin).toStringAsFixed(2);
    moneyDollarController.text =
        (bitcoin * this.bitcoin / dollar).toStringAsFixed(2);
    moneyEuroController.text =
        (bitcoin * this.bitcoin / euro).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversor Moeda'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: clearFiled,
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const Icon(
              Icons.monetization_on_rounded,
              size: 200,
            ),
            fieldcoin(moneyRealController, 'Real', '2.50', _onChangeReal,
                pre: 'R\$ '),
            const SizedBox(
              height: 10,
            ),
            fieldcoin(moneyDollarController, 'Dollar', '2.50', _onChangeDollar,
                pre: 'US\$ '),
            const SizedBox(
              height: 10,
            ),
            fieldcoin(moneyEuroController, 'Euro', '2.50', _onChangeEuro,
                icon:
                    const Icon(IconData(0xe23b, fontFamily: 'MaterialIcons'))),
            const SizedBox(
              height: 10,
            ),
            fieldcoin(
                moneyBitcoinController, 'Bitcoin', '2.50', _onChangeBitcoin,
                icon: const Icon(Icons.currency_bitcoin_rounded)),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      )),
    );
  }

  void clearFiled() {
    moneyBitcoinController.text = '';
    moneyDollarController.text = '';
    moneyRealController.text = '';
    moneyEuroController.text = '';
  }
}
