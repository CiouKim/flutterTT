import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/binding.dart';
import 'dart:developer';
import 'package:my_app/Second.dart';
import 'package:my_app/API+Helper/ApiHelper.dart';
import 'package:my_app/Model/Model.dart';

// Uncomment lines 3 and 6 to view the visual layout at runtime.
// import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

void main() {
  // debugPaintSizeEnabled = true;
  runApp(const IAGApp());
}

class IAGApp extends StatelessWidget {
  const IAGApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter layout demo',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListView(
          children: [
            Image.asset(
              'images/lake.jpg',
              width: 600,
              height: 240,
              fit: BoxFit.cover,
            ),
            // titleSection,
            LoginContent(loginContentTitle: ''),
            // buttonSection,
            // textSection,
          ],
        ),
      ),
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({super.key});

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = true;
  int _favoriteCount = 41;

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
      } else {
        _favoriteCount += 1;
      }
      _isFavorited = !_isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    var container = Container(
      padding: const EdgeInsets.all(0),
      child: IconButton(
        padding: const EdgeInsets.all(0),
        alignment: Alignment.centerRight,
        icon: (_isFavorited
            ? const Icon(Icons.star)
            : const Icon(Icons.star_border)),
        color: Colors.red[500],
        onPressed: _toggleFavorite,
      ),
    );

    var sizedBox = SizedBox(
      width: 18,
      child: SizedBox(
        child: Text('$_favoriteCount'),
      ),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        container,
        const SizedBox(width: 10),
        sizedBox,
        const SizedBox(width: 10)
      ],
    );
  }
}

class LoginContent extends StatefulWidget {
  final String loginContentTitle;
  const LoginContent({Key? key, required this.loginContentTitle})
      : super(key: key);
  @override
  State<LoginContent> createState() => _LoginContent();
}

class _LoginContent extends State<LoginContent> {
  TextEditingController _textEditingController = TextEditingController();
  final RegExp _regex = RegExp(r'^[a-zA-Z0-9]+'); // 使用正規表達式限制只能輸入英文字母和數字
  String account = '';
  String pwd = '';
  bool pwdObscureText = true;

  void togglePWDObscureText() {
    setState(() {
      pwdObscureText = !pwdObscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    var ss = 1;
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: Column(children: [
          TextField(
            // controller: _textEditingController,
            onChanged: (value) {
              account = value;
              debugPrint('account: $account xxx ');
            },
            clipBehavior: Clip.antiAliasWithSaveLayer,
            maxLength: 10,
            inputFormatters: [FilteringTextInputFormatter.allow(_regex)],
            decoration: const InputDecoration(
                hintText: 'input account',
                suffixIcon: Icon(Icons.remove_red_eye)),
          ),
          TextField(
            // controller: _textEditingController,
            obscureText: pwdObscureText,
            onChanged: (value) {
              pwd = value;
              debugPrint('pwd: $pwd');
            },
            maxLength: 10,
            inputFormatters: [FilteringTextInputFormatter.allow(_regex)],
            decoration: InputDecoration(
                hintText: 'input pwd',
                enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple)),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple),
                ),
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple),
                ),
                suffixIconColor: Colors.purple,
                suffixIcon: GestureDetector(
                  onTap: togglePWDObscureText,
                  child: Icon(
                      pwdObscureText ? Icons.visibility : Icons.visibility_off),
                )),
          ),
          OutlinedButton(
            child: const Text("Click"),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                      icon: const Icon(Icons.star),
                      title: Text(pwd),
                      content: Text(account),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel')),
                        TextButton(
                            onPressed: () async {
                              debugger();
                              try {
                                Map<String, dynamic> postData = {
                                  'name': 'John',
                                  'age': 25,
                                };
                                var res = await getRequest<Res>(
                                    'https://s3.hicloud.net.tw/clifeuat/iLink2/xxx.txt');
                                debugger();

                                print(res.data.length);
                                // print(person.age.toString());
                              } catch (e) {
                                print('Error: $e');
                              }

                              // Navigator.of(context).pop();
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context)  =>  Second(pwd: pwd)),
                              // );
                            },
                            child: const Text('OK')),
                      ]);
                },
              );
            },
          ),
        ]),
      ),
    );
  }
}

extension IntegerParse on String {
  String toValue() {
    return '$this' + 'xxx';
  }
}
