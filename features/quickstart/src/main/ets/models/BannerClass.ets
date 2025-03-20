export class BannerClass {
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