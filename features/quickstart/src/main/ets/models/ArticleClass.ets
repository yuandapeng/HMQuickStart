export class ArticleClass {
  id: string = '';
  imageSrc: ResourceStr = '';
  title: string = '';
  brief: string = '';
  url: string = '';

  constructor(id: string, imageSrc: ResourceStr, title: string, brief: string, url: string) {
    this.id = id;
    this.imageSrc = imageSrc;
    this.title = title;
    this.brief = brief;
    this.url = url;
  }
}