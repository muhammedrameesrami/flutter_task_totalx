import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_totalx/Auth/authBlock/authk_bloc.dart';
import 'package:flutter_task_totalx/Core/Common/SnackBar/ShowSnackBar.dart';
import 'package:flutter_task_totalx/Home/HomeBlock/homek_bloc.dart';
import 'package:flutter_task_totalx/Home/storageBlock/storage_bloc.dart';
import 'package:flutter_task_totalx/userModel.dart';

import '../../Core/Common/assetsConstant/asstesConstants.dart';
import '../../Core/Common/globalVariable/GlobalVariable.dart';
import '../addhomeBlock/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      context.read<HomekBloc>().add(FetchUserData());
    });
  }

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Nilambur',
            style: TextStyle(fontSize: width * 0.04, color: Colors.white),
          ),
          leading: const Icon(
            Icons.location_pin,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.grey.shade200,
        body: BlocBuilder<HomekBloc, List<UserModel>>(
          builder: (context, state) {
            if (state.isEmpty) {
              return Center(
                child: Text('No data'),
              );
            }
            return Padding(
              padding: EdgeInsets.only(
                  left: width * 0.03, right: width * 0.03, top: width * 0.03),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: height * 0.06,
                          width: width * 0.8,
                          child: TextFormField(onChanged: (value) {
                            context.read<HomekBloc>().add(SearchUser(search: value));
                          },
                            controller: searchController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.search),
                              hintText: 'search by name',
                              hintStyle: TextStyle(
                                  fontSize: width * 0.035,
                                  color: Colors.grey.shade600),
                              // hintText: 'Enter Phone Number *',
                              // hintStyle: TextStyle(fontSize: width*0.035,color: Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(height * 0.3),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade100),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            sortingBox(context: context);
                          },
                          child: Container(
                            height: height * 0.05,
                            width: height * 0.05,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black),
                            child: Icon(
                              Icons.filter_list_sharp,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Text(
                      'Users List',
                      style: TextStyle(
                          fontSize: width * 0.04, color: Colors.grey.shade700),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: height,
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.length,
                          itemBuilder: (context, index) {
                            final user = state[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Container(
                                height: height * 0.1,
                                width: width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(6),
                                      child: user.image.isEmpty
                                          ? CircleAvatar(
                                              backgroundImage: AssetImage(
                                                  AssetsConstant.loginImage),
                                              radius: height * 0.05,
                                            )
                                          : CircleAvatar(
                                              backgroundImage:
                                                  NetworkImage(user.image),
                                              radius: height * 0.05,
                                            ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'User : ${user.name}',
                                          style: TextStyle(
                                              fontSize: width * 0.04,
                                              color: Colors.black),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Age: ${user.age}',
                                          style: TextStyle(
                                              fontSize: width * 0.035,
                                              color: Colors.grey.shade600),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
            );
          },
        ),
        floatingActionButton: InkWell(
          onTap: () {
            addNewUser(context: context);
          },
          child: CircleAvatar(
            radius: width * 0.085,
            backgroundColor: Colors.black,
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: width * 0.08,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addNewUser({required BuildContext context}) async {
    TextEditingController nameController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add A New User'),
        content: SizedBox(
          height: height * 0.3,
          width: width * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<StorageBloc, StorageState>(
                builder: (context, state) {
                  if (state is AuthkLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is StorageSuccess) {
                    return InkWell(
                      onTap: () {
                        context.read<StorageBloc>().add(AddDocStorage());
                      },
                      child: SizedBox(
                        height: height * 0.1,
                        width: width,
                        child: Image.network(state.url),
                      ),
                    );
                  }
                  return InkWell(
                    onTap: () {
                      context.read<StorageBloc>().add(AddDocStorage());
                    },
                    child: SizedBox(
                      height: height * 0.1,
                      width: width,
                      child: Image.asset(AssetsConstant.defaultAvatar),
                    ),
                  );
                },
              ),
              Text('Name'),
              SizedBox(
                height: height * 0.06,
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                      hintText: 'Name',
                      hintStyle: TextStyle(
                          fontSize: width * 0.035, color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey.shade100))),
                ),
              ),
              Text('Age'),
              SizedBox(
                height: height * 0.06,
                child: TextFormField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Age',
                      hintStyle: TextStyle(
                          fontSize: width * 0.035, color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey.shade100))),
                ),
              ),
            ],
          ),
        ),
        actions: [
          InkWell(
            onTap: () {

              Navigator.pop(context);

            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade200),
              height: height * 0.04,
              width: width * 0.25,
              child: Center(
                child: Text('Cancel'),
              ),
            ),
          ),
          BlocConsumer<HomeBloc, HomeState>(
            listener: (context, state) {
              if (state is HomeSuccess) {
                showSnackBar(message: 'add user Success', context: context);
                Navigator.pop(context);
              }

              if (state is HomeFailure) {
                showSnackBar(message: 'adding Failed', context: context);
              }


            },
            builder: (context, state) {
              if (state is HomeLoader) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return InkWell(
                onTap: () {
                  String img = "";
                  final storageState = context.read<StorageBloc>().state;
                  if (storageState is StorageSuccess) {
                    img = storageState.url;
                  }
                  final userModel = UserModel(
                      image: img,
                      age: int.tryParse(ageController.text.trim()) ?? 0,
                      name: nameController.text.trim(),
                      search: []);
                  context.read<HomeBloc>().add(AddUser(userModel: userModel));
                  context
                      .read<HomekBloc>()
                      .add(AddUserModel(userModel: userModel));
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blueAccent),
                  height: height * 0.04,
                  width: width * 0.25,
                  child: Center(
                    child: Text('Save'),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  void sortingBox({required BuildContext context}) {
    int sortingValue = 0;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Sort'),
        content: StatefulBuilder(
          builder: (context, setState) => SizedBox(
            height: height * 0.3,
            child: Column(
              children: [
                Row(
                  children: [
                    Radio(
                      value: 0,
                      groupValue: sortingValue,
                      onChanged: (value) {
                        setState(() {
                          sortingValue = value!;
                        });
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('All')
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 1,
                      groupValue: sortingValue,
                      onChanged: (value) {
                        context.read<HomekBloc>().add(SortUser('Elder'));
                        setState(() {
                          sortingValue = value!;
                        });
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Age: Elder')
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 2,
                      groupValue: sortingValue,
                      onChanged: (value) {
                        context.read<HomekBloc>().add(SortUser('Younger'));
                        setState(() {
                          sortingValue = value!;
                        });
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Age: Younger')
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
