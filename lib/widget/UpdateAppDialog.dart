import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onedownloader/Styles/AppColor.dart';
import 'package:onedownloader/Styles/AppTextStyle.dart';
import 'package:onedownloader/viewmodel/DialogVieModel.dart';
import 'package:provider_architecture/provider_architecture.dart';

class UpdateAppDialog extends StatefulWidget {
  final String title, subtitile, buttonText;
  Color color;
  UpdateAppDialog({this.title, this.subtitile, this.buttonText, this.color});

  @override
  _UpdateAppDialogState createState() => _UpdateAppDialogState();
}

class _UpdateAppDialogState extends State<UpdateAppDialog> {
  static const double padding = 16.0;
  static const double avatarRadius = 66.0;

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<DialogVieModel>.withConsumer(
        viewModelBuilder: () => DialogVieModel(),
        builder: (context, model, child) => Center(
              child: Dialog(
                elevation: 0,
                backgroundColor: Colors.transparent,
                child: Container(
                  margin: EdgeInsets.only(top: 10.0),
                  height: MediaQuery.of(context).size.height / 2,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          top: 41,
                          bottom: padding,
                          left: padding,
                          right: padding,
                        ),
                        margin: EdgeInsets.only(top: avatarRadius),
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(padding),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10.0,
                              offset: const Offset(0.0, 10.0),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              widget.title,
                              style: AppTextStyle.inputTextIncrease(context),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16.0),
                            RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: widget.subtitile,
                                    style: AppTextStyle.sellheader(
                                        context, Colors.black)),
                              ]),
                            ),
                            SizedBox(height: 18.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                //   FlatButton(
                                //   color: widget.color,
                                //   onPressed: () {
                                //     Navigator.of(context).pop();// To close the dialog
                                //   },
                                //   child: Text('Cancel', style: AppTextStyle.sub(context, Colors.white) ,),
                                // ),

                                FlatButton(
                                  color: widget.color,
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // To close the dialog
                                    model.updateApp();
                                  },
                                  child: Text(
                                    widget.buttonText,
                                    style:
                                        AppTextStyle.sub(context, Colors.white),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Material(
                            elevation: 5.0,
                            shape: CircleBorder(),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Container(
                                height: 110,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: widget.color,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.system_update,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
