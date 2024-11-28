lib: config:
with lib;
{
  # disable spellcheck
  "layout.spellcheckDefault" = 0;

  # middlemouse paste
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

  # disable tooltip
  "ui.tooltip.delay_ms" = -1;
}
// (optionalAttrs config.custom.features.firefox.customCss {
  #theme
  "browser.theme.content-theme" = 0;
  "browser.theme.toolbar-theme" = 0;
  "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";

  # userChrome
  "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

  # browser devtool
  "devtools.toolbox.host" = "window";
  "devtools.chrome.enabled" = true;
  "devtools.debugger.remote-enabled" = true;
})
