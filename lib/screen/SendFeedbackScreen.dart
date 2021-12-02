import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:onedownloader/locator.dart';
import 'package:onedownloader/styles/AppColor.dart';
import 'package:onedownloader/styles/AppText.dart';
import 'package:onedownloader/styles/AppTextStyle.dart';
import 'package:onedownloader/utils/customFunction.dart';
import 'package:onedownloader/viewmodel/SendFeedbackViewModel.dart';
import 'package:random_string/random_string.dart';
import 'package:stacked/stacked.dart';

class SendFeedbackScreen extends StatefulWidget {
  @override
  _SendFeedbackScreenState createState() => _SendFeedbackScreenState();
}

class _SendFeedbackScreenState extends State<SendFeedbackScreen> {

  final CustomFunction _developerFunction = locator<CustomFunction>();
   TextEditingController emailController, messageController, titleController;
   String type;
  String id;

@override
  void initState() {
    super.initState();
     //SystemChrome.setEnabledSystemUIOverlays ([]); //Enable Full Screen
      emailController = TextEditingController(); //for Username input
      messageController = TextEditingController();
      titleController = TextEditingController();
    id  = randomString(2);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 1080, height: 2160, allowFontScaling: false);
    return ViewModelBuilder<SendFeedbackViewModel>.reactive(
      viewModelBuilder: () => SendFeedbackViewModel(),
       builder: (context, model, child) =>
    Scaffold(
      appBar: AppBar(
        title: Text('Send Feedback', style: AppTextStyle.lHeader(context, AppColor.b1),),
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
        leading: GestureDetector(child: Icon(Icons.arrow_back, color: AppColor.white, size: 30,),
        onTap: (){
          Navigator.pop(context);
        },)
      ),
       body: SingleChildScrollView(
                child: Padding(
           padding: const EdgeInsets.only(right: 16.0, left: 16.0),
           child: Column(
             children: <Widget>[
               Padding(
                             padding: const EdgeInsets.only(top: 13.0, right: 10, left: 10.0),
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: <Widget>[
                               Row(
                               children: <Widget>[
                                  Text('Let Hear From You', style: AppTextStyle.lHeader(context, AppColor.b1),),
                             ],),
                              SizedBox(
                        height: ScreenUtil().setHeight(20),
                      ),

                             Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                               children: <Widget>[
                                Text(AppText.des,
                                 style: AppTextStyle.test(context, AppColor.primaryColor),), //AppTextStyle.sub(context, AppColor.black)
                             ],),

                             ],)
                           ),

                             SizedBox(
                        height: ScreenUtil().setHeight(100),
                      ),
                            Padding(
                 padding: const EdgeInsets.only(right: 10, left: 10.0),
                 child: TextField(
                                    cursorRadius: Radius.elliptical(30, 30),
                                   style: AppTextStyle.inputText(context),
                                   controller: titleController,
                                          decoration:  InputDecoration(
                                            hintText: 'Title',
                                        enabledBorder: new OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                        borderSide: new BorderSide(color: AppColor.primaryColor,
                                        ),
                                    ),
                              border: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: new BorderSide(color: AppColor.primaryColor
                                  ),

                            ),
                              hintStyle: AppTextStyle.subHeader2(context, Colors.grey),
                              prefixIcon: Icon(Icons.hearing, color: Colors.grey, size: 16.0,)
                              
                            ),
                                ),
               ),
                            SizedBox(
                        height: ScreenUtil().setHeight(100),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(right: 10, left: 10.0),
                        child: Container(
                           height: 40,
                           width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          //color: AppColor.borderColor,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
            topLeft:  const  Radius.circular(0.0),
            topRight: const  Radius.circular(30.0),
            bottomLeft:const  Radius.circular(0.0),
            bottomRight: const  Radius.circular(30.0),
                    ),
                                      color: AppColor.white,
                                      border: Border.all(
                                          style: BorderStyle.solid, 
                                          width: 0.80, color: AppColor.primaryDark),
                                    ),
                          child:  DropdownButton<String>(
                           isExpanded: true,
                           underline: SizedBox(),
                          hint: Text('Feedback Type', 
                           style: AppTextStyle.subHeader2(context, Colors.grey),),
                           value: type,
        items: <String>['Bugs', 'Improvement', 'Ideas', 'Testimony', 'Others'].map((String value) {
          return  DropdownMenuItem<String>(
            value: value,
            child: Text(value.toString(), style: AppTextStyle.inputText(context),),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            type = value;
            });
        },
      ),
                        ),
                      ),
               
                    SizedBox(
                        height: ScreenUtil().setHeight(100),
                      ),
                       Padding(
                 padding: const EdgeInsets.only(right: 10, left: 10.0),
                 child: TextField(
                                    cursorRadius: Radius.elliptical(30, 30),
                                   style: AppTextStyle.inputText(context),
                                   controller: emailController,
                                          decoration:  InputDecoration(
                                            hintText: 'Your Email Address',
                                        enabledBorder: new OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                        borderSide: new BorderSide(color: AppColor.primaryColor,
                                        ),
                                    ),
                              border: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: new BorderSide(color: AppColor.primaryColor
                                  ),

                            ),
                              hintStyle: AppTextStyle.subHeader2(context, Colors.grey),
                              prefixIcon: Icon(Icons.email, color: Colors.grey, size: 16.0,)
                              
                            ),
                                ),
               ),
              
                SizedBox(
                        height: ScreenUtil().setHeight(80),
                      ),

                        Padding(
                 padding: const EdgeInsets.only(right: 10, left: 10.0),
                 child: TextField(
                                    cursorRadius: Radius.elliptical(30, 30),
                                   style: AppTextStyle.inputText(context),
                                   controller: messageController,
                                   maxLines: 5,
                                          decoration:  InputDecoration(
                                            hintText: 'Your Message',
                                        enabledBorder: new OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                        borderSide: new BorderSide(color: AppColor.primaryColor,
                                        ),
                                    ),
                              border: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: new BorderSide(color: AppColor.primaryColor
                                  ),

                            ),
                              hintStyle: AppTextStyle.subHeader2(context, Colors.grey),
                             // prefixIcon: Icon(Icons.message, color: Colors.grey, size: 16.0,)
                              
                            ),
                                ),
               ),

                  SizedBox(
                        height: ScreenUtil().setHeight(100),
                      ),
                      

                        //*****ERROR MESSAGE */
  _developerFunction.errorUimessage(errorMessage: model.displayMessage, type: model.displayMessageType, context: context),
    model.isBusy? _developerFunction.loader() : button(model, context)
             ],
           ),
         ),
       ),
        ),
    
    );
  }

  button(SendFeedbackViewModel model, BuildContext context){
   return  GestureDetector(
                      onTap: () {
                       //SEND DATA TO VM
                       
                       model.sendData(
                        id: id,
                        body: messageController.text,
                        email: emailController.text,
                        title: titleController.text,
                      subject: type);

                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0, left: 10.0 ),
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          height: ScreenUtil().setHeight(120),
                          margin: EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                              color: Color(0xFFF1F3F6),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(10, 10),
                                    color: Color(0xFF4D70A6).withOpacity(0.2),
                                    blurRadius: 16),
                                BoxShadow(
                                    offset: Offset(-10, -10),
                                    color: Color.fromARGB(170, 255, 255, 255),
                                    blurRadius: 10),
                              ]),
                          child: Text(
                            "Send",
                            style: AppTextStyle.header4(context, AppColor.primaryColor
                          ),
                        ),
                      ),
                    )
   );
  }

}