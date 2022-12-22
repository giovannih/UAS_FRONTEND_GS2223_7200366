import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GetComments extends StatefulWidget {
  const GetComments({Key? key}) : super(key: key);

  @override
  State<GetComments> createState() => _GetCommentsState();
}
class _GetCommentsState extends State<GetComments>{
  List _get = [];

  Future _getDataPhotos() async {
    try{
      final response = await http.get(Uri.parse(
          'https://jsonplaceholder.typicode.com/comments'
      ));

      if(response.statusCode == 200){
        final data = jsonDecode(response.body);

        setState((){
          _get.clear();
          _get = data;
        });
      }
    }catch(e) {
      print(e);
    }
  }

  @override
  void initState(){
    //useEffect()
    super.initState();
    _getDataPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Comment'),
        ),
        body: RefreshIndicator(
          onRefresh: _getDataPhotos,
          child: ListView.builder(
              itemCount: _get.length,
              itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black45, width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    title: Text(_get[index]['id'].toString() + "-" + _get[index]['name']),
                    subtitle: Text(_get[index]['body']),
                  ),
                );
              }

          ),
        )
    );
  }
}



