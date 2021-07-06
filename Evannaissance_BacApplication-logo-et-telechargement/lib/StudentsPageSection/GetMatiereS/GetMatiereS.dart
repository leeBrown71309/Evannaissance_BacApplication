import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class GetMathS extends StatefulWidget {
  const GetMathS({Key? key}) : super(key: key);

  @override
  _GetMathSState createState() => _GetMathSState();
}

class _GetMathSState extends State<GetMathS> {
  bool loading = true;
  late List Mathlist;

  Future fetchMathPdf()async {
    var url = Uri.parse("http://192.168.1.16/workstation/flutter%20app%20auth/getmatieres.php");
    var response = await http.post(url);
    if(response.statusCode==200){
      setState(() {
        Mathlist = jsonDecode(response.body);
        loading = false;
      });
      print(Mathlist);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMathPdf();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
