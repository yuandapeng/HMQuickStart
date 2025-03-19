





@Entry
@Component
struct Index {
  @State message: string = '快速入门';


  build() {
    Column() {
      Text(this.message)
        .fontSize(24)
        .fontWeight(700)
        .width('100%')
        .textAlign(TextAlign.Start)
        .padding({ left: 16 })
        .fontFamily("HarmonyHeiTi-Bold")
        .lineHeight(33)

      Banner()
    }
    .height('100%')
    .width('100%')
    .backgroundColor('#F1F3F5')
  }
}


class BannerClass {
  /** 图片唯一标识 **/
  id: string = '';
  /** 图片资源路径 **/
  src: ResourceStr = '';
  /** 图片跳转链接 **/
  url: string = '';

  constructor(id: string, src: ResourceStr, url: string) {
    this.id = id;
    this.src= src;
    this.url = url;
  }
}


@Preview
@Component
struct Banner {
  @State bannerList: Array<BannerClass> = [
    new BannerClass('pic0', $r('app.media.banner_pic0'),
      'https://developer.huawei.com/consumer/cn/training/course/video/C101718352529709527'),
    new BannerClass('pic1', $r('app.media.banner_pic1'),
      'https://developer.huawei.com/consumer/cn/'),
    new BannerClass('pic2', $r('app.media.banner_pic2'),
      'https://developer.huawei.com/consumer/cn/deveco-studio/'),
    new BannerClass('pic3', $r('app.media.banner_pic3'),
      'https://developer.huawei.com/consumer/cn/arkts/'),
    new BannerClass('pic4', $r('app.media.banner_pic4'),
      'https://developer.huawei.com/consumer/cn/arkui/'),
    new BannerClass('pic5', $r('app.media.banner_pic5'),
      'https://developer.huawei.com/consumer/cn/sdk')
  ];

  build() {
    Swiper(){
      ForEach(this.bannerList, (item: BannerClass)=> {
        Image(item.src)
          .objectFit(ImageFit.Contain)
          .width('100%')
          .padding({ left: 16,right: 16, top: 11 })
          .borderRadius(16)
      }, (item: BannerClass) => item.id)
    }
    .autoPlay(true)
    .loop(true)
    .indicator(
      new DotIndicator()
        .color('#1a000000')
        .selectedColor('#0A59F7')
    )
  }

}



