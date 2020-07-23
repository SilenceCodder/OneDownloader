import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:onedownloader/model/Data.dart';
import 'package:onedownloader/model/advertSliderModel.dart';
import 'package:onedownloader/Styles/AppColor.dart';
import 'package:onedownloader/Styles/AppImage.dart';
import 'package:onedownloader/locator.dart';
import 'package:onedownloader/utils/customFunction.dart';

class SliderImage extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;
  final Future<AdvertSliderModel> futueAdverImage;
  const SliderImage(
      {Key key, this.animationController, this.animation, this.futueAdverImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AdvertSliderModel>(
        future: futueAdverImage,
        builder: (BuildContext context, advertSnapshot) {
          if (advertSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (advertSnapshot.hasError) {
            final error = advertSnapshot.error;
            return Center(child: Text(error.toString()));
          } else if (advertSnapshot.hasData) {
            return data(advertSnapshot);
          }
          return data(advertSnapshot);
        });
  }

  data(AsyncSnapshot<AdvertSliderModel> advertSnapshot) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
              transform: new Matrix4.translationValues(
                  0.0, 30 * (1.0 - animation.value), 0.0),
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
                            sliderModel: advertSnapshot.data.data,
                            index: index,
                          ),
                          onTap: () {},
                        );
                      },
                      itemCount: advertSnapshot.data.data.length,
                      pagination: new SwiperPagination(),
                    ),
                  ))),
        );
      },
    );
  }
}

class TopSwiperWidget extends StatelessWidget {
  final List<Data> sliderModel;
  final int index;
  final CustomFunction _customFunction = locator<CustomFunction>();

  TopSwiperWidget({
    Key key,
    this.sliderModel,
    this.index,
  })  : assert(sliderModel != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: FadeInImage.assetNetwork(
        placeholder: AppImage.imageloadingGif,
        image: sliderModel[index].image,
        height: MediaQuery.of(context).size.height,
        fit: BoxFit.fill,
        width: MediaQuery.of(context).size.width,
      ),
      onTap: () {
        _customFunction.launchURL(sliderModel[index].location);
      },
    );
  }
}
