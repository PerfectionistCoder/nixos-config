{
  force = true;
  default = "SearXNG";
  engines = {
    "SearXNG" = {
      urls = [
        { template = "https://search.rhscz.eu/search?q={searchTerms}&language=en"; }
      ];
      definedAliases = [""];
    };

    "Google".metaData.hidden = true;
    "eBay".metaData.hidden = true;
    "Wikipedia (en)".metaData.hidden = true;
    "DuckDuckGo".metaData.hidden = true;
    "Bing".metaData.hidden = true;
  };
}
