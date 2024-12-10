import 'package:flutter/material.dart';
import 'package:registrationapp/controllers/grid_controller.dart';
import 'package:registrationapp/customs/text_custom.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:registrationapp/providers/logout_provider.dart';
import 'package:registrationapp/screens/details_page.dart';
import 'package:registrationapp/screens/edit_user_page.dart';
import '../customs/custom_colors.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import '../providers/search__and_users_list_provider.dart';
class HomeScreen extends StatefulWidget {

  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GridController controllerPress=Get.put(GridController()); // Di

  @override
  void initState() {
    context.read<SearchProvider>().fetchStudents();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);
    final logoutProvider = Provider.of<LogOutProvider>(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: TextCustom(
         text:  "Students",color: white,textSize: 18.sp,
        ),
        backgroundColor: black,
        elevation: 0,
        actions: [
      Obx(()=>   IconButton(
              onPressed: () {
             controllerPress.pressController();
              },
              icon:
              controllerPress.isPress.value
                  ?
              const Icon(Icons.list_alt_outlined, color: white):const Icon(
      Icons.grid_4x4_outlined,
      color: white,
    )),),
          IconButton(
            onPressed: () async {
       logoutProvider.logout(context);
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
                  controller: searchProvider.searchController,
                  onChanged: (value) {
                    searchProvider.filterSearch(value);
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
          Obx(() => controllerPress.isPress.value
              ? (searchProvider.filteredList.isEmpty
              ? Center(
            child: TextCustom(
              text: "Student Not found",
              color: black,
            ),
          )
              : Center(child: getUsersList(searchProvider)))
              : Center(child: getUserWrapView(searchProvider))),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: black,
        foregroundColor: white,
        onPressed: () {
          Get.to( UserDetailsEdit(
            documentSnapshot: null, appBarTitle: "Add Student",
          ));
        },
        tooltip: 'Add Student',
        child: const Icon(Icons.add),
      ),

    );
  }
  // Show users as a list view
  Widget getUsersList(SearchProvider searchProvider) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 600),
      child: ListView.builder(
        physics: const ScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: searchProvider.filteredList.length, // Use filteredList
        itemBuilder: (BuildContext context, int position) {
          final documentSnapshot = searchProvider.filteredList[position];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Colors.transparent,
            elevation: 2.0,
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 7,
              child: InkWell(
                onTap: () {
                  Get.to(UserDetails(searchProvider.userList[position] ,));
                },
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        documentSnapshot["image"] != ""
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            documentSnapshot["image"],
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context,
                                Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress
                                      .expectedTotalBytes !=
                                      null
                                      ? loadingProgress
                                      .cumulativeBytesLoaded /
                                      (loadingProgress
                                          .expectedTotalBytes ??
                                          1)
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (BuildContext context,
                                Object exception,
                                StackTrace? stackTrace) {
                              return Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.error,
                                      color: Colors.red, size: 20),
                                  sh10,
                                  TextCustom(
                                      text: 'Failed load', color: black),
                                ],
                              );
                            },
                          ),
                        )
                            : const CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.person), // Placeholder icon
                        ),
                        sw10,
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextCustom(
                                  text: documentSnapshot["studentName"],
                                  color: black),
                              TextCustom(
                                text: documentSnapshot["studyProgram"],
                                color: Colors.black87,
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GestureDetector(
                                onTap: () async{
                                 Get.to(UserDetailsEdit(documentSnapshot:documentSnapshot,
                                   appBarTitle: documentSnapshot["studentName"],));
                                  },
                                child: const Icon(Icons.edit,
                                    color: Colors.black54)),
                            sh20,
                            GestureDetector(
                                onTap: () {
                                  searchProvider.showDeleteDialog(context, documentSnapshot);
                                },
                                child: const Icon(Icons.delete,
                                    color: Colors.black54)),
                          ],
                        )
                      ]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  // Show users as a wrap layout
  Widget getUserWrapView(SearchProvider searchProvider) {
    return GridView.builder(padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        physics: const ScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: searchProvider.filteredList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (BuildContext context, int position) {
          final documentSnapshot = searchProvider.filteredList[position];

          return InkWell(
            onTap:() {
              Get.to(UserDetails(searchProvider.userList[position] ,));
            },

            child: Card(shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              color: Colors.transparent,
              elevation: 2.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    documentSnapshot["image"] != ""
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        documentSnapshot["image"],
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context,
                            Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress
                                  .expectedTotalBytes !=
                                  null
                                  ? loadingProgress
                                  .cumulativeBytesLoaded /
                                  (loadingProgress
                                      .expectedTotalBytes ??
                                      1)
                                  : null,
                            ),
                          );
                        },
                        errorBuilder: (BuildContext context,
                            Object exception,
                            StackTrace? stackTrace) {
                          return Column(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.error,
                                  color: Colors.red, size: 20),
                              sh10,
                              TextCustom(
                                  text: 'Failed load', color: black),
                            ],
                          );
                        },
                      ),
                    )
                        : const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.person), // Placeholder icon
                    ),
                    const SizedBox(height: 20,),
                    Text(
                      documentSnapshot["studentName"],
                      style: const TextStyle(color: Colors.black,fontSize: 18),
                    ),
                    const SizedBox(height: 20,),
                    Text(
                      documentSnapshot["studyProgram"],
                      style: const TextStyle(color: Colors.black54,fontSize: 15),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.black54),
                          onPressed: () {
                           Get.to( UserDetailsEdit(documentSnapshot:documentSnapshot,  appBarTitle: documentSnapshot["studentName"],),
                           );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.black54),
                          onPressed: () {
                            searchProvider.showDeleteDialog(context, documentSnapshot);
                            },
                        ),
                      ],)
                  ],
                ),
              ),

            ),

          );
        });
  }


}
