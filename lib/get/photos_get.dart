import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GetPhotos extends StatefulWidget {
  const GetPhotos({Key? key}) : super(key: key);

  @override
  State<GetPhotos> createState() => _GetPhotosState();
}
class _GetPhotosState extends State<GetPhotos>{
  List _get = [];

  Future _getDataPhotos() async {
    try{
      final response = await http.get(Uri.parse(
          'https://jsonplaceholder.typicode.com/photos'
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
          title: Text('Photos'),
        ),
        body: RefreshIndicator(
          onRefresh: _getDataPhotos,
          child: ListView.builder(
              itemCount: _get.length,
              itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    color: Colors.white,
                    elevation: 10,
                    margin: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            radius: 30.0,
                            // backgroundImage:NetworkImage('https://via.placeholder.com/150'),
                            backgroundImage: NetworkImage(_get[index]['thumbnailUrl'].toString()),
                            backgroundColor: Colors.transparent),
                          title: Text(_get[index]['id'].toString()),
                          subtitle: Text(_get[index]['title'].toString()),
                        )
                      ],
                    ),
                  )
                );
              }

          ),
        )
    );
  }
}



