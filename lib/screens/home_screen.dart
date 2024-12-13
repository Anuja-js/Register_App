import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:registrationapp/controllers/home_controller.dart';
import 'package:registrationapp/customs/constants.dart';
import 'package:registrationapp/customs/text_custom.dart';
import 'package:registrationapp/models/user.dart';
import 'package:registrationapp/screens/user_detail.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();

    return Scaffold(
      appBar: AppBar(
        title: TextCustom(
          text: "Students",
          textSize: 15.sp,
          color: white,
        ),
        backgroundColor: black,
        actions: [
          Obx(() => IconButton(
                onPressed: homeController.toggleViewMode,
                icon: Icon(
                  homeController.isGridView.value
                      ? Icons.grid_4x4_outlined
                      : Icons.list_alt_outlined,
                  color: white,
                ),
              )),
          IconButton(
            onPressed: () => homeController.logout(context),
            icon: const Icon(Icons.logout, color: white),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: TextField(
              controller: homeController.searchController,
              onChanged: homeController.filterUserList,
              style: const TextStyle(color: white),
              decoration: InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: grey, width: 2.w),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: grey,
                    width: 2.w,
                  ),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: white,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Obx(() => Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  "assets/images/background.jpeg",
                  fit: BoxFit.fill,
                ),
              ),
              homeController.userList.isEmpty
                  ? const Center(
                      child: Text(
                        "NO STUDENTS AVAILABLE",
                        style: TextStyle(color: black),
                      ),
                    )
                  : homeController.isGridView.value
                      ? getUsersListView(homeController)
                      : getUserGridView(homeController),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: black,
        foregroundColor: white,
        onPressed: () => homeController.navigateToDetail(
            User('', '', null, null, '', null), 'Add Student'),
        tooltip: 'Add Student',
        child: const Icon(Icons.add),
      ),
    );
  }
  ListView getUsersListView(HomeController controller) {
    return ListView.builder(
      itemCount: controller.userList.length,
      itemBuilder: (context, index) {
        final user = controller.userList[index];
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 15.w),
          child: Card(
            color: Colors.transparent,
            elevation: 2.0,
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              leading: CircleAvatar(
                backgroundColor: black,
                radius: 25.r,
                child: user.imagePath != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(25.r),
                        child: Image.file(
                          File(user.imagePath!),
                          fit: BoxFit.fill,
                        ),
                      )
                    : const Icon(Icons.person, color: white),
              ),
              title:
                  Text(user.name ?? '', style: const TextStyle(color: black)),
              subtitle: Text(user.qualification ?? ''),
              trailing: buildActionButtons(context, controller, user),
              onTap: () => Get.to(() => UserDetails(user)),
            ),
          ),
        );
      },
    );
  }
  GridView getUserGridView(HomeController controller) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: controller.userList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        final user = controller.userList[index];
        return InkWell(
          onTap: () => Get.to(() => UserDetails(user)),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            color: Colors.transparent,
            elevation: 2.0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: black,
                    radius: 35.r,
                    child: user.imagePath != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(35.r),
                            child: Image.file(
                              File(user.imagePath!),
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(Icons.person, color: white),
                  ),
                  SizedBox(height: 10.h),
                  Text(user.name ?? '',
                      style: TextStyle(color: black, fontSize: 18.sp)),
                  Text(user.qualification ?? '',
                      style: TextStyle(color: black54, fontSize: 15.sp)),
                  const Spacer(),
                  buildActionButtons(context, controller, user),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Row buildActionButtons(
      BuildContext context, HomeController controller, User user) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.edit, color: black54),
          onPressed: () =>
              controller.navigateToDetail(user, user.name.toString()),
        ),
        IconButton(
          icon: const Icon(Icons.delete, color: black54),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Delete...?"),
                  content: Text("Are you sure? ${user.name} will be deleted?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        controller.deleteUser(user.id!);
                        Get.back();
                      },
                      child: const Text("Delete"),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}
