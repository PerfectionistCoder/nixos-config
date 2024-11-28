{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
with lib;
{
  programs.firefox = {
    enable = true;
    package = inputs.firefox.packages.${pkgs.system}.firefox-bin;
    languagePacks = [ "en-US" ];
    policies = {
      AllowedDomainsForApps = "";
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      Cookies = {
        Behavior = "reject";
      };
      # DisableBuiltinPDFViewer = true;
      DisableFeedbackCommands = true;
      DisableEncryptedClientHello = false;
      DisableFirefoxAccounts = true;
      DisableFirefoxScreenshots = true;
      DisableFirefoxStudies = true;
      DisableForgetButton = true;
      DisableFormHistory = true;
      DisablePocket = true;
      DisablePrivateBrowsing = true;
      DisableProfileImport = true;
      DisableSafeMode = false;
      DisableSecurityBypass = {
        InvalidCertificate = true;
        SafeBrowsing = true;
      };
      DisableSetDesktopBackground = true;
      DisableSystemAddonUpdate = true;
      DisableTelemetry = true;
      DisplayBookmarksToolbar = "never";
      DisplayMenuBar = "never";
      DNSOverHTTPS = {
        Enabled = true;
        ProviderURL = "https://cloudflare-dns.com/dns-query";
        Locked = true;
        Fallback = true;
      };
      DontCheckDefaultBrowser = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      EncryptedMediaExtensions = {
        Enabled = false;
      };
      ExtensionSettings = {
        "*" = {
          installation_mode = "blocked";
          temporarily_allow_weak_signatures = false;
        };
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "normal_installed";
          default_area = "menupanel";
        };
      };
      ExtensionUpdate = true;
      FirefoxHome = {
        Search = false;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        SponsoredPocket = false;
        Snippets = false;
      };
      GoToIntranetSiteForSingleWordEntryInAddressBar = false;
      HardwareAcceleration = true;
      Homepage = {
        StartPage = "none";
      };
      HttpsOnlyMode = "force_enabled";
      InstallAddonsPermission = {
        Default = false;
      };
      LegacySameSiteCookieBehaviorEnabled = false;
      ManualAppUpdateOnly = true;
      NetworkPrediction = false;
      NoDefaultBookmarks = false;
      OfferToSaveLogins = false;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      PasswordManagerEnabled = false;
      PDFjs = {
        Enabled = false;
      };
      Permissions = {
        Camera = {
          BlockNewRequests = true;
        };
        Microphone = {
          BlockNewRequests = true;
        };
        Location = {
          BlockNewRequests = true;
        };
        Notifications = {
          BlockNewRequests = true;
        };
        Autoplay = {
          Default = "block-audio-video";
        };
      };
      PictureInPicture = {
        Enabled = false;
      };
      PopupBlocking = {
        Default = false;
      };
      PostQuantumKeyAgreementEnabled = true;
      PrintingEnabled = false;
      PromptForDownloadLocation = false;
      RequestedLocales = "en-US";
      SanitizeOnShutdown = true;
      SearchBar = "unified";
      SearchSuggestEnabled = false;
      ShowHomeButton = false;
      TranslateEnabled = false;
      UserMessaging = {
        ExtensionRecommendations = false;
        FeatureRecommendations = false;
        UrlbarInterventions = false;
        SkipOnboarding = true;
        MoreFromMozilla = false;
        FirefoxLabs = false;
      };
    };
  };
}
