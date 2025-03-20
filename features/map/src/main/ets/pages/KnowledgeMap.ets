import { KnowledgeMapContent, Section } from "../view/KnowledgeMapContent";
import { NavBarItemType } from "../view/NavBarItem"
import { BusinessError } from '@kit.BasicServicesKit';
import { util } from "@kit.ArkTS";
import { mockSections } from "../view/MapData";

@Component
export struct KnowledgeMap {
  // 定义路由栈
  @Provide('knowledgeMapPageStack') knowledgeMapPageStack: NavPathStack = new NavPathStack();

  @State currentNavBarIndex: number = -1;

  @State navBarList: NavBarItemType[] = [
    { order: '01', title: '准备与学习' },
    { order: '02', title: '构建应用' },
    { order: '03', title: '应用测试' },
    { order: '04', title: '上架' },
    { order: '05', title: '运营增长' },
    { order: '06', title: '商业变现' },
    { order: '07', title: '更多' }
  ];

  @State sections: Section[] = [];

   /** 获取ui数据 **/
  private getSections() {
    try {
      getContext(this).resourceManager.getRawFileContent("MapData.json", (error: BusinessError, value: Uint8Array) => {
        const textDecoder = util.TextDecoder.create("utf-8");
        const res = textDecoder.decodeWithStream(value, { stream: false });
        this.sections = JSON.parse(res);
      });
    } catch (error) {
      this.sections = mockSections; // previewer api被mock所以不能正常获取数据
      console.error(`callback getRawFileContent failed, error is ${JSON.stringify(error)}`)
    }
  }

  aboutToAppear(){
    this.getSections();
  }


  @Builder
  PageMap(name: string) {
    if (name === 'KnowledgeMapContent') {
      KnowledgeMapContent({ section: this.sections[this.currentNavBarIndex] });
    }
  }

  build() {
    Navigation(this.knowledgeMapPageStack) {
      Scroll() {
        Column() {
          Text('知识地图')
            .fontFamily('HarmonyHeiTi-Bold')
            .fontSize(24)
            .fontColor(Color.Black)
            .textAlign(TextAlign.Start)
            .lineHeight(33)
            .fontWeight(700)
            .width('100%')
          Image($r("app.media.knowledge_map_banner"))
            .width('100%')
            .borderRadius(16)
            .margin({ top: 19, bottom: 8 })
          Text('通过循序渐进的学习路径，无经验和有经验的开发者都可以轻松掌握ArkTS语言声明式开发范式，体验更简洁、更友好的HarmonyOS应用开发旅程。')
            .fontFamily('HarmonyHeiTi')
            .fontSize(14)
            .fontColor('rgba(0,0,0,0.60)')
            .fontWeight(400)
            .textAlign(TextAlign.Start)
          List({ space: 12 }) {
            ForEach(this.navBarList, (item: NavBarItemType, index: number) => {
              ListItem() {
                NavBarItem({ navBarItem: item, currentNavBarIndex: this.currentNavBarIndex })
              }
              .width('100%')
            }, (item: NavBarItemType): string => item.title)
          }
          .width('100%')
          .margin({ top: 24 })
        }
        .padding({
          top: 12,
          right: 16,
          bottom: 12,
          left: 16
        })
        .backgroundColor('#F1F3F5')
      }
      .backgroundColor('#F1F3F5')
      .align(Alignment.TopStart)
      .constraintSize({ minHeight: '100%' })
      .edgeEffect(EdgeEffect.Spring)
    }
    .hideTitleBar(true) // 页面已经存在标题所以这里隐藏nav标题
    .navDestination(this.PageMap) // 自定义路由配置
    .mode(NavigationMode.Stack) // 设置为单页面显示模式
  }
}

@Component
export struct NavBarItem {
  @Prop navBarItem: NavBarItemType;
  @Consume('knowledgeMapPageStack') knowledgeMapPageStack: NavPathStack;
  // 之所以使用@Link的方式，是由于需要在组件中对值进行修改，并将修改同步到KnowledgeMap组件中
  @Link currentNavBarIndex: number;

  build() {
    Row(){
      Text(this.navBarItem.order)
        .margin({ right: 6 })
        .fontFamily('HarmonyHeiTi-Bold')
        .fontSize(21)
        .fontColor('#182431')
        .textAlign(TextAlign.Start)
        .lineHeight(22)
        .fontWeight(700)
      Text(this.navBarItem.title)
        .fontFamily('HarmonyHeiTi-Medium')
        .fontSize(16)
        .fontColor('#182431')
        .textAlign(TextAlign.Start)
        .lineHeight(22)
        .fontWeight(500)
      Blank()
      Image($r('app.media.ic_arrow'))
        .width(12)
        .height(24)
    }
    .width('100%')
    .height(48)
    .borderRadius(16)
    .alignItems(VerticalAlign.Center)
    .padding({ left: 12, right: 12 })
    .backgroundColor(
      this.currentNavBarIndex === Number(this.navBarItem.order) - 1 ?
      '#1A0A59F7' : Color.Transparent
    )
    .onClick(()=> {
      const index =  Number(this.navBarItem.order)  - 1;
      this.knowledgeMapPageStack.replacePath({ name: 'KnowledgeMapContent' });
      this.currentNavBarIndex = index;
    })
  }
}

