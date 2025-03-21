import { QuickStartPage } from 'quickstart';
 import { CourseLearning } from "learning";
import { KnowledgeMap } from "map";

@Entry
@Component
struct Index {
  @State currentIndex: number = 0;
  private tabsController : TabsController = new TabsController();

  @Builder
  tabBarBuilder(title: string, targetIndex: number, selectedIcon: Resource, unselectIcon: Resource) {
    Column() {
      Image(this.currentIndex === targetIndex ? selectedIcon : unselectIcon)
        .width(24)
        .height(24)
      Text(title)
        .fontFamily('HarmonyHeiTi-Medium')
        .fontSize(10)
        .fontColor(this.currentIndex === targetIndex ? '#0A59F7' : 'rgba(0,0,0,0.60)')
        .textAlign(TextAlign.Center)
        .lineHeight(14)
        .fontWeight(500)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .onClick(() => {
      this.currentIndex = targetIndex;
      this.tabsController.changeIndex(targetIndex);
    })
  }


  build() {
    Tabs({ barPosition: BarPosition.End, controller: this.tabsController }) { // 设置导航页签栏位于应用界面的底部
      TabContent() {
        QuickStartPage()
      }
      .tabBar(this.tabBarBuilder("快速入门", 0, $r('app.media.ic_01_on'), $r('app.media.ic_01_off')))
      TabContent() {
        CourseLearning()
      }
      .tabBar(this.tabBarBuilder("课程学习", 1, $r('app.media.ic_02_on'), $r('app.media.ic_02_off')))

      TabContent() {
        KnowledgeMap()
      }
      .tabBar(this.tabBarBuilder("知识地图", 2, $r('app.media.ic_03_on'), $r('app.media.ic_03_off')))
    }
    .scrollable(false) // 限制Tabs无法横向滑动切换页签
    .vertical(false)  // 限制Tabs为非纵向导航条
    .divider({  // 使用divider属性将TabBar导航页签栏与TabContent进行分割
      strokeWidth: 0.5,
      color: '#0D182431'
    })
    .backgroundColor('#F1F3F5')
    .padding({ top: 36, bottom: 28 })
  }
}





