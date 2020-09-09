import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:onedownloader/constants.dart';
import 'package:onedownloader/model/Data.dart';
import 'package:onedownloader/model/LocalAdvert.dart';
import 'package:onedownloader/model/advertSliderModel.dart';
import 'package:onedownloader/Styles/AppColor.dart';
import 'package:onedownloader/Styles/AppImage.dart';
import 'package:onedownloader/locator.dart';
import 'package:onedownloader/utils/customFunction.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SliderImage extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;
  final Future<AdvertSliderModel> futueAdverImage;
  const SliderImage(
      {Key key, this.animationController, this.animation, this.futueAdverImage})
      : super(key: key);

  @override
  _SliderImageState createState() => _SliderImageState();
}

class _SliderImageState extends State<SliderImage> {
String advertStatus;

  //  @override
  // void initState() {
  //     getStatus();
  // }

  

  @override
  Widget build(BuildContext context) {
   // if(widget.futueAdverImage == null){
return localData();
    // }else{
    // return FutureBuilder<AdvertSliderModel>(
    //     future: widget.futueAdverImage,
    //     builder: (BuildContext context, advertSnapshot) {
    //       if (advertSnapshot.connectionState == ConnectionState.waiting) {
    //         return Center(child: CircularProgressIndicator());
    //       } else if (advertSnapshot.hasError) {
    //         final error = advertSnapshot.error;
    //         return Center(child: Text(error.toString()));
    //       } else if (advertSnapshot.hasData) {
    //         return data(advertSnapshot);
    //       }
    //       return data(advertSnapshot);
    //     });
    //     }
  }

  // data(AsyncSnapshot<AdvertSliderModel> advertSnapshot) {
  //   return AnimatedBuilder(
  //     animation: widget.animationController,
  //     builder: (BuildContext context, Widget child) {
  //       return FadeTransition(
  //         opacity: widget.animation,
  //         child: new Transform(
  //             transform: new Matrix4.translationValues(
  //                 0.0, 30 * (1.0 - widget.animation.value), 0.0),
  //             child: Padding(
  //                 padding: const EdgeInsets.all(10.0),
  //                 child: Container(
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.all(Radius.circular(15.0)),
  //                     color: AppColor.rimary,
  //                   ),
  //                   height: 150.0,
  //                   child: Swiper(
  //                     autoplay: true,
  //                     itemBuilder: (BuildContext context, int index) {
  //                       return GestureDetector(
  //                         child: TopSwiperWidget(
  //                           sliderModel: advertSnapshot.data.shops,
  //                           index: index,
  //                         ),
  //                         onTap: () {},
  //                       );
  //                     },
  //                     itemCount: advertSnapshot.data.shops.length,
  //                     pagination: new SwiperPagination(),
  //                   ),
  //                 ))),
  //       );
  //     },
  //   );
  // }

 localData() {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.animation,
          child: new Transform(
              transform: new Matrix4.translationValues(
                  0.0, 30 * (1.0 - widget.animation.value), 0.0),
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      color: AppColor.rimary,
                    ),
                    height: 150.0,
                    child: Swiper(
                      autoplay: true,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          child: TopSwiperWidget(
                           // sliderModel: null,
                            sliderModelLocal: getLocalAdvertList(),
                            index: index,
                          ),
                          onTap: () {},
                        );
                      },
                      itemCount: getLocalAdvertList().length,
                      pagination: new SwiperPagination(),
                    ),
                  ))),
        );
      },
    );
    }
}

class TopSwiperWidget extends StatelessWidget {
  //final List<Shops> sliderModel;
  final List<LocalAdvert> sliderModelLocal;
  final int index;
  final CustomFunction _customFunction = locator<CustomFunction>();

  TopSwiperWidget({
    Key key,
    //this.sliderModel,
    this.sliderModelLocal,
    this.index,
  })  : assert(sliderModelLocal != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    //if(sliderModel == null){
      //LOCALLY
      return GestureDetector(
      child: Image.asset(
         sliderModelLocal[index].image,
        height: MediaQuery.of(context).size.height,
        fit: BoxFit.fill,
        width: MediaQuery.of(context).size.width,
      ),
      onTap: () {
        _customFunction.launchURL(sliderModelLocal[index].location);
      },
    );

    // }else{
    //   //SERVER
    //   return GestureDetector(
    //   child: FadeInImage.assetNetwork(
    //     placeholder: AppImage.imageloadingGif,
    //     image: sliderModel[index].image,
    //     height: MediaQuery.of(context).size.height,
    //     fit: BoxFit.fill,
    //     width: MediaQuery.of(context).size.width,
    //   ),
    //   onTap: () {
    //     _customFunction.launchURL(sliderModel[index].location);
    //   },
    // );

    // }
    
  }
}
