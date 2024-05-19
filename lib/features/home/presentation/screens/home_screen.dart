import 'package:flutter/material.dart';

import '../../domain/entity/todos_entity.dart';
import '../widget/todos_blc_consumer.dart';

class HomeScreen extends StatelessWidget {
  final TodosEntity? todosEntity;

  const HomeScreen({
    super.key,
    this.todosEntity,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: TodosBlocListener(),
      ),
    );
  }
}
