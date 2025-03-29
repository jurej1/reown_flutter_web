export class JSModalMetadata {
  public name: string;
  public description: string;
  public url: string;
  public icons: string[];

  constructor(name: string, description: string, url: string, icons: string[]) {
    this.name = name;
    this.description = description;
    this.url = url;
    this.icons = icons;
  }
}
