import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view/web_view_screen.dart';

Widget defaultButton({
  double width = double.maxFinite,
  Color backgroundColor = Colors.blue,
  bool isUpperCase = true,
  required Function() function,
  required String text,
}) =>
    Container(
      width: width,
      color: backgroundColor,
      child: ElevatedButton(
        onPressed: function,
        child: Text(isUpperCase ? text.toUpperCase() : text),
      ),
    );

Widget defaultTextButton({
  required Function() function,
  required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(text.toUpperCase()),
    );

Widget defulteditTextx({
  required TextEditingController Controller,
  required TextInputType keyboardType,
  GestureTapCallback? onTap,
  required FormFieldValidator<String> validator,
  required String Label,
  required IconData prefix,
  IconData? suffix,
  bool? isPassword = false,
  Function? suffixPressed()?,
  Function? onchanged(value)?,
  Function? onSubmitted(value)?,
}) =>
    TextFormField(
      onTap: onTap,
      obscureText: isPassword!,
      controller: Controller,
      keyboardType: keyboardType,
      onFieldSubmitted: onSubmitted,
      onChanged: onchanged,
      validator: validator,
      decoration: InputDecoration(
        labelText: Label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: IconButton(
          icon: Icon(suffix),
          onPressed: suffixPressed,
        ),
      ),
    );

Widget buildArticalItem(article, context) => InkWell(
      onTap: () {
        navigateTo(context, WebViewScreen(article["url"]));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            if (article['urlToImage'] != null)
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                          '${article['urlToImage']}'),
                      fit: BoxFit.cover,
                    )),
              ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "${article['title']}",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    Text(
                      "${article['publishedAt']}",
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[300],
      ),
    );
Widget articalBuilderList(List, context, {isSearch = false}) =>
    ConditionalBuilder(
      condition: (List.length > 0),
      builder: (context) => ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              buildArticalItem(List[index], context),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: 10),
      fallback: (context) => isSearch
          ? Container()
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
void navigateTo(context, Widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
    );

void navigateAndFinish(context, Widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
      (route) => false,
    );
