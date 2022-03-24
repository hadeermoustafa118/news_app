import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:news_app/modules/webViewScreen.dart';

//String url = 'https://www.google.com/';
Widget buildArticleItem(article, context) => InkWell(
  onTap: (){
    navigateTo(context,  WebViewScreen( url: '${article['url']}' ));
  },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                    image: NetworkImage('${article['urlToImage']}'),
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Container(
                height: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text('${article['publishedAt']}',
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget divider() => Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey.shade300,
      ),
    );

Widget articleBuilder(list, context , {isSearch = false}) => ConditionalBuilderRec(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              buildArticleItem(list[index], context),
          separatorBuilder: (context, index) => divider(),
          itemCount: list.length),
      fallback: (context) => isSearch ? Container():  Center(
        child: CircularProgressIndicator(),
      ),
    );

Widget text({
  required TextEditingController controller,
  required TextInputType type,
  required FormFieldValidator<String> validate,
  VoidCallback? suffixPressed,
  VoidCallback? onTap,
  Function(String)? onChange,
  required String label,
  required IconData prefix,
  bool ispassword = false,
  IconData? suffix,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onChanged: onChange,
      validator: validate,
      onTap: onTap,
      enabled: isClickable,
      obscureText: ispassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: suffixPressed,
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
