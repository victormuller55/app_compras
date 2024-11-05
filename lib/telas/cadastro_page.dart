import 'package:aula_01/app_widget/consts/color.dart';
import 'package:aula_01/models/item_model.dart';
import 'package:aula_01/telas/bloc/bloc.dart';
import 'package:aula_01/telas/bloc/events.dart';
import 'package:flutter/material.dart';
import 'package:muller_package/muller_package.dart';

class CadastroPage extends StatefulWidget {
  final AppBloc bloc;

  const CadastroPage({super.key, required this.bloc});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {

  late AppFormField _titleForm;
  late AppFormField _descriptionForm;
  late AppFormField _valueForm;

  @override
  void initState() {

    _titleForm = AppFormField(
      context: context,
      hint: "Digite o titulo",
      radius: AppRadius.normal,
    );

    _descriptionForm = AppFormField(
      context: context,
      hint: "Digite o descrição",
      radius: AppRadius.normal,
      maxLines: 5,
    );

    _valueForm = AppFormField(
      context: context,
      hint: "Digite o valor",
      radius: AppRadius.normal,
      textInputType: TextInputType.number,
      textInputFormatter: AppFormFormatters.realFormatter
    );

    super.initState();
  }

  void _save() {
    ItemModel item = ItemModel(
      title: _titleForm.value,
      subtitle: _descriptionForm.value,
      value: double.parse(_valueForm.value.replaceAll("R\$ ", "")),
    );

    widget.bloc.add(AdicionarEvent(item, widget.bloc.state.items));
    Navigator.pop(context);
  }

  Widget _body() {
    return ListView(
      padding: EdgeInsets.all(AppSpacing.normal),
      children: [
        _titleForm.formulario,
        _valueForm.formulario,
        _descriptionForm.formulario,
        appSizedBox(height: AppSpacing.normal),
        appElevatedButtonText(
          "Salvar".toUpperCase(),
          function: () => _save(),
          color: AColors.primary,
          textColor: AppColors.white,
          borderRadius: AppRadius.normal,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return scaffold(
      drawerIconColor: AppColors.white,
      appBarBackground: AColors.primary,
      title: "Cadastro de Item",
      body: _body(),
    );
  }
}
