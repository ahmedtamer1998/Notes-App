import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_app/db_handler.dart';
import 'package:note_app/model/model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_app/view/home_screen.dart';

class AddUpdateTask extends StatefulWidget {
  final int? todoId;
  final String? todoTitle;
  final String? todoDesc;
  final String? todoDT;
  final bool? update;
  
  AddUpdateTask(
      {super.key,
      this.todoId,
      this.todoTitle,
      this.todoDesc,
      this.todoDT,
      this.update,});

  @override
  State<AddUpdateTask> createState() => _AddUpdateTaskState();
}

class _AddUpdateTaskState extends State<AddUpdateTask> {
  DBHelper? dbHelper;
  late Future<List<TodoModel>> dataList;
  final _fromKey = GlobalKey<FormState>();

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
    final titleController = TextEditingController(text: widget.todoTitle);
    final descController = TextEditingController(text: widget.todoDesc);
    String appTitle;

    if (widget.update == true) {
      appTitle = "Update Note ";
    } else {
      appTitle = "Add Note";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appTitle,
          style: TextStyle(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 2),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 80),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Form(
              key: _fromKey,
              child: Column(
                children: [
                  // widget.update == true
                  //     ? SizedBox()
                  //     : Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 20),
                  //   child: FastDropdown(
                  //     name: 'dropdown',
                  //     items: [
                  //       'Low',
                  //       'High',
                  //       'Very High'
                  //     ],
                  //     initialValue: 'Low',
                  //     onChanged: (value) {},
                  //     decoration: InputDecoration(
                  //       labelText: 'Importance',
                  //       labelStyle:
                  //           TextStyle(color: Colors.white, fontSize: 16.sp),
                  //       border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(10.r),
                  //           borderSide:
                  //               BorderSide(width: 2, color: Colors.black)),
                  //     ),
                  //   ),  
                  //   ),
                  // SizedBox(
                  //   height: 10.h,
                  // ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 16.sp),
                        hintText: 'Note Title',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide:
                                BorderSide(width: 2, color: Colors.black)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Note Title";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      minLines: 5,
                      controller: descController,
                      decoration: InputDecoration(
                        hintText: 'Write Your Note Here',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide:
                                BorderSide(width: 2, color: Colors.black)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Note Description";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Material(
                    color: Colors.green[400],
                    borderRadius: BorderRadius.circular(10.r),
                    child: InkWell(
                      onTap: () {
                        if (_fromKey.currentState!.validate()) {
                          if (widget.update == true) {
                            dbHelper!.update(TodoModel(
                                id: widget.todoId,
                                title: titleController.text,
                                desc: descController.text,
                                dateAndTime: DateFormat('yMd')
                                    .add_jm()
                                    .format(DateTime.now())
                                    .toString(),));
                          } else {
                            dbHelper!.insert(TodoModel(
                                title: titleController.text,
                                desc: descController.text,
                                dateAndTime: DateFormat('yMd')
                                    .add_jm()
                                    .format(DateTime.now())
                                    .toString(),));
                          }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                          titleController.clear();
                          descController.clear();
                          print("Data added");
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 45.h,
                        width: 100.w,
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.red[400],
                    borderRadius: BorderRadius.circular(10.r),
                    child: widget.update == true
                        ? SizedBox()
                        : InkWell(
                            onTap: () {
                              setState(() {
                                titleController.clear();
                                descController.clear();
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              height: 45.h,
                              width: 100.w,
                              child: Text(
                                'Clear',
                                style: TextStyle(
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
