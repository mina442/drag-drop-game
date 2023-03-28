import 'package:audioplayers/audioplayers.dart';
import 'package:drag_drop4/itemModel.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  var player = AudioCache();
  List<ItemModel>? items;
  List<ItemModel>? items2;
  int? score;
  bool? gameOver;
  initGame(){
    gameOver =false;
    score =0;
    items=[
ItemModel(name:'lion', value:'lion', image:'assets/lion.png'),
ItemModel(name:'panda', value:'panda', image:'assets/panda.png'),
ItemModel(name:'camel', value:'camel', image:'assets/camel.png'),
ItemModel(name:'dog', value:'dog', image:'assets/dog.png'),
ItemModel(name:'cat', value:'cat', image:'assets/cat.png'),
ItemModel(name:'horse', value:'horse', image:'assets/horse.png'),
ItemModel(name:'sheep', value:'sheep', image:'assets/sheep.png'),
ItemModel(name:'hen', value:'hen', image:'assets/hen.png'),
ItemModel(name:'fox', value:'fox', image:'assets/fox.png'),
ItemModel(name:'cow', value:'cow', image:'assets/cow.png'),
    ];
    items2 = List<ItemModel>.from(items!);
    items!.shuffle();
    items2!.shuffle();

  }
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initGame();
  }

  Widget build(BuildContext context) {
    if(items!.length==0) gameOver =true;
    return Scaffold(
body: SafeArea(
  child: SingleChildScrollView(
  // controller: controller,
  child: Column(
    children: [
      Padding(
      padding: const EdgeInsets.all(15.0),
      child:Text.rich(
        TextSpan(
          children: [
TextSpan(
  text:'Score: ',
  style: Theme.of(context).textTheme.headline2!.copyWith(color: Colors.teal),
),
TextSpan(
  text:'$score',
  style: Theme.of(context).textTheme.headline2!.copyWith(color: Colors.teal),
),
      ])),),
      if(!gameOver!)
      Row(
        children: [
          Spacer(),
          Column(
            children: items!.map((item){
             return Container(
              margin: EdgeInsets.all(8.0),
              child: Draggable<ItemModel>(
                data:  item,
                childWhenDragging: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(item.image!),
                  radius: 50.0,
                  ), 
                  feedback: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(item.image!),
                  radius: 30.0,
                  ) ,
                  child:CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(item.image!),
                  radius: 30.0,
                  ) ,
                  ),
             );
            }).toList(),
          ),
          Spacer(flex: 2),
          Column(
            children: items2!.map((item){
              return DragTarget<ItemModel>(
                builder:(context, acceptedItem, rejectedItems) => 
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    // color: item.accepting!
                    // ?Colors.grey[400]
                    // :Colors.grey[200]
                  ),
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.width/6.5,
                  width:MediaQuery.of(context).size.width/3,
                  margin: EdgeInsets.all(8),
                  child: Text(item.name!,style: Theme.of(context).textTheme.headline6,),
                ),
                onAccept: (receivedItem) {
                  if(item.value==receivedItem.value){
                    setState(() {
                      items!.remove(receivedItem);
                    items2!.remove(item);
                    });
                    score = score! + 10;
                    item.accepting=false;
                    final player = AudioPlayer();
                    player.play(AssetSource('true.wav'));
                  }else{
                    setState(() {
                       score = score! - 5;
                    item.accepting=false;
                    final player = AudioPlayer();
                    player.play(AssetSource('false.wav'));
                    });
                  }
                },
                onWillAccept:(receivedItem) {
                  setState(() {
                    item.accepting=true;
                  });
                  return true;
                },
                onLeave: (receivedItem) {
                  setState(() {
                     item.accepting=false;
                     });
                },
                );
            }).toList(),
          ),
            Spacer()
        ],),
        if(gameOver!)
        Center(
          child: Column(children: [
            Padding(padding: EdgeInsets.all(8.9),
            child: Text(
              'Game Over',
            style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.teal),
             ),),
             Padding(padding: EdgeInsets.all(8.0),
             child: Text(
              '$score',
              style: Theme.of(context).textTheme.headline3,
              ),)
          ]),
        ),
        Container(
          height: MediaQuery.of(context).size.width/10,
          decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.circular(8)),
            child: TextButton(
              onPressed: () {
                setState(() {
                  initGame();
                });
              },
              child: Text('new game',style: TextStyle(
                color: Colors.white
              ),),
            )
          ),
    ],
  ),
),)
    );
  }
  
}