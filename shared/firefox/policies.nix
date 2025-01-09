{
  "3rdparty" = {
    Extensions = {
      "uBlock0@raymondhill.net" = {
        adminSettings = {
          selectedFilterLists = [
            "user-filters"
            "ublock-filters"
            "ublock-badware"
            "ublock-privacy"
            "ublock-quick-fixes"
            "ublock-unbreak"
            "easylist"
            "easyprivacy"
            "urlhaus-1"
            "curben-phishing"
            "plowe-0"
            "fanboy-cookiemonster"
            "ublock-cookies-easylist"
            "fanboy-social"
            "easylist-chat"
            "easylist-newsletters"
            "easylist-notifications"
            "easylist-annoyances"
            "ublock-annoyances"
          ];
          dynamicFilteringString = "behind-the-scene * * noop\nbehind-the-scene * inline-script noop\nbehind-the-scene * 1p-script noop\nbehind-the-scene * 3p-script noop\nbehind-the-scene * 3p-frame noop\nbehind-the-scene * image noop\nbehind-the-scene * 3p noop\n* * 3p-frame block";
          hostnameSwitchesString = "no-large-media: behind-the-scene false\nno-csp-reports: * true";
        };
      };
    };
  };
  AllowedDomainsForApps = "";
  AutofillAddressEnabled = false;
  AutofillCreditCardEnabled = false;
  Cookies = {
    Behavior = "reject";
  };
  DisableBuiltinPDFViewer = true;
  DisableFeedbackCommands = true;
  DisableEncryptedClientHello = false;
  DisableFirefoxAccounts = true;
  DisableFirefoxScreenshots = true;
  DisableFirefoxStudies = true;
  DisableForgetButton = true;
  DisableFormHistory = true;
  DisablePocket = true;
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
  ExtensionUpdate = false;
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
    Default = true;
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
  RequestedLocales = "";
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
}
