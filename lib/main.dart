import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My App")),
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 10,
          children: [
            ElevatedButton(onPressed: ()async{
              var result=await Navigator.push(context, MaterialPageRoute(builder: (c)=>SecondPage()));
              print('hasil: $result');
            }, child: Text('Goto Second Page')),
            Expanded(child: ListView.separated(itemBuilder: (_,i)=>_hotelItem(context), separatorBuilder: (_,i)=>SizedBox(height: 5), itemCount: 20))
          ],
        ),
      ),
    );
  }
  Widget _hotelItem(BuildContext context){
    var hotelRating=1;
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.network('https://pix10.agoda.net/hotelImages/124/1246280/1246280_16061017110043391702.jpg?ca=6&ce=1&s=414x232',
              width: MediaQuery.of(context).size.width/3.5,
              fit: BoxFit.cover,),
              
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    spacing: 5,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("HARRIS Hotel Kuta Tuban Bali", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                      Row(
                        children: List.generate(5, (i)=>Icon(Icons.star,size: 25,color:i<=hotelRating-1? Colors.amber:Colors.grey.shade300)),
                      ),
                      Text("HARRIS Hotel Kuta Tuban Bali"),
                      Row(
                        spacing: 5,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.indigoAccent,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)
                              )
                            ),
                            child: Row(
                              children: [
                                Text("8,6",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.white)),
                                Text("/10",style: TextStyle(fontSize: 12,color: Colors.white),)
                              ],
                            ),
                          ),
                          Text('Luar Biasa', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.indigoAccent,fontSize: 13)),
                          Text('625 Ulasan', style: TextStyle(color: Colors.black54,fontSize: 12),)
                        ],
                      ),
                      Text("5.677 orang menambahkan ke favorit", style: TextStyle(fontSize: 11,color: Colors.black54),),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Rp",style: TextStyle(color: Colors.indigo,fontSize: 12),),
                          Text("669.422",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.indigo,fontSize: 18),),
                          SizedBox(width: 10)
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Total harga: Rp810.000", style: TextStyle(fontSize: 12,color: Colors.black54),),
                            Text("Termasuk pajak & biaya lainnya", style: TextStyle(fontSize: 12,color: Colors.black54),),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff234494),
      appBar: AppBar(title: Text("Second Page"),automaticallyImplyLeading: false,actions: [
        IconButton(onPressed: (){
          Navigator.pop(context, 'ini data dari halaman 2');
        }, icon: Icon(Icons.close))
      ],),
      body: Container(
        width: 400,
        height: 400,
        padding: EdgeInsets.all(2),
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white,width: 3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Transform.translate(offset: Offset(20, 20), child: RandomRounded()),
            Transform.translate(offset: Offset(30,45), child: RandomRounded()),
            RandomRounded(),
            RandomRounded(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (_)=>MyWidget()));
      },child: Icon(Icons.send)),
    );
  }
}
class RandomRounded extends StatefulWidget {
  const RandomRounded({super.key});

  @override
  State<RandomRounded> createState() => _RandomRoundedState();
}

class _RandomRoundedState extends State<RandomRounded> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(radius: 30,backgroundColor: Colors.primaries[(DateTime.now().microsecondsSinceEpoch%Colors.primaries.length-1).abs()]);
  }
}
class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  void didUpdateWidget(covariant MyWidget oldWidget) {
    print('berubah ---');
    super.didUpdateWidget(oldWidget);
  }
  var name="Budi";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name),),
      body: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              color: Colors.red,
              width: 50,
              height: 50,
            ),
            Container(
              color: Colors.blue,
              width: 50,
              height: 50,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        setState(() {
          //todo
          name="Bagus";
        });
      },child: Icon(Icons.share)),
    );
  }
}