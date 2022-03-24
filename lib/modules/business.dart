import 'package:flutter/material.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:news_app/shared/cupit/cubit.dart';
import 'package:news_app/shared/cupit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer <NewsCubit , NewsStates>(
      listener:(context , state){},
      builder:(context, state){
        var list = NewsCubit.get(context).business;
        return articleBuilder (list, context);
      },
    );

  }
}
