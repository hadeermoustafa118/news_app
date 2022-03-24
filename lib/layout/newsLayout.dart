import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/searchScreen.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cupit/AppCubit/appCubit.dart';
import 'package:news_app/shared/cupit/cubit.dart';
import 'package:news_app/shared/cupit/states.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

//GET https://newsapi.org/v2/top-headlines?country=us&apiKey=6a0fa64388a24ae8b326f922d962affd
//https://newsapi.org/v2/everything?q=tesla&apiKey=6a0fa64388a24ae8b326f922d962affd  for search
class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = NewsCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'News App',
                ),
                centerTitle: true,
                actions: [
                  IconButton(
                    icon: Icon(Icons.brightness_4_outlined),
                    onPressed: () {
                      NewsCubit.get(context).changeModeApp();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      navigateTo(context, SearchScreen());
                    },
                  ),

                ],
              ),

              body: cubit.screens[cubit.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeBottomNarBar(index);
                },
                items: cubit.bottomItems,
              ),
            );
          });
  }
}
