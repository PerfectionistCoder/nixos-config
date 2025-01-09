rec {
  force = true;
  default = "SearXNG";
  privateDefault = default;
  engines = {
    "SearXNG" = {
      urls = [
        { template = "https://search.rhscz.eu/search?q={searchTerms}&language=en"; }
      ];
    };

    "Google".metaData.hidden = true;
    "eBay".metaData.hidden = true;
    "Wikipedia (en)".metaData.hidden = true;
    "DuckDuckGo".metaData.hidden = true;
    "Bing".metaData.hidden = true;
  };
}
