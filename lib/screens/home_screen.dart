import 'package:flutter/material.dart';
import 'package:registrationapp/customs/text_custom.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../customs/custom_colors.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: TextCustom(
         text:  "Students",color: white,textSize: 18.sp,
        ),
        backgroundColor: black,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                // setState(() {
                //   isPress = !isPress;
                // });
              },
              icon:
              // isPress
              //     ? Icon(
              //   Icons.grid_4x4_outlined,
              //   color: white,
              // )
              //     :
              Icon(Icons.list_alt_outlined, color: white)),
          IconButton(
            onPressed: () async {
              // logout(context);
            },
            icon: Icon(Icons.logout, color: white),
          ),
        ],
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: TextField(
                  // controller: textControl,
                  onChanged: (value) {
                    // filterSearch(value);
                  },
                  style: TextStyle(color: white),
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 2,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: white,
                    ),
                  ),
                ),
              ),
            )),
      ),
      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Image.asset(
                "assets/images/background.jpeg",
                fit: BoxFit.fill,
              )),
          SizedBox(
            width: MediaQuery.of(context).size.width,
          ),
          // isPress
          //     ? filteredList.isEmpty
          //     ? Center(
          //     child: TextCustom(
          //       text: "Student Not found",
          //       color: black,
          //     ))
          //     : Center(child: getUsersList())
          //     : filteredList.isEmpty
          //     ? Center(
          //     child:
          //     TextCustom(text: "Student Not found", color: black))
          //     : Center(child: getUserWrapView())
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: black,
        foregroundColor: white,
        onPressed: () {
          // Navigator.push(context, MaterialPageRoute(builder: (ctx) {
          //   return UserDetailsEdit(
          //     "Add Student",
          //     documentSnapshot: null,
          //   );
          // }));
        },
        tooltip: 'Add Student',
        child: const Icon(Icons.add),
      ),

    );
  }
}
