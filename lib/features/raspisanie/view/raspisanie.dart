import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:raspisanie/repositories/raspisanie/raspisanie_repo.dart';
import 'package:raspisanie/repositories/raspisanie/models/raspisanie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:raspisanie/features/chat/chat.dart';



class Raspisanie extends StatefulWidget{
  @override
  _Raspisanie createState() => _Raspisanie();
}

class _Raspisanie extends State<Raspisanie>{
  @override
  DateTime _selectedDate = DateTime.now();
  DateTime startDate = DateTime(2024, 2, 9);
  RaspisanieM? pairs;
  Future<RaspisanieM?> getPairs(int weeks) async{
    return await RaspisanieRepo().raspisanie(weeks - 1, _selectedDate.weekday % 7);
  }

  @override
  void initState(){
    super.initState();
    int weeks = (_selectedDate.difference(startDate).inDays / 7).floor();
    getPairs(weeks).then((value) {
      setState(() {
        pairs = value;
      });
    });

  }
  CalendarFormat b = CalendarFormat.twoWeeks;
  RaspisanieM? pairs2;
  @override
  Widget build(BuildContext context){
    print(pairs);
    return Scaffold(
        body:
        SingleChildScrollView(
        child:
        Column(
          children: [
            TableCalendar(
              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonTextStyle: TextStyle(color: Colors.white)
              ),
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(color: Colors.lightBlue, shape: BoxShape.circle)
              ),
              firstDay: DateTime.utc(2024, 1, 1),
              lastDay: DateTime.utc(2024, 7, 29),
              focusedDay: _selectedDate,
              formatAnimationCurve: Curves.bounceIn,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDate, day);
              },
              startingDayOfWeek: StartingDayOfWeek.monday,
              onDaySelected: (selectedDay, focusedDay) async{
                int weeks = (_selectedDate.difference(startDate).inDays / 7).floor();
                _selectedDate = selectedDay;
                try{
                  pairs2 = await RaspisanieRepo().raspisanie( weeks - 1, _selectedDate.weekday % 7);
                  setState(() {
                    pairs = pairs2;
                    _selectedDate = selectedDay;
                    _selectedDate = focusedDay;
                  });
                }catch(e){
                  pairs2 = await RaspisanieRepo().raspisanie(weeks - 1, _selectedDate.weekday % 7);
                  setState(() {
                    pairs = pairs2;
                    _selectedDate = selectedDay;
                    _selectedDate = focusedDay;
                  });
                }
                pairs2 = await RaspisanieRepo().raspisanie(weeks - 1, _selectedDate.weekday % 7);
                setState(() {
                  pairs = pairs2;
                  _selectedDate = selectedDay;
                  _selectedDate = focusedDay;
                });
                print(pairs?.pair2);
              },
              calendarFormat: b,
              onFormatChanged: (cal){
                setState(() {
                  b = cal;
                });
              },
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Card(
                      color: Colors.blueAccent,
                      child: ListTile(
                        trailing: Text(pairs?.prep1 ?? "-"),
                        subtitle: Text(pairs?.aud1 ?? "-"),
                        title: Text(pairs?.pair1 ?? "-"),
                        leading: Text("9:00 - 10:30"),
                      ) ,
                      shape:  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Card(
                      color: Colors.blueAccent,
                      child: ListTile(
                        trailing: Text(pairs?.prep2 ?? "-"),
                        subtitle: Text(pairs?.aud2 ?? "-"),
                        title: Text(pairs?.pair2 ?? "-"),
                        leading: Text("10:40 - 12:10"),
                      ) ,
                      shape:  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Card(
                      color: Colors.blueAccent,
                      child: ListTile(
                        trailing: Text(pairs?.prep3 ?? "-"),
                        subtitle: Text(pairs?.aud3 ?? "-"),
                        title: Text(pairs?.pair3 ?? "-"),
                        leading: Text("12:40 - 14:10"),
                      ) ,
                      shape:  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Card(
                      color: Colors.blueAccent,
                      child: ListTile(
                        trailing: Text(pairs?.prep4 ?? "-"),
                        subtitle: Text(pairs?.aud4 ?? "-"),
                        title: Text(pairs?.pair4 ?? "-"),
                        leading: Text("14:20 - 15:50"),
                      ) ,
                      shape:  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Card(
                      color: Colors.blueAccent,
                      child: ListTile(
                        trailing: Text(pairs?.prep5 ?? "-"),
                        subtitle: Text(pairs?.aud5 ?? "-"),
                        title: Text(pairs?.pair5 ?? "-"),
                        leading: Text("16:20 - 17:50"),
                      ) ,
                      shape:  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Card(
                      color: Colors.blueAccent,
                      child: ListTile(
                        trailing: Text(pairs?.prep6 ?? "-"),
                        subtitle: Text(pairs?.aud6 ?? "-"),
                        title: Text(pairs?.pair6 ?? "-"),
                        leading: Text("18:00 - 19:30"),
                      ) ,
                      shape:  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Card(
                      color: Colors.blueAccent,
                      child: ListTile(
                        trailing: Text(pairs?.prep7 ?? "-"),
                        subtitle: Text(pairs?.aud7 ?? "-"),
                        title: Text(pairs?.pair7 ?? "-"),
                        leading: Text("19:40 - 21:10"),
                      ) ,
                      shape:  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        )
        )
    );
  }
}

class MainView extends StatefulWidget{
  @override
  _MainView createState() => _MainView();
}

class _MainView extends State<MainView> {
  int _selectedIndex = 1;

  final List<Widget> _pages = [
    Chat(), // ну тут не authscreen соот.
    Raspisanie()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar:  ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          child: BottomNavigationBar(
            showUnselectedLabels: false,
            selectedItemColor: Colors.blueAccent,
            unselectedItemColor: Colors.white,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble, color: Colors.white70,),
                label: 'Чат',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.book_outlined, color: Colors.white70,),
                label: 'Расписаие',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_box_sharp, color: Colors.white70,),
                label: 'Профиль',
              ),
            ],
          ),
        )
      );
  }
}
