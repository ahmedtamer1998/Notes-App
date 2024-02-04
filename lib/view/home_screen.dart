import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note_app/db_handler.dart';
import 'package:note_app/model/model.dart';
import 'package:note_app/view/add_update_screen.dart';
import 'package:note_app/view/welcome_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DBHelper? dbHelper;
  late Future<List<TodoModel>> dataList;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    loadData();
  }

  loadData() async {
    dataList = dbHelper!.getDataList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Note Ease",
          style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
              color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => WelcomeScreen()));
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.help_outline_rounded,
                  size: 30, color: Colors.white),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: dataList,
              builder: (context, AsyncSnapshot<List<TodoModel>> snapshot) {
                if (!snapshot.hasData || snapshot.data == null) {
                  return Center(
                  child: CircularProgressIndicator(),
                );
                } else if (snapshot.data!.length == 0) {
                  return Center(
                    child: Text("No Tasks Found",style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ));
                } else {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Text('Swipe To Left To remove Note'),
                        SizedBox(
                          height: 10.h,
                        ),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            int todoId = snapshot.data![index].id!.toInt();
                            String todoTitle =
                                snapshot.data![index].title.toString();
                            String todoDesc =
                                snapshot.data![index].desc.toString();
                            String todoDT =
                                snapshot.data![index].dateAndTime.toString();
                            return Dismissible(
                              key: ValueKey<int>(todoId),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                  color: Colors.redAccent,
                                  child: Icon(
                                    Icons.delete_forever,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                ),
                              onDismissed: (DismissDirection direction) {
                                setState(() {
                                    dbHelper!.delete(todoId);
                                    dataList = dbHelper!.getDataList();
                                    snapshot.data!
                                        .remove(snapshot.data![index]);
                                  });
                                },
                              child: Container(
                                  margin: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.yellow.shade300,
                                      borderRadius: BorderRadius.circular(10.r),
                                      border: Border.all(
                                          color: Colors.black12, width: 2.w),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 4,
                                          spreadRadius: 1,
                                        )
                                      ]),
                                  child: Column(children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddUpdateTask(
                                                      todoId: todoId,
                                                      todoTitle: todoTitle,
                                                      todoDesc: todoDesc,
                                                      todoDT: todoDT,
                                                      update: true,
                                                    )));
                                      },
                                      child: ListTile(
                                        contentPadding: EdgeInsets.all(16),
                                        title: Padding(
                                          padding: EdgeInsets.only(bottom: 10),
                                          child: Text(
                                            todoTitle,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 19.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        subtitle: Text(
                                          todoDesc,
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            color: Colors.black,
                                          ),
                                        ),
                                        trailing: IconButton(
                                            icon: Icon(
                                              snapshot.data![index].isDone? Icons.check_box
                                                  : Icons.check_box_outline_blank,
                                              size: 28,
                                              color: Colors.green,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                snapshot.data![index].isDone = !snapshot.data![index].isDone;
                                                dbHelper!.update(snapshot.data![index]);
                                              });
                                            }),
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.black,
                                      thickness: 0.8,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            todoDT,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                                fontStyle: FontStyle.italic),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AddUpdateTask(
                                                            todoId: todoId,
                                                            todoTitle:
                                                                todoTitle,
                                                            todoDesc: todoDesc,
                                                            todoDT: todoDT,
                                                            update: true,
                                                          )));
                                            },
                                            child: Icon(
                                              Icons.edit_note,
                                              size: 28,
                                              color: Colors.green,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ]),
                                ));
                          }),
                    ],
                  ),
                );
                }
            },
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFFFEB3D),
        child: FaIcon(
          FontAwesomeIcons.plus,
          color: Colors.black,
          size: 18,
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddUpdateTask()));
        },
      ),
    );
  }
}
