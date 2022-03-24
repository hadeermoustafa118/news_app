import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cupit/cubit.dart';
import 'package:news_app/shared/cupit/states.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController=
    TextEditingController();
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state){},
      builder:(context, state){
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: text(
                  onChange: ( value){
                    NewsCubit.get(context).getSearch(value);
                  },
                    prefix: Icons.search,
                    controller: searchController,
                    label: 'Search',
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return ' search can not be empty';
                      }
                      else
                        return null;
                    },
                    type: TextInputType.text),
              ),
              Expanded(child: articleBuilder(list, context, isSearch: true)),
            ],
          ),
        );
      }
    );
  }
}
