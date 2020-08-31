import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onedownloader/screen/whatsapp/Tabs/PicturesTab.dart';
import 'package:onedownloader/screen/whatsapp/Tabs/VideoTab.dart';
import 'package:onedownloader/styles/AppColor.dart';
import 'package:onedownloader/styles/AppFontSizes.dart';
import 'package:onedownloader/styles/AppText.dart';
import 'package:onedownloader/viewmodel/ShowsScreenViewModel.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'dart:io';

class ShowsScreen extends StatefulWidget {
  final String title, path;

  ShowsScreen({this.title, this.path});

  @override
  _ShowsScreenState createState() => _ShowsScreenState();
}
//final String whatsappImage = 'WhatsAppImages';

class _ShowsScreenState extends State<ShowsScreen> {
  //  final NavigationService _navigationService = locator<NavigationService>();
   
  final Directory _photoDir = Directory(AppText.whatsAppPath);

@override
  void initState() {
    super.initState();
    sendUssdRequest();
  }

   @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ShowsScreenViewModel>.reactive(
      viewModelBuilder: () => ShowsScreenViewModel(),
      builder: (context, model, child) => DefaultTabController(
        length: 2,
              child: Scaffold(
          appBar: PreferredSize(
               preferredSize: Size.fromHeight(100.0),  
               child: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                centerTitle: true,
                leading: GestureDetector(
                  child: Icon(Icons.arrow_back, size: 30, color: Colors.grey,),
                  onTap: (){
                     Navigator.pop(context);
                  },
                ),
                actions: <Widget>[
                  GestureDetector(
                      child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(FontAwesomeIcons.dev, size: 30, color:  AppColor.primaryLight,),
                    ),
                    onTap: (){
              //_navigationService.navigateTo(settingRoute);
                    },
                  )
                ],
                title:  Text(widget.title, 
                style:  TextStyle(
              color: AppColor.rimary,
              fontSize: AppFontSizes.large,
              fontWeight: FontWeight.bold
            )
          ),
                bottom: TabBar(
                    unselectedLabelColor: AppColor.primaryDark,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: AppColor.rimary,
                    indicatorWeight: 1.0,
                    indicator: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [AppColor.primaryLight, AppColor.primaryLight]),
                        borderRadius: BorderRadius.circular(1),
                        color: AppColor.assents),
                        indicatorColor: AppColor.primaryDark,
                    tabs: [
                      Container(
                        height: 30,
                        child: Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Image", style: TextStyle(fontSize: 13),),
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        child: Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Video",  style: TextStyle(fontSize: 13),),
                          ),
                        ),
                      ),
                    ]),
           
           
              ),
            ),
            body: TabBarView(children: [
                 Padding(
                   padding: const EdgeInsets.only(top: 1, ),
                   child: Column(children: <Widget>[
                     Expanded(child: Padding(
                       padding: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
                       child: PicturesTab(dir: _photoDir,),
                     ),
                     )
                   ],)
                 ),
Padding(
                   padding: const EdgeInsets.only(top: 1, left: 5.0, right: 5.0),
                   child: Column(children: <Widget>[
                     Expanded(child: Padding(
                       padding: const EdgeInsets.only(top: 5.0, ),
                       child: VideoTab(dir: _photoDir,)
                     ),
                     )
                   ],)
                 ),
              ]),
        ),
      )
    );
  }

 Future<void> sendUssdRequest() async {
     var status = await Permission.storage.status;
                  if (!status.isGranted) {
                    await Permission.storage.request();
                  }
 }
}