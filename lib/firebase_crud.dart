import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Firebase_CRUD extends StatefulWidget {
  const Firebase_CRUD({Key? key}) : super(key: key);

  @override
  State<Firebase_CRUD> createState() => _Firebase_CRUDState();
}

class _Firebase_CRUDState extends State<Firebase_CRUD> {
  List item = ['Shirt', 'Shirt'];
  List price = ['800', '800'];

  final CollectionReference _product =
      FirebaseFirestore.instance.collection('products');
  final TextEditingController _pnameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  // Future<void> _create([DocumentSnapshot? documentSnapshot]) async{
  //   if(documentSnapshot != null){
  //     _pnameController.text=documentSnapshot['name'];
  //     _priceController.text=documentSnapshot['price'].toString();
  //   }
  //   await showModalBottomSheet(
  //     isScrollControlled: true,
  //       context: context,
  //       builder: (BuildContext context){
  //         return Padding(
  //             padding: EdgeInsets.only(top: 20,left: 20,right: 20,),
  //           child: Column(
  //             children: [
  //               TextFormField(
  //                 controller: _pnameController,
  //                 decoration: InputDecoration(
  //                   label: Text('Name')
  //                 ),
  //               ),
  //               TextFormField(
  //                 keyboardType: const TextInputType.numberWithOptions(decimal: true),
  //                 controller: _priceController,
  //                 decoration: InputDecoration(
  //                     label: Text('Price')
  //                 ),
  //               ),
  //               SizedBox(height: 50,),
  //               ElevatedButton(
  //                   onPressed: () async{
  //                     final String name=_pnameController.text;
  //                     final double? price = double.parse(_priceController.text);
  //                     if(price != null){
  //                       await _product.add({'name':name,'price':price});
  //                       _pnameController.text='';
  //                       _priceController.text='';
  //                     }
  //                   },
  //                   child: Text('ADD')
  //               )
  //             ],
  //           ),
  //         );
  //       }
  //   );
  // }

  Future<void> _update(DocumentSnapshot? documentSnapshot) async {
    if (documentSnapshot != null) {
      _pnameController.text = documentSnapshot['name'];
      _priceController.text = documentSnapshot['price'].toString();
    }
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Update Item',
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
        ),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * .3,
          child: Column(
            children: [
              TextField(
                controller: _pnameController,
                decoration: InputDecoration(
                  labelText: "Name",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.brown),
                  ),
                ),
              ),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(
                  labelText: "Price",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.brown),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () async {
                  final String name = _pnameController.text;
                  final double? price = double.parse(_priceController.text);
                  if (price != null) {
                    await _product.doc(documentSnapshot!.id).update({'name': name, 'price': price});
                    _pnameController.text = '';
                    _priceController.text = '';
                  }
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Firebase_CRUD()));
                },
                child: Text('UPDATE'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _pnameController.text = documentSnapshot['name'];
      _priceController.text = documentSnapshot['price'].toString();
    }
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Add Item',
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
        ),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * .3,
          child: Column(
            children: [
              TextField(
                controller: _pnameController,
                decoration: InputDecoration(
                  labelText: "Name",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.brown),
                  ),
                ),
              ),
              TextField(
                controller: _priceController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: "Price",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.brown),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () async {
                  final String name = _pnameController.text;
                  final double? price = double.parse(_priceController.text);
                  if (price != null) {
                    await _product.add({'name': name, 'price': price});
                    _pnameController.text = '';
                    _priceController.text = '';
                  }
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Firebase_CRUD()));
                },
                child: Text('ADD'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _delete(String product) async {
    await _product.doc(product).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a product')));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown,
        onPressed: () {
          _create();
        },
        child: Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        title: Text(
          'Firebase CRUD',
        ),
        centerTitle: true,
        backgroundColor: Colors.brown.shade600,
      ),
      body: StreamBuilder(
        stream: _product.snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
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
                                Text(
                                  documentSnapshot['name'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    'RS  ${documentSnapshot['price'].toString()}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey)),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      _update(documentSnapshot);
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.grey.shade500,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      _delete(documentSnapshot.id);
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.grey.shade500,
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.grey.shade300,
                      )
                    ],
                  );
                });
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
