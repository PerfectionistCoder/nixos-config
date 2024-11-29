lib: config:
with lib;
{
  # disable spellcheck
  "layout.spellcheckDefault" = 0;

  # disable middlemouse paste
  "middlemouse.paste" = false;

  # clean address bar
  "browser.urlbar.suggest.history" = false;
  "browser.urlbar.suggest.openpage" = false;
  "browser.urlbar.suggest.topsites" = false;
  "browser.urlbar.quicksuggest.enabled" = false;
  "browser.urlbar.suggest.quicksuggest.sponsored" = false;
  "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
  "browser.urlbar.groupLabels.enabled" = false;

  # autoload extensions
  "extensions.autoDisableScopes" = 0;
}
