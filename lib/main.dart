import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _YourProductivApp();
  }
}

class _YourProductivApp extends State<MyApp> {
  // variable
  late int _count; // количество баллов
  // ТАЙМЕР
  int _minutesLeft = 0;
  bool _isRunning = false;
  late Timer _timer;

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _startTimer(int duration) {
    setState(() {
      _minutesLeft = duration;
      _isRunning = true;
    });
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      setState(() {
        _minutesLeft -= 1;
      });

      if (_minutesLeft <= 0) {
        _timer.cancel();
        setState(() {
          _isRunning = false;
        });
      }
    });
  }

  void _stopTimer() {
    _timer.cancel();
    setState(() {
      _minutesLeft = 0;
      _isRunning = false;
    });
  }

  @override
  void dispose() {
    // variable clear method dispose
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    _count = 0; // количество баллов
    // variable initialization this method
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.deepOrange[300],
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: const Text(
            'Твой продуктив',
            style: TextStyle(fontSize: 20),
          ),
          actions: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(right: 30),
                child: Text(
                  '$_count',
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            //Text('$_count', style: const TextStyle(fontSize: 20, color: Colors.red),),
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 50, left: 35),
                  child: Container(
                    height: 250,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          width: 320,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            border: Border.all(
                              width: 3,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$_minutesLeft minutes left',
                                style: TextStyle(fontSize: 24),
                              ),
                              SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () => _startTimer(25), // 25 minutes
                                child: Text('Start 25-minute timer'),
                              ),
                              SizedBox(height: 16),
                              _isRunning
                                  ? ElevatedButton(
                                      onPressed: _stopTimer,
                                      child: Text('Stop timer'),
                                    )
                                  : SizedBox.shrink(),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          width: 320,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            border: Border.all(
                              width: 3,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$_minutesLeft minutes left',
                                style: TextStyle(fontSize: 24),
                              ),
                              SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () => _startTimer(25), // 25 minutes
                                child: Text('Start 25-minute timer'),
                              ),
                              SizedBox(height: 16),
                              _isRunning
                                  ? ElevatedButton(
                                      onPressed: _stopTimer,
                                      child: Text('Stop timer'),
                                    )
                                  : SizedBox.shrink(),
                            ],
                          ),
                        ),
                        Container(
                          width: 320,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            border: Border.all(
                              width: 3,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$_minutesLeft minutes left',
                                style: TextStyle(fontSize: 24),
                              ),
                              SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () => _startTimer(25), // 25 minutes
                                child: Text('Start 25-minute timer'),
                              ),
                              SizedBox(height: 16),
                              _isRunning
                                  ? ElevatedButton(
                                      onPressed: _stopTimer,
                                      child: Text('Stop timer'),
                                    )
                                  : SizedBox.shrink(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 50, left: 35, right: 35),
                    child: TaskListWidget()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*
  TODO:
  1) сделать таймер,который будет находиться в виджетах.
    при нажатии на который будет произведен отсчет
  2) сделать список задач. Можно ввести задачи в него. За использованием таймера начисляются баллы
 */

class TaskListWidget extends StatefulWidget {
  @override
  _TaskListWidgetState createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  final List<String> _tasks = [];
  late int _count; // количество баллов
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            hintText: 'Enter task',
          ),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _tasks.add(_controller.text);
              _controller.clear();
            });
          },
          child: Text('Add Task'),
        ),
        SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          itemCount: _tasks.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(_tasks[index]),
              leading: IconButton(
                onPressed: () {
                  setState(() {
                    for (int i = 0; i < _tasks.length; i++) {
                      print(_tasks[i]);
                      _tasks[i] = "";
                      _tasks.remove(_controller.text);
                      _controller.clear();
                    }
                  });
                },
                icon: Icon(Icons.delete),
              ),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    _count += 1;
                    // _changeData();
                    /*
                    for (int i = 0; i < _tasks.length; i++) {
                      print(_tasks[i]);
                      //_tasks[i] = "";
                      _tasks.insert(i, _controller.text);
                      _controller.clear();
                    } */

                  });
                },
                icon: Icon(Icons.edit),
              ),
            );
          },
        ),
      ],
    );
  }
}
/*
class MyBottomNavigationBar extends StatefulWidget {
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue,
      onTap: _onItemTapped,
    );
  }
}

 */

/*
  TODO:
  функция, которая удаляет задачу
 */
