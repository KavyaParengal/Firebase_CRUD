
import 'package:flutter/material.dart';

class Firebase_CRUD extends StatefulWidget {
  const Firebase_CRUD({Key? key}) : super(key: key);

  @override
  State<Firebase_CRUD> createState() => _Firebase_CRUDState();
}

class _Firebase_CRUDState extends State<Firebase_CRUD> {

  List item=['Shirt','Shirt'];
  List price=['800','800'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown,
          onPressed: (){},
          child: Icon(Icons.add,size: 30,color: Colors.white,),
      ),
      appBar: AppBar(
        title: Text('Firebase CRUD',),
        centerTitle: true,
        backgroundColor: Colors.brown.shade600,
      ),
      body: ListView.builder(
        shrinkWrap: true,
          itemCount: item.length,
          itemBuilder: (context,index){
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item[index],style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                          SizedBox(height: 10,),
                          Text('RS  ${price[index]}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: Colors.grey)),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: (){},
                              icon: Icon(Icons.edit,color: Colors.grey.shade500,)
                          ),
                          IconButton(
                              onPressed: (){},
                              icon: Icon(Icons.delete,color: Colors.grey.shade500,)
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(thickness: 1,color: Colors.grey.shade300,)
              ],
            );
          }
      ),
    );
  }
}
