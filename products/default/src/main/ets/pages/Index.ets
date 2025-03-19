import { QuickStartPage } from 'quickstart';
import { CourseLearning } from "learning";
import { KnowledgeMap } from "map";

@Entry
@Component
struct Index {
  build() {
    Column() {
      // QuickStartPage()
      // CourseLearning()
      KnowledgeMap()
    }
    .backgroundColor('#F1F3F5')
    .padding({ top: 36, bottom: 28 })
  }
}





