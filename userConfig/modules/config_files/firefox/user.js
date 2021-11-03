/* Privacy stuff, it's a damn shame that we need to do it this way ***/
user_pref("app.normandy.first_run", false);
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
user_pref("browser.newtabpage.activity-stream.disableSnippets", true);
user_pref("browser.newtabpage.activity-stream.feeds.section.highlights", false);
user_pref("browser.newtabpage.activity-stream.feeds.snippets", false);
user_pref("browser.pocket.enabled", false);
user_pref("extensions.pocket.enabled", false);
user_pref("privacy.trackingprotection.fingerprinting.enabled", true);
user_pref("privacy.trackingprotection.cryptomining.enabled", true);
user_pref("privacy.trackingprotection.socialtracking.enabled", true);

/* Cache less ***/
user_pref("browser.cache.disk.capacity", 100000);
user_pref("browser.cache.disk.smart_size.enabled", false);

/* Feature stuff ***/
user_pref("dom.w3c_touch_events.enabled", 1);
user_pref("security.webauth.u2f", true);
user_pref("browser.tabs.warnOnClose", false);
user_pref("browser.tabs.closeWindowWithLastTab", false);
user_pref("browser.toolbars.bookmarks.showOtherBookmarks", false);
user_pref("general.warnOnAboutConfig", false);
user_pref("dom.webnotifications.enabled", false);
user_pref("browser.download.useDownloadDir", false);
user_pref("browser.urlbar.clickSelectsAll", true);
user_pref("browser.urlbar.doubleClickSelectsAll", false);
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

/* Do not have "offline mode" for fucks sake, we're not on 1992 ***/
user_pref("network.manage-offline-status", false);

/* Helps on hidpi ***/
user_pref("layout.css.devPixelsPerPx", 1.2);

/* Moronic ad stuff ***/
user_pref("browser.urlbar.suggest.topsites", false);
user_pref("browser.urlbar.sponsoredTopSites", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.discoverystream.sponsored-collections.enabled", false);
user_pref("services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsored", false);
user_pref("services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSites", false);
