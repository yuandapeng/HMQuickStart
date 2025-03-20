
import { BannerClass } from '../models/BannerClass';
import { webview } from '@kit.ArkWeb';

@Component
export struct BannerDetailPage {
  @State bannerClass: BannerClass | null = null;
  controller: webview.WebviewController = new webview.WebviewController();
  @Consume('articlePathStack') articlePathStack: NavPathStack;

  aboutToAppear(): void {
    this.bannerClass = this.articlePathStack.getParamByName('bannerDetailPage')[0] as BannerClass;
  }


  build() {
    NavDestination() {
      Column() {
        Web({
          src: this.bannerClass?.url,
          controller: this.controller
        })
          .darkMode(WebDarkMode.Auto)
          .domStorageAccess(true)// 授权storage
          .zoomAccess(true)
          .fileAccess(true)
          .mixedMode(MixedMode.All)
          .javaScriptAccess(true)// 授权script
          .width('100%')
          .layoutWeight(1)
      }
    }
    .width('100%')
    .height('100%')
  }
}