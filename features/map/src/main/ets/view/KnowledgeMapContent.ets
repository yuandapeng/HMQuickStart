interface KnowledgeBaseItem {
  type: string,
  title: string
}


interface Material {
  subtitle: string,
  knowledgeBase: KnowledgeBaseItem[]
}

export interface Section {
  title: string,
  brief: string,
  materials: Material[]
}


const TypeMapIcon: Record<string, string> = {
  '指南': 'app.media.ic_guide',
  '准备': 'app.media.ic_prepare',
  '学习与获取证书': 'app.media.ic_medals',
  '视频教程': 'app.media.ic_video',
}


@Component
export struct KnowledgeMapContent {
  scroller: Scroller = new Scroller();

  @Prop section: Section;

  @Builder
  KnowledgeBlock(material: Material) {
    Column() {
      Text(material.subtitle)
        .fontFamily('HarmonyHeiTi-Medium')
        .fontSize(14)
        .fontWeight(500)
        .margin({ bottom: 8 })
      List({ space: 12 }) {
        ForEach(material.knowledgeBase, (item: KnowledgeBaseItem) => {
          ListItem(){
            this.KnowledgeBlockLine(item)
          }
        }, (item: KnowledgeBaseItem) => item.title)
      }
      .backgroundColor(Color.White)
      .borderRadius(16)
      .padding({ left: 12, right: 12 })
      .divider({
        strokeWidth: 0.5,
        startMargin: 38,
        endMargin: 0,
        color: '#F2F2F2'
      })
    }
    .width('100%')
    .margin({ top: 28 })
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  KnowledgeBlockLine(knowledgeBaseItem: KnowledgeBaseItem) {
    Row() {
      Image($r(TypeMapIcon[knowledgeBaseItem.type]))
        .width(20)
        .height(20)
      Column() {
        Text(knowledgeBaseItem.title)
          .fontFamily('HarmonyHeiTi-Medium')
          .fontSize(16)
          .fontWeight(500)
        Text(knowledgeBaseItem.type)
          .fontFamily('HarmonyHeiTi')
          .fontSize(14)
          .fontWeight(400)
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 18 })
      Blank() // 占满剩余部分
      Image($r('app.media.ic_arrow'))
        .width(12)
        .height(24)
    }
    .width('100%')
    .height(64)
    .alignItems(VerticalAlign.Center)
  }

  build() {
    NavDestination(){
      Scroll(this.scroller) {
        Column() {
          Text(this.section?.title)
            .fontFamily('HarmonyHeiTi-Bold')
            .fontSize(20)
            .fontWeight(700)
            .fontColor(Color.Black)
          Text(this.section?.brief)
            .fontFamily('HarmonyHeiTi')
            .fontSize(12)
            .fontColor('rgba(0,0,0,0.60)')
            .textAlign(TextAlign.JUSTIFY)
            .fontWeight(400)
            .margin({ top: 12 })
          ForEach(this.section.materials, (item: Material) => {
            this.KnowledgeBlock(item);
          }, (item: Material) => {
            return item.subtitle
          })
        }
        .alignItems(HorizontalAlign.Start)
        .padding({
          top: 12,
          left: 16,
          bottom: 12,
          right: 16
        })
        .backgroundColor('#F1F3F5')
      }
      .align(Alignment.TopStart)
      .constraintSize({ minHeight: '100%' })
      .edgeEffect(EdgeEffect.Spring) // 设置边缘滑动效果
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Auto)
      .backgroundColor('#F1F3F5')
    }
    .hideTitleBar(true)
  }
}