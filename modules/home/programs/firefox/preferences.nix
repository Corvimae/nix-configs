{
  # largely taken from https://github.com/yokoffing/Betterfox/blob/main/user.js

  "browser.startup.page" = 3; # restore previous session on startup

  # hm-specific stuff
  "extensions.autoDisableScopes" = 0; # auto-enable extensions

  # performance
  "widget.gtk.global-menu.enabled" = true;
  "widget.gtk.global-menu.wayland.enabled" = true;
  "gfx.canvas.accelerated.cache-size" = 256;
  
  # tracking + privacy stuff
  "browser.contentblocking.category" = "strict";
  "browser.download.start_downloads_in_tmp_dir" = true;
  "browser.uitour.enabled" = false;
  "privacy.globalprivacycontrol.enabled" = true;
  "security.OCSP.enabled" = 0;
  "privacy.antitracking.isolateContentScriptResources" = true;
  "security.csp.reporting.enabled" = false;

  # ssl
  "security.ssl.treat_unsafe_negotiation_as_broken" = true;
  "browser.xul.error_pages.expert_bad_cert" = true;
  "security.tls.enable_0rtt_data" = true;
  
  # cache
  "browser.cache.disk.enable" = false;
  "browser.privatebrowsing.forceMediaMemoryCache" = true;
  "media.memory_cache_max_size" = 65536;

  # misc
  "browser.privatebrowsing.resetPBM.enabled" = true;
  "privacy.history.custom" = true;
  "dom.security.https_only_mode" = true;
  "dom.security.https_only_mode_error_page_user_suggestions" = true;
  "network.http.referer.XOriginTrimmingPolicy" = 2;
  "browser.safebrowsing.downloads.remote.enabled" = false;
  "browser.search.update" = false;
  "permissions.manager.defaultsUrl" = "";
  "extensions.getAddons.cache.enabled" = false;
  "full-screen-api.transition-duration.enter" = "0 0";
  "full-screen-api.transition-duration.leave" = "0 0";
  "browser.download.manager.addToRecentDocs" = false;
  "browser.download.open_pdf_attachments_inline" = true;
  "browser.menu.showViewImageInfo" = true;
  "findbar.highlightAll" = true;
  "layout.word_select.eat_space_to_next_word" = false;

  # prefetching + speculative loading
  "network.http.speculative-parallel-limit" = 0;
  "network.dns.disablePrefetch" = true;
  "browser.urlbar.speculativeConnect.enabled" = false;
  "browser.places.speculativeConnect.enabled" = false;
  "network.prefetch-next" = false;

  # search bar
  "browser.search.separatePrivateDefault.ui.enabled" = true;
  "browser.search.suggest.enabled" = false;
  "browser.urlbar.quicksuggest.enabled" = false;
  "browser.urlbar.groupLabels.enabled" = false;
  # "browser.formfill.enable" = false;
  "network.IDN_show_punycode" = true;

  # passwords
  "signon.formlessCapture.enabled" = false;
  "signon.privateBrowsingCapture.enabled" = false;
  "network.auth.subresource-http-auth-allow" = 1;
  "editor.truncate_user_pastes" = false;

  # telemetry
  "datareporting.policy.dataSubmissionEnabled" = false;
  "datareporting.healthreport.uploadEnabled" = false;
  "toolkit.telemetry.unified" = false;
  "toolkit.telemetry.enabled" = false;
  "toolkit.telemetry.server" = "data:,";
  "toolkit.telemetry.archive.enabled" = false;
  "toolkit.telemetry.newProfilePing.enabled" = false;
  "toolkit.telemetry.shutdownPingSender.enabled" = false;
  "toolkit.telemetry.updatePing.enabled" = false;
  "toolkit.telemetry.bhrPing.enabled" = false;
  "toolkit.telemetry.firstShutdownPing.enabled" = false;
  "toolkit.telemetry.coverage.opt-out" = true;
  "toolkit.coverage.opt-out" = true;
  "toolkit.coverage.endpoint.base" = "";
  "browser.newtabpage.activity-stream.feeds.telemetry" = false;
  "browser.newtabpage.activity-stream.telemetry" = false;
  "datareporting.usage.uploadEnabled" = false;
  "app.shield.optoutstudies.enabled" = false;
  "app.normandy.enabled" = false;
  "app.normandy.api_url" = "";

  # annoying stuff (ui) begone
  "extensions.getAddons.showPane" = false;
  "extensions.htmlaboutaddons.recommendations.enabled" = false;
  "browser.discovery.enabled" = false;
  # "browser.shell.checkDefaultBrowser" = false;
  "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
  "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
  "browser.preferences.moreFromMozilla" = false;
  "browser.aboutConfig.showWarning" = false;
  "browser.startup.homepage_override.mstone" = "ignore";
  "browser.aboutwelcome.enabled" = false;
  "browser.profiles.enabled" = true;
  "browser.urlbar.trending.featureGate" = false;

  # new tab stuff
  "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
  "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
  "browser.newtabpage.activity-stream.showSponsored" = false;
  "browser.newtabpage.activity-stream.showSponsoredCheckboxes" = false;
  "browser.newtabpage.activity-stream.default.sites" = "";

  # disable ai
  "browser.ml.enable" = false;
  "browser.ai.control.default" = "blocked";
  "browser.tabs.groups.smart.enabled" = false;
  "browser.ml.linkPreview.enabled" = false;
  "browser.ml.chat.enabled" = false;
  "browser.ml.chat.menu" = false;

  # annoying stuff (other) begone
  "permissions.default.desktop-notification" = 2; # block web notifications
  "permissions.default.geo" = 2; # block location requests
  "geo.provider.network.url" = "https://beacondb.net/v1/geolocate";
  "breakpad.reportURL" = "";
  "browser.tabs.crashReporting.sendReport" = false;

  # filter suggestions
  "browser.urlbar.suggest.addons" = false;
  "browser.urlbar.suggest.bookmark" = true;
  "browser.urlbar.suggest.calculator" = true;
  "browser.urlbar.suggest.clipboard" = false;
  "browser.urlbar.suggest.engines" = false;
  "browser.urlbar.suggest.history" = true;
  "browser.urlbar.suggest.mdn" = false;
  "browser.urlbar.suggest.openpage" = true;
  "browser.urlbar.suggest.pocket" = false;
  "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
  "browser.urlbar.suggest.quicksuggest.sponsored" = false;
  "browser.urlbar.suggest.topsites" = false;
  "browser.urlbar.suggest.trending" = false;
  "browser.urlbar.suggest.weather" = false;
}