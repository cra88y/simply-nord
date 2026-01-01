diff --git "a/c:\\Users\\cra88y\\Dev\\Repos\\simply-nord\\less-archive/animations.less" "b/c:\\Users\\cra88y\\Dev\\Repos\\simply-nord\\less-crab-nord/animations.less"
index 75c9830..b2a955e 100644
--- "a/c:\\Users\\cra88y\\Dev\\Repos\\simply-nord\\less-archive/animations.less"
+++ "b/c:\\Users\\cra88y\\Dev\\Repos\\simply-nord\\less-crab-nord/animations.less"
@@ -1,19 +1,19 @@
 .dialog-modal {
   animation-name: dialogmodal;
   animation-duration: 0.13s;
 
   @keyframes dialogmodal {
     0% {
       opacity: 0;
     }
 
     50% {
       opacity: 0.5;
       transform: translate(-50%, -50%) scale(1.05);
     }
   }
 }
 
 input.checkbox-onoff[type="checkbox"]::before {
-  transition: left 0.25s;
+  transition: left 0.1s;
 }
diff --git "a/c:\\Users\\cra88y\\Dev\\Repos\\simply-nord\\less-archive/autocomplete.less" "b/c:\\Users\\cra88y\\Dev\\Repos\\simply-nord\\less-crab-nord/autocomplete.less"
index 93efb87..a68e509 100644
--- "a/c:\\Users\\cra88y\\Dev\\Repos\\simply-nord\\less-archive/autocomplete.less"
+++ "b/c:\\Users\\cra88y\\Dev\\Repos\\simply-nord\\less-crab-nord/autocomplete.less"
@@ -1,73 +1,71 @@
-/*! Autocomplete.js v2.6.3 | license MIT | (c) 2017, Baptiste Donaux | http://autocomplete-js.com */
-
 .autocomplete {
   position: absolute;
-  width: @search-width;
-  max-width: calc(100% - 2 * @search-padding-horizontal);
-  max-height: 0;
+  min-width: @search-width;
   overflow-y: hidden;
   .ltr-text-align-left();
-
-  .rounded-corners;
+  border-radius: 0;
+  max-height: 0;
 
   &:active,
   &:focus,
   &:hover {
-    background-color: var(--color-autocomplete-background);
+    background-color: var(--color-header-background);
   }
 
   &:empty {
     display: none;
   }
 
   > ul {
     list-style-type: none;
     margin: 0;
     padding: 0;
 
     > li {
       cursor: pointer;
-      padding: 0.5rem 1rem;
+      padding: 1rem;
 
       &.active,
       &:active,
       &:focus,
       &:hover {
         background-color: var(--color-autocomplete-background-hover);
 
         a:active,
         a:focus,
         a:hover {
           text-decoration: none;
         }
       }
 
       &.locked {
         cursor: inherit;
       }
     }
   }
 
   &.open {
-    display: block;
+    display: none;
     background-color: var(--color-autocomplete-background);
     color: var(--color-autocomplete-font);
-    max-height: 32rem;
+    max-height: 100dvh !important;
     overflow-y: auto;
     z-index: 5000;
     margin-top: 3.5rem;
-    border-radius: 0.8rem;
+    border-radius: 0 0 25px 25px;
 
     &:empty {
       display: none;
     }
   }
 }
 
+#search_view:focus-within > .search_box > .autocomplete.open {
+  display: block;
+}
+
 @media screen and (max-width: @phone) {
   .autocomplete {
-    > ul > li {
-      padding: 1rem;
-    }
+    min-width: 100%;
   }
 }
diff --git "a/c:\\Users\\cra88y\\Dev\\Repos\\simply-nord\\less-archive/definitions.less" "b/c:\\Users\\cra88y\\Dev\\Repos\\simply-nord\\less-crab-nord/definitions.less"
index d2d14e3..1f330e2 100644
--- "a/c:\\Users\\cra88y\\Dev\\Repos\\simply-nord\\less-archive/definitions.less"
+++ "b/c:\\Users\\cra88y\\Dev\\Repos\\simply-nord\\less-crab-nord/definitions.less"
@@ -1,309 +1,388 @@
 /*
  * SearXNG, A privacy-respecting, hackable metasearch engine
  *
  * To change the colors of the site, simple edit this variables
  */
 
 /// Light Theme
+// Nord Palette Variables
+@nord01: #1d2128;
+@nord0: #2e3440; // Polar Night - Darkest
+@nord1: #3b4252; // Polar Night
+@nord2: #434c5e; // Polar Night
+@nord3: #4c566a; // Polar Night - Lightest
+
+@nord4: #d8dee9; // Snow Storm - Darkest
+@nord5: #e5e9f0; // Snow Storm
+@nord6: #eceff4; // Snow Storm - Purest White
+
+@nord7: #8fbcbb; // Frost - Light Teal/Cyan
+@nord8: #88c0d0; // Frost - Medium Blue/Cyan
+@nord9: #81a1c1; // Frost - Darker Blue
+@nord10: #5e81ac; // Frost - Darkest Blue
+
+@nord11: #bf616a; // Aurora - Red
+@nord12: #d08770; // Aurora - Orange
+@nord13: #ebcb8b; // Aurora - Yellow
+@nord14: #a3be8c; // Aurora - Green
+@nord15: #b48ead; // Aurora - Purple/Magenta
+
+/// Light Nord Theme (Default)
 :root {
   /// Base Colors
-  --color-base-font: #444;
-  --color-base-font-rgb: 68, 68, 68;
-  --color-base-background: #fff;
-  --color-base-background-mobile: #f2f5f8;
-  --color-url-font: #334999;
-  --color-url-visited-font: #9822c3;
+  --color-base-font: @nord1; // Polar Night for text on light background
+  --color-base-font-rgb: 59, 66, 82; // Derived from @nord1
+  --color-base-background: @nord6; // Snow Storm for main background
+  --color-base-background-mobile: @nord5; // Slightly darker Snow Storm for mobile
+  --color-url-font: @nord10; // Frost blue for links
+  --color-url-visited-font: @nord15; // Aurora purple for visited links
+
   /// Header Colors
-  --color-header-background: #fdfbff;
-  --color-header-border: #ddd;
+  --color-header-background: @nord6;
+  --color-header-border: @nord4;
+
   /// Footer Colors
-  --color-footer-background: #fdfbff;
-  --color-footer-border: #ddd;
+  --color-footer-background: @nord6;
+  --color-footer-border: @nord4;
+
   /// Sidebar Colors
-  --color-sidebar-border: #ddd;
-  --color-sidebar-font: #000;
-  --color-sidebar-background: #fff;
+  --color-sidebar-border: @nord4;
+  --color-sidebar-font: @nord1;
+  --color-sidebar-background: @nord5; // Slightly off-white for sidebar
+
   /// BackToTop Colors
-  --color-backtotop-font: #444;
-  --color-backtotop-border: #ddd;
-  --color-backtotop-background: #fff;
+  --color-backtotop-font: @nord1;
+  --color-backtotop-border: @nord4;
+  --color-backtotop-background: @nord6;
+
   /// Button Colors
-  --color-btn-background: #3050ff;
-  --color-btn-font: #fff;
-  --color-show-btn-background: #bbb;
-  --color-show-btn-font: #000;
+  --color-btn-background: @nord9; // Frost blue for primary action
+  --color-btn-font: @nord6; // White text on blue button
+  --color-show-btn-background: @nord4; // Light gray for secondary/show buttons
+  --color-show-btn-font: @nord1; // Dark text
+
   /// Search Input Colors
-  --color-search-border: #bbb;
-  --color-search-shadow: 0 2px 8px rgb(34 38 46 / 25%);
-  --color-search-background: #fff;
-  --color-search-font: #222;
-  --color-search-background-hover: #3050ff;
+  --color-search-border: @nord4;
+  --color-search-shadow: 0 2px 8px
+    rgb(red(@nord0) green(@nord0) blue(@nord0) / 15%); // Subtle shadow
+
+  --color-search-background: @nord6;
+  --color-search-font: @nord0;
+  --color-search-background-hover: @nord9; // Frost blue on hover
+
   /// Modal Colors
-  --color-error: #db3434;
-  --color-error-background: lighten(#db3434, 40%);
-  --color-warning: #dbba34;
-  --color-warning-background: lighten(#dbba34, 40%);
-  --color-success: #42db34;
-  --color-success-background: lighten(#42db34, 40%);
+  --color-error: @nord11;
+  --color-error-background: lighten(@nord11, 35%); // Lighter red background
+  --color-warning: @nord12;
+  --color-warning-background: lighten(
+    @nord12,
+    35%
+  ); // Lighter orange background
+
+  --color-success: @nord14;
+  --color-success-background: lighten(@nord14, 35%); // Lighter green background
+
   /// Categories Colors
-  --color-categories-item-selected-font: #3050ff;
-  --color-categories-item-border-selected: #3050ff;
+  --color-categories-item-selected-font: @nord10; // Frost blue for selected category
+  --color-categories-item-border-selected: @nord10;
+
   /// Autocomplete Colors
-  --color-autocomplete-font: #000;
-  --color-autocomplete-border: #bbb;
-  --color-autocomplete-shadow: 0 2px 8px rgb(34 38 46 / 25%);
-  --color-autocomplete-background: #fff;
-  --color-autocomplete-background-hover: #e3e3e3;
+  --color-autocomplete-font: @nord0;
+  --color-autocomplete-border: @nord4;
+  --color-autocomplete-shadow: 0 2px 8px
+    rgb(red(@nord0) green(@nord0) blue(@nord0) / 10%);
+  --color-autocomplete-background: @nord6;
+  --color-autocomplete-background-hover: @nord5;
+
   /// Answer Colors
-  --color-answer-font: #444; // same as --color-base-font
-  --color-answer-background: #fff;
+  --color-answer-font: @nord1;
+  --color-answer-background: @nord5; // Slightly off-white
+
   // colors of the KeyValue result class
-  --color-result-keyvalue-col-table: #fdfbff;
-  --color-result-keyvalue-odd: #fdfbff;
-  --color-result-keyvalue-even: #fff;
+  --color-result-keyvalue-col-table: @nord5;
+  --color-result-keyvalue-odd: @nord5;
+  --color-result-keyvalue-even: @nord6;
+
   /// Results Colors
-  --color-result-background: #fff;
-  --color-result-border: #ddd;
-  --color-result-url-font: #000;
-  --color-result-vim-selected: #f7f7f7;
-  --color-result-vim-arrow: #000bbb;
-  --color-result-description-highlight-font: #000;
-  --color-result-link-font: #000bbb;
-  --color-result-link-font-highlight: #000bbb;
-  --color-result-link-visited-font: #9822c3;
-  --color-result-publishdate-font: #777;
-  --color-result-engines-font: #545454;
-  --color-result-search-url-border: #ddd;
-  --color-result-search-url-font: #000;
+  --color-result-background: @nord6;
+  --color-result-border: @nord4;
+  --color-result-url-font: @nord3; // Slightly lighter Polar Night for URL
+  --color-result-vim-selected: @nord5;
+  --color-result-vim-arrow: @nord9;
+  --color-result-description-highlight-font: @nord1; // Dark text for highlight on light bg
+  --color-result-link-font: @nord10;
+  --color-result-link-font-highlight: @nord7; // Lighter Frost for highlight
+  --color-result-link-visited-font: @nord15;
+  --color-result-publishdate-font: @nord2;
+  --color-result-engines-font: @nord3;
+  --color-result-search-url-border: @nord4;
+  --color-result-search-url-font: @nord1;
+
   // Images Colors
-  --color-result-image-span-font: #444;
-  --color-result-image-span-font-selected: #fff;
-  --color-result-image-background: #fff;
+  --color-result-image-span-font: @nord1;
+  --color-result-image-span-font-selected: @nord6; // White text on selection
+  --color-result-image-background: @nord6;
+
   /// Settings Colors
-  --color-settings-tr-hover: #ebebeb;
-  --color-settings-engine-description-font: #545454;
-  --color-settings-table-group-background: #0001;
-  /// Detail modal
-  --color-result-detail-font: #fff;
-  --color-result-detail-label-font: lightgray;
-  --color-result-detail-background: #242424;
-  --color-result-detail-hr: #555;
-  --color-result-detail-link: #8af;
-  --color-result-detail-loader-border: rgb(255 255 255 / 20%);
-  --color-result-detail-loader-borderleft: rgb(0 0 0 / 0%);
+  --color-settings-tr-hover: @nord5;
+  --color-settings-engine-description-font: @nord2;
+  --color-settings-table-group-background: rgb(
+    red(@nord3) green(@nord3) blue(@nord3) / 10%
+  ); // Very light group bg
+
+  /// Detail modal (for light theme, this will be a dark modal on light page - can be adjusted)
+  --color-result-detail-font: @nord4; // Light text for dark modal
+  --color-result-detail-label-font: @nord3;
+  --color-result-detail-background: @nord0; // Dark modal background
+  --color-result-detail-hr: @nord2;
+  --color-result-detail-link: @nord8; // Frost link in dark modal
+  --color-result-detail-loader-border: rgb(
+    red(@nord4) green(@nord4) blue(@nord4) / 20%
+  );
+  --color-result-detail-loader-borderleft: rgb(
+    red(@nord0) green(@nord0) blue(@nord0) / 0%
+  );
+
   /// Toolkit Colors
-  --color-toolkit-badge-font: #fff;
-  --color-toolkit-badge-background: #545454;
-  --color-toolkit-kbd-font: #fff;
-  --color-toolkit-kbd-background: #000;
-  --color-toolkit-dialog-border: #ddd;
-  --color-toolkit-dialog-background: #fff;
-  --color-toolkit-tabs-label-border: #fff;
-  --color-toolkit-tabs-section-border: #ddd;
-  --color-toolkit-select-background: #e1e1e1;
-  --color-toolkit-select-border: #ddd;
-  --color-toolkit-select-background-hover: #bbb;
-  --color-toolkit-input-text-font: #222;
-  --color-toolkit-checkbox-onoff-off-background: #ddd;
-  --color-toolkit-checkbox-onoff-on-background: #ddd;
-  --color-toolkit-checkbox-onoff-on-mark-background: #3050ff;
-  --color-toolkit-checkbox-onoff-on-mark-color: #fff;
-  --color-toolkit-checkbox-onoff-off-mark-background: #aaa;
-  --color-toolkit-checkbox-onoff-off-mark-color: #fff;
-  --color-toolkit-checkbox-label-background: #ddd;
-  --color-toolkit-checkbox-label-border: #ddd;
-  --color-toolkit-checkbox-input-border: #3050ff;
-  --color-toolkit-engine-tooltip-border: #ddd;
-  --color-toolkit-engine-tooltip-background: #fff;
-  --color-toolkit-loader-border: rgb(0 0 0 / 20%);
-  --color-toolkit-loader-borderleft: rgb(255 255 255 / 0%);
-  --color-doc-code: #003;
-  --color-doc-code-background: #ddeaff;
+  --color-toolkit-badge-font: @nord6;
+  --color-toolkit-badge-background: @nord3;
+  --color-toolkit-kbd-font: @nord6;
+  --color-toolkit-kbd-background: @nord1;
+  --color-toolkit-dialog-border: @nord4;
+  --color-toolkit-dialog-background: @nord6;
+  --color-toolkit-tabs-label-border: @nord6;
+  --color-toolkit-tabs-section-border: @nord4;
+  --color-toolkit-select-background: @nord5;
+  --color-toolkit-select-border: @nord4;
+  --color-toolkit-select-background-hover: @nord4;
+  --color-toolkit-input-text-font: @nord0;
+  --color-toolkit-checkbox-onoff-off-background: @nord4;
+  --color-toolkit-checkbox-onoff-on-background: @nord9; // Frost blue for "on" state
+  --color-toolkit-checkbox-onoff-on-mark-background: @nord14; // Green for "on" mark
+  --color-toolkit-checkbox-onoff-on-mark-color: @nord6; // White mark
+  --color-toolkit-checkbox-onoff-off-mark-background: @nord11; // Red for "off" mark
+  --color-toolkit-checkbox-onoff-off-mark-color: @nord6; // White mark
+  --color-toolkit-checkbox-label-background: @nord5;
+  --color-toolkit-checkbox-label-border: @nord4;
+  --color-toolkit-checkbox-input-border: @nord9;
+  --color-toolkit-engine-tooltip-border: @nord4;
+  --color-toolkit-engine-tooltip-background: @nord6;
+  --color-toolkit-loader-border: rgb(
+    red(@nord1) green(@nord1) blue(@nord1) / 20%
+  );
+  --color-toolkit-loader-borderleft: rgb(
+    red(@nord6) green(@nord6) blue(@nord6) / 0%
+  );
+  --color-doc-code: @nord1;
+  --color-doc-code-background: @nord5;
+
   /// Other misc colors
-  --color-bar-chart-primary: #5bc0de;
-  --color-bar-chart-secondary: #deb15b;
-  --color-image-resolution-background: rgb(0 0 0 / 50%);
-  --color-image-resolution-font: #fff;
-  --color-loading-indicator: rgb(255 255 255 / 20%);
-  --color-loading-indicator-gap: #fff;
-  --color-line-number: #64708d;
+  --color-bar-chart-primary: @nord8;
+  --color-bar-chart-secondary: @nord13;
+  --color-image-resolution-background: rgb(
+    red(@nord0) green(@nord0) blue(@nord0) / 50%
+  );
+  --color-image-resolution-font: @nord6;
+  --color-loading-indicator: rgb(red(@nord1) green(@nord1) blue(@nord1) / 20%);
+  --color-loading-indicator-gap: @nord6;
+  --color-line-number: @nord3;
+
   // Favicons Colors
-  --color-favicon-background-color: #ddd;
-  --color-favicon-border-color: #ccc;
+  --color-favicon-background-color: @nord5;
+  --color-favicon-border-color: @nord4;
 }
 
 .dark-themes() {
   /// Base Colors
-  --color-base-font: #bbb;
+  --color-base-font: @nord4;
   --color-base-font-rgb: 187, 187, 187;
-  --color-base-background: #222428;
-  --color-base-background-mobile: #222428;
-  --color-url-font: #8af;
-  --color-url-visited-font: #c09cd9;
+  --color-base-background: @nord0;
+  --color-base-background-mobile: @nord0;
+  --color-url-font: @nord7;
+  --color-url-visited-font: @nord15;
   /// Header Colors
-  --color-header-background: #1e1e22;
-  --color-header-border: #333;
+  --color-header-background: @nord01;
+  --color-header-border: @nord1;
   /// Footer Colors
-  --color-footer-background: #1e1e22;
-  --color-footer-border: #333;
+  --color-footer-background: @nord0;
+  --color-footer-border: @nord1;
   /// Sidebar Colors
-  --color-sidebar-border: #555;
-  --color-sidebar-font: #fff;
-  --color-sidebar-background: #292c34;
+  --color-sidebar-border: @nord3;
+  --color-sidebar-font: var(--color-base-font);
+  --color-sidebar-background: @nord1;
   /// BackToTop Colors
-  --color-backtotop-font: #bbb;
-  --color-backtotop-border: #333;
-  --color-backtotop-background: #2b2e36;
+  --color-backtotop-font: @nord4;
+  --color-backtotop-border: @nord1;
+  --color-backtotop-background: @nord2;
   /// Button Colors
-  --color-btn-background: #58f;
-  --color-btn-font: #222;
-  --color-show-btn-background: #555;
-  --color-show-btn-font: #fff;
+  --color-btn-background: @nord9;
+  --color-btn-font: @nord6;
+  --color-show-btn-background: @nord3;
+  --color-show-btn-font: @nord5;
   /// Search Input Colors
-  --color-search-border: #555;
-  --color-search-shadow: 0 2px 8px rgb(34 38 46 / 25%);
-  --color-search-background: #2b2e36;
-  --color-search-font: #fff;
-  --color-search-background-hover: #58f;
+  --color-search-border: @nord3;
+  --color-search-shadow: 0 4px 16px
+    rgb(red(@nord0) green(@nord0) blue(@nord0) / 90%);
+  --color-search-background: @nord0;
+  --color-search-font: @nord5;
+  --color-search-background-hover: @nord9;
   /// Modal Colors
-  --color-error: #f55b5b;
-  --color-error-background: darken(#db3434, 40%);
-  --color-warning: #f1d561;
-  --color-warning-background: darken(#dbba34, 40%);
-  --color-success: #79f56e;
-  --color-success-background: darken(#42db34, 40%);
+  --color-error: @nord11;
+  --color-error-background: @nord2;
+  --color-warning: @nord12;
+  --color-warning-background: @nord2;
+  --color-success: @nord14;
+  --color-success-background: @nord2;
   /// Categories Colors
-  --color-categories-item-selected-font: #58f;
-  --color-categories-item-border-selected: #58f;
+  --color-categories-item-selected-font: @nord8;
+  --color-categories-item-border-selected: @nord8;
   /// Autocomplete Colors
-  --color-autocomplete-font: #fff;
-  --color-autocomplete-border: #555;
-  --color-autocomplete-shadow: 0 2px 8px rgb(34 38 46 / 25%);
-  --color-autocomplete-background: #2b2e36;
-  --color-autocomplete-background-hover: #1e1e22;
+  --color-autocomplete-font: @nord5;
+  --color-autocomplete-border: @nord3;
+  --color-autocomplete-shadow: 0 2px 8px
+    rgb(red(@nord0) green(@nord0) blue(@nord0) / 25%);
+  --color-autocomplete-background: @nord1;
+  --color-autocomplete-background-hover: @nord2;
   /// Answer Colors
-  --color-answer-font: #bbb; // same as --color-base-font
-  --color-answer-background: #26292f;
+  --color-answer-font: @nord4;
+  --color-answer-background: @nord1;
   // colors of the KeyValue result class
-  --color-result-keyvalue-col-table: #1e1e22;
-  --color-result-keyvalue-odd: #1e1e22;
-  --color-result-keyvalue-even: #26292f;
+  --color-result-keyvalue-col-table: @nord1;
+  --color-result-keyvalue-odd: @nord1;
+  --color-result-keyvalue-even: @nord0;
   /// Results Colors
-  --color-result-background: #26292f;
-  --color-result-border: #333;
-  --color-result-url-font: #fff;
-  --color-result-vim-selected: #1f1f23cc;
-  --color-result-vim-arrow: #8af;
-  --color-result-description-highlight-font: #fff;
-  --color-result-link-font: #8af;
-  --color-result-link-font-highlight: #8af;
-  --color-result-link-visited-font: #c09cd9;
-  --color-result-publishdate-font: #888;
-  --color-result-engines-font: #a4a4a4;
-  --color-result-search-url-border: #555;
-  --color-result-search-url-font: #fff;
-  /// Detail modal : same as the light version
-  --color-result-detail-font: #fff;
-  --color-result-detail-label-font: lightgray;
-  --color-result-detail-background: #1a1a1c;
-  --color-result-detail-hr: #555;
-  --color-result-detail-link: #8af;
-  --color-result-detail-loader-border: rgb(255 255 255 / 20%);
-  --color-result-detail-loader-borderleft: rgb(0 0 0 / 0%);
+  --color-result-background: @nord0;
+  --color-result-border: @nord1;
+  --color-result-url-font: @nord5;
+  --color-result-vim-selected: rgb(
+    red(@nord2) green(@nord2) blue(@nord2) / 80%
+  ); // nord2 with alpha
+
+  --color-result-vim-arrow: @nord9;
+  --color-result-description-highlight-font: @nord6;
+  --color-result-link-font: @nord8;
+  --color-result-link-font-highlight: @nord7;
+  --color-result-link-visited-font: @nord12;
+  --color-result-publishdate-font: var(--color-answer-font);
+  --color-result-engines-font: @nord8;
+  --color-result-search-url-border: @nord3;
+  --color-result-search-url-font: @nord5;
+  /// Detail modal
+  --color-result-detail-font: @nord5;
+  --color-result-detail-label-font: @nord4;
+  --color-result-detail-background: @nord0;
+  --color-result-detail-hr: @nord3;
+  --color-result-detail-link: @nord7;
+  --color-result-detail-loader-border: rgb(
+    red(@nord4) green(@nord4) blue(@nord4) / 20%
+  );
+  --color-result-detail-loader-borderleft: rgb(
+    red(@nord0) green(@nord0) blue(@nord0) / 0%
+  );
   // Images Colors
-  --color-result-image-span-font: #bbb;
-  --color-result-image-span-font-selected: #222;
-  --color-result-image-background: #222;
+  --color-result-image-span-font: @nord4;
+  --color-result-image-span-font-selected: @nord0;
+  --color-result-image-background: @nord0;
   /// Settings Colors
-  --color-settings-tr-hover: #2c2c32;
-  --color-settings-engine-description-font: darken(#dcdcdc, 30%);
-  --color-settings-table-group-background: #1b1b21;
+  --color-settings-tr-hover: @nord2;
+  --color-settings-engine-description-font: @nord4;
+  --color-settings-table-group-background: @nord1;
   /// Toolkit Colors
-  --color-toolkit-badge-font: #fff;
-  --color-toolkit-badge-background: #555;
-  --color-toolkit-kbd-font: #000;
-  --color-toolkit-kbd-background: #fff;
-  --color-toolkit-dialog-border: #555;
-  --color-toolkit-dialog-background: #1e1e22;
-  --color-toolkit-tabs-label-border: #222;
-  --color-toolkit-tabs-section-border: #555;
-  --color-toolkit-select-background: #313338;
-  --color-toolkit-select-border: #555;
-  --color-toolkit-select-background-hover: #373b49;
-  --color-toolkit-input-text-font: #fff;
-  --color-toolkit-checkbox-onoff-off-background: #313338;
-  --color-toolkit-checkbox-onoff-on-background: #313338;
-  --color-toolkit-checkbox-onoff-on-mark-background: #58f;
-  --color-toolkit-checkbox-onoff-on-mark-color: #222;
-  --color-toolkit-checkbox-onoff-off-mark-background: #ddd;
-  --color-toolkit-checkbox-onoff-off-mark-color: #222;
-  --color-toolkit-checkbox-label-background: #222;
-  --color-toolkit-checkbox-label-border: #333;
-  --color-toolkit-checkbox-input-border: #58f;
-  --color-toolkit-engine-tooltip-border: #333;
-  --color-toolkit-engine-tooltip-background: #222;
-  --color-toolkit-loader-border: rgb(255 255 255 / 20%);
-  --color-toolkit-loader-borderleft: rgb(0 0 0 / 0%);
-  --color-doc-code: #ddd;
-  --color-doc-code-background: #4d5a6f;
+  --color-toolkit-badge-font: @nord5;
+  --color-toolkit-badge-background: @nord3;
+  --color-toolkit-kbd-font: @nord0;
+  --color-toolkit-kbd-background: @nord5;
+  --color-toolkit-dialog-border: @nord3;
+  --color-toolkit-dialog-background: @nord1;
+  --color-toolkit-tabs-label-border: @nord0;
+  --color-toolkit-tabs-section-border: @nord3;
+  --color-toolkit-select-background: @nord2;
+  --color-toolkit-select-border: @nord3;
+  --color-toolkit-select-background-hover: @nord3;
+  --color-toolkit-input-text-font: @nord5;
+  --color-toolkit-checkbox-onoff-off-background: @nord2;
+  --color-toolkit-checkbox-onoff-on-background: var(--color-base-font);
+  --color-toolkit-checkbox-onoff-on-mark-background: var(--color-success);
+  --color-toolkit-checkbox-onoff-on-mark-color: @nord0;
+  --color-toolkit-checkbox-onoff-off-mark-background: var(--color-error);
+  --color-toolkit-checkbox-onoff-off-mark-color: @nord0;
+  --color-toolkit-checkbox-label-background: @nord1;
+  --color-toolkit-checkbox-label-border: @nord3;
+  --color-toolkit-checkbox-input-border: @nord9;
+  --color-toolkit-engine-tooltip-border: @nord1;
+  --color-toolkit-engine-tooltip-background: @nord2;
+  --color-toolkit-loader-border: rgb(
+    red(@nord4) green(@nord4) blue(@nord4) / 20%
+  );
+  --color-toolkit-loader-borderleft: rgb(
+    red(@nord0) green(@nord0) blue(@nord0) / 0%
+  );
+  --color-doc-code: @nord5;
+  --color-doc-code-background: @nord2;
   // Favicons Colors
-  --color-favicon-background-color: #ddd;
-  --color-favicon-border-color: #ccc;
+  --color-favicon-background-color: @nord4;
+  --color-favicon-border-color: @nord3;
 }
 
 .black-themes() {
   --color-base-background: #000;
   --color-base-background-mobile: #000;
   --color-header-background: #000;
   --color-footer-background: #000;
   --color-sidebar-background: #000;
+  --color-search-background: #000;
+  --color-autocomplete-background: #000;
+  --color-answer-background: #000;
+  --color-result-keyvalue-even: #000;
+  --color-result-background: #000;
+  --color-result-detail-background: #000;
+  --color-result-image-background: #000;
+  --color-toolkit-dialog-background: #000;
+  --color-toolkit-tabs-label-border: #000;
 }
 
-/// Dark Theme (autoswitch based on device pref)
 @media (prefers-color-scheme: dark) {
   :root.theme-auto {
     .dark-themes();
   }
 }
 
-// Dark Theme by preferences
 :root.theme-dark {
   .dark-themes();
 }
 
 :root.theme-black {
   .dark-themes();
   .black-themes();
 }
-
 /// General Size
 @results-width: 45rem;
 @results-sidebar-width: 25rem;
 @results-offset: 10rem;
 @results-tablet-offset: 0.5rem;
 @results-gap: 5rem;
 @results-margin: 0.125rem;
 @result-padding: 1rem;
-@results-image-row-height: 12rem;
+@results-image-row-height: 15.5rem;
 @results-image-row-height-phone: 10rem;
-@search-width: 44rem;
+@search-width: 52rem;
 // height of #search, see detail.less
 @search-height: 13rem;
 @search-padding-horizontal: 0.5rem;
 
 /// Device Size
 /// @desktop > @tablet
 @tablet: 79.75em; // see https://github.com/searxng/searxng/issues/874
 @phone: 50em;
 @small-phone: 35em;
 @ultra-small-phone: 20rem;
 
 /// From style.less
 @stacked-bar-chart: rgb(0, 0, 0);
 
 /// Load fonts from this directory.
 @icon-font-path: "../../../fonts/";
 //** File name for all font files.
 @icon-font-name: "glyphicons-halflings-regular";
 //** Element ID within SVG icon file.
 @icon-font-svg-id: "glyphicons_halflingsregular";
diff --git "a/c:\\Users\\cra88y\\Dev\\Repos\\simply-nord\\less-archive/detail.less" "b/c:\\Users\\cra88y\\Dev\\Repos\\simply-nord\\less-crab-nord/detail.less"
index b09052c..d2e33f5 100644
--- "a/c:\\Users\\cra88y\\Dev\\Repos\\simply-nord\\less-archive/detail.less"
+++ "b/c:\\Users\\cra88y\\Dev\\Repos\\simply-nord\\less-crab-nord/detail.less"
@@ -4,58 +4,57 @@
 
 #main_results #results.only_template_images.image-detail-open #backToTop {
   .ltr-left(56.75rem) !important;
   .ltr-right(inherit);
 }
 
 article.result-images .detail {
   display: none;
 }
 
 #results.image-detail-open article.result-images[data-vim-selected] .detail {
   display: flex;
   flex-direction: column;
   position: fixed;
   .ltr-left(60rem);
   .ltr-right(0);
   top: @search-height;
   transition: top 0.064s ease-in 0s;
   bottom: 0;
   background: var(--color-result-detail-background);
-  border: 1px solid var(--color-result-detail-background);
   z-index: 1000;
   padding: 4rem 3rem 3rem 3rem;
   overflow-y: scroll;
 
   a.result-images-source {
     display: block;
     flex: 1;
     text-align: left;
     width: 100%;
     border: none;
     text-decoration: none;
 
     img {
       padding: 0;
       margin: 0;
       border: none;
-      object-fit: contain;
+      object-fit: scale-down;
       width: inherit;
       height: inherit;
       max-width: 100%;
       min-height: inherit;
       max-height: calc(100vh - 25rem - 17rem);
       background: inherit;
     }
   }
 
   .result-images-labels {
     color: var(--color-result-detail-font);
     height: 19rem;
 
     hr {
       border-top: 1px solid var(--color-result-detail-hr);
       border-bottom: none;
     }
 
     h4 {
       height: 2rem;
@@ -164,41 +163,40 @@ article.result-images .detail {
     span::before {
       // vertical center small icons
       vertical-align: sub;
     }
   }
 
   a.result-detail-close,
   a.result-detail-close:visited,
   a.result-detail-close:hover,
   a.result-detail-close:active,
   a.result-detail-previous,
   a.result-detail-previous:visited,
   a.result-detail-previous:hover,
   a.result-detail-previous:active,
   a.result-detail-next,
   a.result-detail-next:visited,
   a.result-detail-next:hover,
   a.result-detail-next:active {
     color: var(--color-result-detail-font);
     background: var(--color-result-detail-background);
-    border: 1px solid var(--color-result-detail-font);
   }
 
   a.result-detail-close:focus,
   a.result-detail-close:hover,
   a.result-detail-previous:focus,
   a.result-detail-previous:hover,
   a.result-detail-next:focus,
   a.result-detail-next:hover {
     filter: opacity(80%);
   }
 
   .loader {
     position: absolute;
     top: 1rem;
     .ltr-right(50%);
     border-top: 0.5em solid var(--color-result-detail-loader-border);
     border-right: 0.5em solid var(--color-result-detail-loader-border);
     border-bottom: 0.5em solid var(--color-result-detail-loader-border);
     border-left: 0.5em solid var(--color-result-detail-loader-borderleft);
   }
diff --git "a/c:\\Users\\cra88y\\Dev\\Repos\\simply-nord\\less-archive/index.less" "b/c:\\Users\\cra88y\\Dev\\Repos\\simply-nord\\less-crab-nord/index.less"
index 6316b4e..9ed96e3 100644
--- "a/c:\\Users\\cra88y\\Dev\\Repos\\simply-nord\\less-archive/index.less"
+++ "b/c:\\Users\\cra88y\\Dev\\Repos\\simply-nord\\less-crab-nord/index.less"
@@ -1,51 +1,63 @@
 #main_index {
-  margin-top: 26vh;
+  margin-top: 33vh;
+}
+
+.index_endpoint {
+  background: var(--color-header-background);
 }
 
 .index {
   text-align: center;
 
   .title {
     background: url("../img/searxng.png") no-repeat;
     min-height: 4rem;
     margin: 4rem auto;
     background-position: center;
     background-size: contain;
   }
 
   h1 {
     font-size: 4em;
     visibility: hidden;
   }
 
   #search,
   #search_header {
     margin: 0 auto;
     background: inherit;
     border: inherit;
     padding: 0;
     display: block;
   }
 
   .search_filters {
     display: block;
     margin: 1em 0;
   }
 
   .category label {
     padding: 6px 10px;
     border-bottom: initial !important;
   }
 }
+// disabled for nord theme
+#language {
+  display: none;
+}
+
+#safesearch {
+  display: none;
+}
 
 @media screen and (max-width: @tablet) {
   div.title {
     h1 {
       font-size: 1em;
     }
   }
 
   #main_index {
     margin-top: 6em;
   }
 }
diff --git "a/c:\\Users\\cra88y\\Dev\\Repos\\simply-nord\\less-archive/mixins.less" "b/c:\\Users\\cra88y\\Dev\\Repos\\simply-nord\\less-crab-nord/mixins.less"
index a4bae71..1efd405 100644
--- "a/c:\\Users\\cra88y\\Dev\\Repos\\simply-nord\\less-archive/mixins.less"
+++ "b/c:\\Users\\cra88y\\Dev\\Repos\\simply-nord\\less-crab-nord/mixins.less"
@@ -1,39 +1,39 @@
 // SPDX-License-Identifier: AGPL-3.0-or-later
 
 // Mixins
 .text-size-adjust (@property: 100%) {
   -webkit-text-size-adjust: @property;
   -ms-text-size-adjust: @property;
   -moz-text-size-adjust: @property;
   text-size-adjust: @property;
 }
 
-.rounded-corners (@radius: 10px) {
+.rounded-corners (@radius: 50px) {
   border-radius: @radius;
 }
 
-.rounded-right-corners (@radius: 0 10px 10px 0) {
+.rounded-right-corners (@radius: 0 25px 25px 0) {
   border-radius: @radius;
 }
 
-.rounded-corners-tiny (@radius: 5px) {
+.rounded-corners-tiny (@radius: 25px) {
   border-radius: @radius;
 }
 
 // disable user selection
 .disable-user-select () {
   -webkit-touch-callout: none;
   user-select: none;
 }
 
 .show-content-button() {
   padding: 5px 10px;
   .rounded-corners-tiny;
   background: var(--color-show-btn-background);
   color: var(--color-show-btn-font);
   cursor: pointer;
 
   &:hover {
     background: var(--color-btn-background);
     color: var(--color-btn-font);
   }
diff --git "a/c:\\Users\\cra88y\\Dev\\Repos\\simply-nord\\less-archive/search.less" "b/c:\\Users\\cra88y\\Dev\\Repos\\simply-nord\\less-crab-nord/search.less"
index bc49ffa..170154a 100644
--- "a/c:\\Users\\cra88y\\Dev\\Repos\\simply-nord\\less-archive/search.less"
+++ "b/c:\\Users\\cra88y\\Dev\\Repos\\simply-nord\\less-crab-nord/search.less"
@@ -1,269 +1,282 @@
 /*
 * SearXNG, A privacy-respecting, hackable metasearch engine
 */
 
 #search {
   padding: 0;
   margin: 0;
 }
 
 #search_header {
-  padding-top: 1.5em;
+  padding-top: 1rem;
   .ltr-padding-right(2em);
   .ltr-padding-left(@results-offset - 3rem);
   margin: 0;
   background: var(--color-header-background);
-  border-bottom: 1px solid var(--color-header-border);
   display: grid;
-  gap: 1rem 1.2rem;
+  gap: 0.5rem;
   grid-template-columns: 3rem 1fr;
   grid-template-areas:
     "logo search"
     "spacer categories";
 }
 
 .category_checkbox,
 .category_button {
   display: inline-block;
   position: relative;
-  .ltr-margin-right(1rem);
+  //.ltr-margin-right(1rem);
   padding: 0;
 }
 
 .category_checkbox {
   input {
     display: none;
   }
 
   label {
     svg {
       padding-right: 0.2rem;
     }
 
     cursor: pointer;
     padding: 0.2rem 0;
     display: inline-flex;
     text-transform: capitalize;
     font-size: 0.9em;
     border-bottom: 2px solid transparent;
     .disable-user-select;
 
     div.category_name {
       margin: auto 0;
     }
+    &:active {
+      background-color: rgba(0, 0, 0, 0.05);
+      transition: 0s;
+    }
   }
 
   input[type="checkbox"]:checked + label {
     color: var(--color-categories-item-selected-font);
     border-bottom: 2px solid var(--color-categories-item-border-selected);
   }
 }
 
 button.category_button {
   background-color: inherit;
   color: var(--color-base-font);
   cursor: pointer;
-  padding: 0.2rem 0;
+  padding: 0.25rem 1rem 0.5rem 0.75rem;
   display: inline-flex;
   align-items: center;
-  text-transform: capitalize;
-  font-size: 0.9em;
+  text-transform: lowercase;
+  font-size: 1rem;
   border: none;
   border-bottom: 2px solid transparent;
 
   svg {
     padding-right: 0.2rem;
   }
 
-  &.selected,
+  &.selected {
+    color: var(--color-categories-item-selected-font);
+    border-bottom: 2px solid var(--color-categories-item-border-selected);
+  }
+
+  /* This is the state the INSTANT you touch it */
   &:active {
     color: var(--color-categories-item-selected-font);
     border-bottom: 2px solid var(--color-categories-item-border-selected);
+    background-color: rgba(0, 0, 0, 0.05); 
+    transition: 0s;
   }
 }
 
 // only used when JavaScript is disabled
 .no-js
   #categories_container:has(button.category_button:focus-within)
   button.category_button {
   &.selected {
     color: var(--color-base-font);
     border-bottom: none;
   }
 
   &:focus-within {
     color: var(--color-categories-item-selected-font);
     border-bottom: 2px solid var(--color-categories-item-border-selected);
   }
 }
 
 #search_logo {
   padding: 0.5rem 10px 0 10px;
   grid-area: logo;
   display: flex;
   align-items: center;
   justify-content: center;
+  filter: brightness(0.02) blur(1.5px);
 
   svg {
     flex: 1;
     width: 30px;
     height: 30px;
     margin: 0.5rem 0 auto 0;
   }
 }
 
 .search_categories {
   grid-area: categories;
 
   .help {
     display: none;
   }
 
   &:hover .help {
     display: block;
     position: absolute;
     background: var(--color-base-background);
     padding: 1rem 0.6rem 0.6rem 0;
     z-index: 1000;
     width: 100%;
     left: -0.1rem;
   }
 }
 
 #search_view {
   padding: 0.5rem @search-padding-horizontal 0 @search-padding-horizontal;
   grid-area: search;
 
   body.results_endpoint & {
     padding: 0.5rem 2.8rem 0 0;
   }
 }
 
 .search_box {
-  border-radius: 0.8rem;
+  border-radius: 50px;
   width: 100%;
   max-width: @search-width;
   display: inline-flex;
   flex-direction: row;
   white-space: nowrap;
   box-shadow: var(--color-search-shadow);
 }
 
 #clear_search {
   display: block;
   border-collapse: separate;
   box-sizing: border-box;
-  width: 1.8rem;
+  width: 2rem;
   margin: 0;
   padding: 0.8rem 0.2rem;
   background: none repeat scroll 0 0 var(--color-search-background);
   border: none;
   outline: none;
   color: var(--color-search-font);
   font-size: 1.1rem;
   z-index: 1000;
 
   &:hover {
     color: var(--color-search-background-hover);
   }
 
   &.empty * {
     display: none;
   }
 }
 
 html.no-js #clear_search.hide_if_nojs {
   display: none;
 }
 
 #q,
 #send_search {
   display: block;
   margin: 0;
-  padding: 0.8rem;
+  padding: 0.8rem 1rem;
   background: none repeat scroll 0 0 var(--color-search-background);
   border: none;
   outline: none;
   color: var(--color-search-font);
-  font-size: 1.1rem;
+  font-size: 1.125rem;
   z-index: 100;
 }
 
 #q {
   width: 100%;
   .ltr-padding-left(1rem);
   .ltr-padding-right(0) !important;
-  .ltr-rounded-left-corners(0.8rem);
+  border-top-left-radius: 50px;
 }
 
 #q::-ms-clear,
 #q::-webkit-search-cancel-button {
   display: none;
 }
 
 #send_search {
-  .ltr-rounded-right-corners(0.8rem);
-
+  padding-right: 1.5rem; 
+  .ltr-rounded-right-corners(0px);
+  border-top-right-radius: 50px;
   &:hover {
     cursor: pointer;
     background-color: var(--color-search-background-hover);
     color: var(--color-search-background);
   }
 }
 
 .no-js #clear_search,
 .no-js #send_search {
   width: auto !important;
   .ltr-border-left(1px solid var(--color-search-border));
 }
 
 .search_filters {
-  margin-top: 0.6rem;
+  margin-top: 0;
   .ltr-margin-right(0);
   margin-bottom: 0;
-  .ltr-margin-left(@results-offset + 0.6rem);
+  .ltr-margin-left(@results-offset + 0.25rem);
   display: flex;
   overflow-x: auto;
   overscroll-behavior-inline: contain;
+  -webkit-overflow-scrolling: touch;
+  scrollbar-width: none;
 
   select {
     background-color: inherit;
 
     &:hover,
     &:focus {
       color: var(--color-base-font);
     }
   }
 }
 
 @media screen and (max-width: @tablet) {
   #search_header {
     padding: 1.5em @results-tablet-offset 0 @results-tablet-offset;
     column-gap: @results-tablet-offset;
   }
 
   .search_filters {
-    margin-top: 0.6rem;
     .ltr-margin-right(0);
     margin-bottom: 0;
-    .ltr-margin-left(@results-tablet-offset + 3rem);
+    .ltr-margin-left(@results-tablet-offset);
   }
 
   #categories {
     font-size: 90%;
     clear: both;
   }
 }
 
 @media screen and (max-width: @tablet) and (hover: none) {
   #main_index,
   #main_results {
     #categories_container {
       width: max-content;
 
       .category_checkbox {
         display: inline-block;
         width: auto;
       }
     }
 
@@ -276,120 +289,93 @@ html.no-js #clear_search.hide_if_nojs {
   }
 }
 
 @media screen and (max-width: @phone) {
   #search_header {
     width: 100%;
     margin: 0;
     padding: 0.1rem 0 0 0;
     gap: 0 0;
     grid-template-areas:
       "logo search"
       "categories categories";
   }
 
   .search_logo {
     padding: 0;
   }
 
   .search_box {
     width: 100%;
+    max-width: 100%;
   }
 
   #q {
     width: 100%;
     flex: 1;
   }
 
-  .search_filters {
-    margin: 0 10px;
-    padding: 0.5rem 0;
-  }
-
   .category {
     display: inline-block;
     width: auto;
     margin: 0;
 
     svg {
       display: none;
     }
   }
 
   .category_checkbox {
     label {
-      padding: 1rem !important;
+      padding: 0.5rem 1rem !important;
       margin: 0 !important;
     }
   }
 
   .category_button {
-    padding: 1rem !important;
+    padding: 0.5rem 1rem !important;
     margin: 0 !important;
   }
 
   #search_view:focus-within {
     display: block;
-    background-color: var(--color-search-background);
+    background-color: var(--color-header-background);
     position: absolute;
     top: 0;
     height: 100%;
+    max-width: 100dvw;
     width: 100%;
     z-index: 2000;
+    padding: 0 !important;
+    box-sizing: border-box;
+    -webkit-overflow-scrolling: touch;
+    -ms-overflow-style: none; /* Internet Explorer 10+ */
+    scrollbar-width: none;
+    border-radius: 0 0 25px 25px;
+
+    &::-webkit-scrollbar {
+      display: none; /* Safari and Chrome */
+    }
 
     .search_box {
       border-bottom: 1px solid var(--color-search-border);
       width: 100%;
       border-radius: 0;
       box-shadow: none;
+      padding: 0;
 
       #send_search {
         .ltr-margin-right(0) !important; // Delete when send_search button is disabled on mobile.
       }
 
       * {
         border: none;
         border-radius: 0;
         box-shadow: none;
       }
     }
   }
 
   #main_results #q:placeholder-shown ~ #send_search {
-    .ltr-margin-right(2.6rem);
     transition: margin 0.1s;
   }
 }
-
-@media screen and (max-width: @ultra-small-phone) {
-  #search_header {
-    grid-template-areas:
-      "search search"
-      "categories categories";
-  }
-
-  #search_logo {
-    display: none;
-  }
-}
-
-#categories {
-  .disable-user-select;
-
-  &::-webkit-scrollbar {
-    width: 0;
-    height: 0;
-  }
-}
-
-#categories_container {
-  position: relative;
-}
-
-.favicon img {
-  height: 1.5rem;
-  width: 1.5rem;
-  border-radius: 10%;
-  background-color: var(--color-favicon-background-color);
-  border: 1px solid var(--color-favicon-border-color);
-  display: flex;
-}
diff --git "a/c:\\Users\\cra88y\\Dev\\Repos\\simply-nord\\less-archive/stats.less" "b/c:\\Users\\cra88y\\Dev\\Repos\\simply-nord\\less-crab-nord/stats.less"
index 1e823f7..561a939 100644
--- "a/c:\\Users\\cra88y\\Dev\\Repos\\simply-nord\\less-archive/stats.less"
+++ "b/c:\\Users\\cra88y\\Dev\\Repos\\simply-nord\\less-crab-nord/stats.less"
@@ -1,99 +1,98 @@
 // SPDX-License-Identifier: AGPL-3.0-or-later
 
 .engine-stats {
   border-spacing: 0;
   border-collapse: collapse;
 
   tr td,
   tr th {
-    border-bottom: 1px solid var(--color-result-border);
     padding: 0.25rem;
   }
 
   table.engine-tooltip {
     border-spacing: 0;
     border-collapse: collapse;
 
     td,
     th {
       border: none;
     }
   }
 
   .engine-name {
     width: 20rem;
   }
 
   .engine-score {
     width: 7rem;
     text-align: right;
   }
 
   .engine-reliability {
     text-align: right;
   }
 }
 
 table.engine-error th.engine-error-type,
 table.engine-error td.engine-error-type,
 failed-test {
   width: 10rem;
 }
 
 .engine-errors {
   margin-top: 3rem;
 
   table.engine-error {
     max-width: 1280px;
     margin: 1rem 0 3rem 0;
-    border: 1px solid var(--color-result-border);
     .ltr-text-align-left();
 
     tr th,
     tr td {
       padding: 0.5rem;
     }
 
     & span.log_parameters {
       border-right: 1px solid solid var(--color-result-border);
       padding: 0 1rem 0 0;
       margin: 0 0 0 0.5rem;
     }
   }
 }
 
 .bar-chart-value {
   width: 3em;
   display: inline-block;
   text-align: right;
   padding-right: 0.5rem;
 }
 
 .bar-chart-graph {
   width: calc(100% - 5rem);
   display: inline-block;
 }
 
 .bar-chart-bar {
   border: 3px solid var(--color-bar-chart-primary);
   margin: 1px 0;
+  border-radius: 50px;
 }
 
 .bar-chart-serie1 {
   border: 3px solid var(--color-bar-chart-primary);
   margin: 1px 0;
   float: left;
 }
 
 .bar-chart-serie2 {
   border: 3px solid var(--color-bar-chart-secondary);
   margin: 1px 0;
   float: left;
 }
 
 .bar0 {
   width: 0;
   border: 0;
 }
 
 .generate-bar(100);
diff --git "a/c:\\Users\\cra88y\\Dev\\Repos\\simply-nord\\less-archive/style.less" "b/c:\\Users\\cra88y\\Dev\\Repos\\simply-nord\\less-crab-nord/style.less"
index df7710b..2a6182c 100644
--- "a/c:\\Users\\cra88y\\Dev\\Repos\\simply-nord\\less-archive/style.less"
+++ "b/c:\\Users\\cra88y\\Dev\\Repos\\simply-nord\\less-crab-nord/style.less"
@@ -1,88 +1,118 @@
 /*
 * SearXNG, A privacy-respecting, hackable metasearch engine
 *
 * To convert "style.less" to "style.css" run: $make styles
 */
 
+/* Simply-Nord: Visual removals via CSS instead of template modification */
+footer,
+.link_on_top_about,
+.link_on_top_donate,
+#search_logo,
+.title h1,
+.dialog-warning-block {
+  display: none !important;
+}
+
+/* Hide placeholder text */
+#q::placeholder {
+  color: transparent;
+}
+
+/* Simply-Nord: Adjustments for removed header links */
+#link_on_top {
+  font-size: 1.25rem;
+}
+
 // stylelint-disable no-descending-specificity
 
 @import (inline) "../../node_modules/normalize.css/normalize.css";
 @import "definitions.less";
 @import "mixins.less";
 @import "code.less";
 @import "toolkit.less";
 @import "autocomplete.less";
 @import "detail.less";
 @import "animations.less";
 @import "embedded.less";
 @import "info.less";
 @import "new_issue.less";
 @import "stats.less";
 @import "result_templates.less";
 @import "weather.less";
 
 // for index.html template
 @import "index.less";
 
 // for preferences.html template
 @import "preferences.less";
 
 // Search-Field
 @import "search.less";
 
 // to center the results
 @import "style-center.less";
 
+button,
+input,
+optgroup,
+select,
+textarea {
+  line-height: 1.25;
+}
+
 // sxng-icon-set
 .sxng-icon-set {
   display: inline-block;
-  vertical-align: bottom;
+  vertical-align: middle;
   line-height: 1;
   text-decoration: inherit;
   .ltr-transform();
 }
 
 .sxng-icon-set-small {
   width: 1rem;
-  height: 1rem;
   .sxng-icon-set;
+  transform: scale(0.8);
 }
 
 .sxng-icon-set-big {
   width: 1.5rem;
   height: 1.5rem;
   .sxng-icon-set;
 }
 
 // Main LESS-Code
 html {
   font-family: sans-serif;
   font-size: 0.9em;
   .text-size-adjust;
-
   color: var(--color-base-font);
   background-color: var(--color-base-background);
   padding: 0;
   margin: 0;
-
   scroll-behavior: smooth;
+  line-height: 1.25;
+  -webkit-font-smoothing: antialiased;
+  text-rendering: optimizelegibility;
+  font-variant-numeric: proportional-nums;
 }
 
 body,
 main {
   padding: 0;
   margin: 0;
 }
 
 body {
   display: flex;
   flex-direction: column;
   height: 100vh;
   margin: 0;
 }
 
 @supports (height: 100dvh) {
   body {
     height: 100dvh;
   }
 }
@@ -103,226 +133,250 @@ footer {
   min-height: 4rem;
   padding: 1rem 0;
   width: 100%;
   text-align: center;
   background-color: var(--color-footer-background);
   border-top: 1px solid var(--color-footer-border);
   overflow: hidden;
 
   p {
     font-size: 0.9em;
   }
 }
 
 .page_with_header .logo {
   height: 40px;
 }
 
 input[type="submit"],
 #results button[type="submit"],
 .button {
-  padding: 0.7rem;
+  padding: 0.2rem;
   display: inline-block;
   background: var(--color-btn-background);
   color: var(--color-btn-font);
   .rounded-corners;
 
   border: 0;
   cursor: pointer;
 }
 
 a {
   text-decoration: none;
   color: var(--color-url-font);
 
   &:visited {
     color: var(--color-url-visited-font);
 
     .highlight {
       color: var(--color-url-visited-font);
     }
   }
 }
 
 article[data-vim-selected] {
   background: var(--color-result-vim-selected);
   .ltr-border-left(0.2rem solid var(--color-result-vim-arrow));
-  .ltr-rounded-right-corners(10px);
+  .rounded-corners(25px);
 }
 
 article.result-images[data-vim-selected] {
   background: var(--color-result-vim-arrow);
   border: none;
   .rounded-corners;
 
   .image_thumbnail {
     filter: opacity(60%);
   }
 
   span.title,
   span.source {
     color: var(--color-result-image-span-font-selected);
   }
 }
 
 article[data-vim-selected].category-videos,
 article[data-vim-selected].category-news,
 article[data-vim-selected].category-map,
 article[data-vim-selected].category-music,
 article[data-vim-selected].category-files,
 article[data-vim-selected].category-social {
-  border: 1px solid var(--color-result-vim-arrow);
-  .rounded-corners;
+  .rounded-corners();
 }
 
 .result {
-  margin: @results-margin 0;
-  padding: @result-padding;
+  padding: 0.5rem 1rem;
   box-sizing: border-box;
-  width: 100%;
-  .ltr-border-left(0.2rem solid transparent);
+  max-width: 100%;
+  min-width: 0;
+  .ltr-border-left(0rem solid transparent);
 
   h3 {
-    font-size: 1.2rem;
+    font-size: 1.125rem;
     word-wrap: break-word;
-    margin: 0.4rem 0 0.4rem 0;
+    margin: 0.125rem 0 0 0;
     padding: 0;
 
     a {
       color: var(--color-result-link-font);
       font-weight: normal;
       font-size: 1.1em;
 
       &:visited {
         color: var(--color-result-link-visited-font);
       }
 
       &:focus,
       &:hover {
         text-decoration: underline;
         border: none;
         outline: none;
       }
     }
   }
 
   .cache_link,
   .proxyfied_link {
-    font-size: smaller !important;
-    margin-left: 0.5rem;
+    font-size: 0.8rem;
+    margin-left: 0.25rem;
   }
 
   .content,
   .stat {
     font-size: 0.9em;
     margin: 0;
     padding: 0;
-    max-width: 54em;
+    max-width: 100%;
     word-wrap: break-word;
-    line-height: 1.24;
+    line-height: 1.25;
+    display: inline;
+    hyphens: auto;
+    overflow: hidden;
 
     .highlight {
       color: var(--color-result-description-highlight-font);
       background: inherit;
       font-weight: bold;
     }
   }
 
+  .altlink {
+    margin: 0.25rem !important;
+  }
+
   .altlink a {
-    font-size: 0.9em;
-    margin: 0 10px 0 0;
-    .show-content-button;
+    font-size: 1rem;
+    padding: 0.25rem 0.5rem;
+    border-radius: 50px;
+    background: var(--color-show-btn-background);
+    color: var(--color-show-btn-font);
+    cursor: pointer;
+    display: inline-block;
+
+    &:hover {
+      background: var(--color-btn-background);
+      color: var(--color-btn-font);
+    }
   }
 
   .codelines {
     .highlight {
       color: inherit;
       background: inherit;
       font-weight: normal;
     }
   }
 
   .url_header {
     display: flex;
     gap: 0.5rem;
   }
 
   .url_wrapper {
     display: flex;
     align-items: center;
-    font-size: 1rem;
+    font-size: 0.9rem;
     color: var(--color-result-url-font);
     flex-flow: row nowrap;
     overflow: hidden;
     margin: 0;
     padding: 0;
 
     .url_o1 {
       white-space: nowrap;
       flex-shrink: 1;
-      padding-bottom: 1px;
 
       .url_i1 {
         unicode-bidi: plaintext;
       }
     }
 
     .url_o1::after {
       content: " ";
       width: 1ch;
       display: inline-block;
     }
 
     .url_o2 {
       overflow: hidden;
       white-space: nowrap;
       flex: 0 1 content;
       text-align: right;
-      padding-bottom: 1px;
 
       .url_i2 {
         float: right;
       }
     }
   }
 
   .published_date,
   .result_length,
   .result_views,
   .result_author,
   .result_shipping,
   .result_source_country {
     font-size: 0.8em;
     color: var(--color-result-publishdate-font);
+    padding: 0.125rem 0;
+    padding-right: 0.5rem;
   }
 
   .result_price {
     font-size: 1.2em;
     color: var(--color-result-description-highlight-font);
   }
 
   img.thumbnail {
-    .ltr-float-left();
-    padding-top: 0.6rem;
-    .ltr-padding-right(1rem);
-    width: 7rem;
-    height: unset; // remove height value that was needed for lazy loading
+    float: right;
+    margin-top: 0.25rem;
+    margin-bottom: 0.25rem;
+    .ltr-margin-left(1rem);
+    border: none;
+    border-radius: 25px;
+    max-width: 45%;
+    max-height: 10rem;
+    min-width: 0;
+    min-height: 0;
+    object-fit: contain;
+    box-shadow: var(--color-search-shadow);
+    width: auto;
+    height: auto;
   }
 
   .break {
     clear: both;
   }
 }
 
 .result-paper,
 .result-packages {
   .attributes {
     display: table;
     border-spacing: 0.125rem;
 
     div {
       display: table-row;
 
       span {
         font-size: 0.9rem;
         margin-top: 0.25rem;
         display: table-cell;
@@ -362,370 +416,391 @@ article[data-vim-selected].category-social {
     margin-top: 0.3rem;
   }
 }
 
 .template_group_images {
   display: flex;
   flex-wrap: wrap;
 }
 
 .template_group_images::after {
   flex-grow: 10;
   content: "";
 }
 
 .category-videos,
 .category-news,
 .category-map,
 .category-music,
 .category-files,
 .category-social {
-  border: 1px solid var(--color-result-border);
-  margin: 0 @results-tablet-offset 1rem @results-tablet-offset !important;
   .rounded-corners;
 }
 
 .category-social .image {
   width: auto !important;
   min-width: 48px;
   min-height: 48px;
   padding: 0 5px 25px 0 !important;
 }
 
 .audio-control audio {
   width: 100%;
   padding: 10px 0 0 0;
 }
 
 .embedded-content iframe {
   width: 100%;
   padding: 10px 0 0 0;
 }
 
 .result-videos {
   img.thumbnail {
     .ltr-float-left();
-    padding-top: 0.6rem;
-    .ltr-padding-right(1rem);
-    width: 20rem;
+    .ltr-margin-left(0);
+    .ltr-margin-right(1rem);
     height: unset; // remove height value that was needed for lazy loading
+    max-width: 100%;
   }
 }
 
 .result-videos .content {
   overflow: hidden;
+  max-height: 5ch;
+  display: flow-root;
 }
 
 .result-videos .embedded-video iframe {
   width: 100%;
   aspect-ratio: 16 / 9;
   padding: 10px 0 0 0;
 }
 
 @supports not (aspect-ratio: 1 / 1) {
+
   // support older browsers which do not have aspect-ratio
   // https://caniuse.com/?search=aspect-ratio
   .result-videos .embedded-video iframe {
     height: calc(@results-width * 9 / 16);
   }
 }
 
 .engines {
+  filter: blur(0.5px);
+  text-align: end;
+  font-size: 0.9rem;
+  margin-top: 0.125rem;
+  width: 100%;
   .ltr-float-right();
-  display: flex;
   flex-wrap: wrap;
   justify-content: flex-end;
   color: var(--color-result-engines-font);
 
   span {
-    font-size: smaller;
+    font-size: 0.8rem;
     margin-top: 0;
     margin-bottom: 0;
-    .ltr-margin-right(0.5rem);
+    .ltr-margin-right(0.25rem);
     .ltr-margin-left(0);
   }
 }
 
 .small_font {
   font-size: 0.8em;
 }
 
 .highlight {
   color: var(--color-result-link-font-highlight);
   background: inherit;
 }
 
+.result div.highlight {
+  display: inline-block;
+}
+
 .empty_element {
   font-style: italic;
 }
 
 .result-images {
-  flex-grow: 1;
-  padding: 0.5rem 0.5rem 3rem 0.5rem;
-  margin: 0.25rem;
+  border-radius: 25px;
+  max-width: fit-content;
+  padding: 0.25rem;
   border: none !important;
-  height: @results-image-row-height;
-  width: unset;
 
   &>a {
     position: relative;
     outline: none;
+    display: grid;
+    grid-template-columns: max-content;
+    overflow: hidden;
   }
 
   img {
     margin: 0;
     padding: 0;
     border: none;
-    height: 100%;
-    width: auto;
-    object-fit: cover;
-    vertical-align: bottom;
-    background: var(--color-result-image-background);
+    height: @results-image-row-height;
+    border-radius: 25px;
+    width: fit-content;
+    object-fit: contain;
+    min-width: 0;
   }
 
   .image_resolution {
-    position: absolute;
-    right: 0;
-    bottom: 0;
-    background: var(--color-image-resolution-background);
-    padding: 0.3rem 0.5rem;
     font-size: 0.9rem;
-    color: var(--color-image-resolution-font);
-    border-top-left-radius: 0.3rem;
+    align-self: flex-start;
   }
 
   span.title,
   span.source {
-    display: block;
-    position: absolute;
-
-    width: 100%;
     font-size: 0.9rem;
     color: var(--color-result-image-span-font);
-    padding: 0.5rem 0 0 0;
+    padding: 0.125rem 0 0 0;
     overflow: hidden;
     text-overflow: ellipsis;
     white-space: nowrap;
+    width: 0;
+    min-width: 100%;
   }
 
   span.source {
-    padding: 1.8rem 0 0 0;
     font-size: 0.7rem;
   }
 }
 
 .result-map {
   img.image {
     .ltr-float-right() !important;
     height: 100px !important;
     width: auto !important;
   }
 
   table {
     font-size: 0.9em;
     width: auto;
     border-collapse: separate;
     border-spacing: 0 0.35rem;
 
     th {
       font-weight: inherit;
       width: 17rem;
       vertical-align: top;
       .ltr-text-align-left();
     }
 
     td {
       vertical-align: top;
       .ltr-text-align-left();
     }
   }
 }
 
 .hidden {
   display: none !important;
 }
 
 #results {
-  margin-top: 1rem;
-  .ltr-margin-right(2rem);
+  max-width: 100%;
+  margin-top: 0.125rem;
   margin-bottom: 0;
   .ltr-margin-left(@results-offset);
   display: grid;
   grid-template:
     "corrections sidebar" min-content
     "answers sidebar" min-content
     "urls sidebar" 1fr
     "pagination sidebar" min-content
     / @results-width @results-sidebar-width;
   gap: 0 @results-gap;
 }
 
 #results #sidebar *:first-child {
   margin-top: 0;
 }
 
 #urls {
   padding: 0;
   grid-area: urls;
 }
 
 #apis .wrapper {
   display: flex;
 }
 
 #suggestions {
+  display: flex;
+
   .wrapper {
     display: flex;
-    flex-flow: column;
-    justify-content: flex-end;
+    width: 100%;
+    text-align: left;
+    overflow: scroll;
+    -webkit-overflow-scrolling: touch;
+    -ms-overflow-style: none;
+    /* Internet Explorer 10+ */
+    scrollbar-width: none;
+    padding-bottom: 0.25rem;
+
+    &::-webkit-scrollbar {
+      display: none;
+      /* Safari and Chrome */
+    }
 
     form {
-      display: inline-block;
-      flex: 1 1 50%;
+      display: inline;
+      border-radius: 50px;
+      border: 0.125rem solid #0002;
+      background: var(--color-header-background);
+      padding: 0.125rem 0.5rem;
+      margin: 0.125rem;
     }
   }
 }
 
 #suggestions,
 #infoboxes {
+  ul {
+    padding: 0 1rem;
+  }
+
   input {
     padding: 0;
     margin: 3px;
     font-size: 0.9em;
-    display: inline-block;
+    display: inline;
     background: transparent;
-    color: var(--color-result-search-url-font);
+    color: @nord7;
+    border-radius: 0;
     cursor: pointer;
     width: calc(100%);
     text-overflow: ellipsis;
-    overflow: hidden;
+    overflow: scroll;
     text-align: left;
+    scrollbar-width: none;
+    text-decoration: none;
+  }
+
+  .infobox .url {
+    list-style: none;
   }
 
   input[type="submit"],
   .infobox .url a {
-    color: var(--color-result-link-font);
+    color: var(@nord7);
     text-decoration: none;
     font-size: 0.9rem;
-
-    &:hover {
-      text-decoration: underline;
-    }
+    list-style: none;
   }
 }
 
 #corrections {
   grid-area: corrections;
   display: flex;
   flex-flow: row wrap;
   margin: 0 0 1em 0;
 
   h4,
   input[type="submit"] {
     display: inline-block;
     padding: 0.5rem;
     margin: 0.5rem;
   }
 
   input[type="submit"] {
     font-size: 0.8rem;
     .rounded-corners-tiny;
   }
 }
 
 #infoboxes .title,
 #suggestions .title,
 #search_url .title,
 #engines_msg .title,
 #apis .title {
-  margin: 2em 0 0.5em 0;
+  margin: 0 0 0.25em 0.5rem;
   color: var(--color-base-font);
 }
 
 summary.title {
   cursor: pointer;
-  padding-top: 1em;
-}
-
-.sidebar-collapsible {
-  border-top: 1px solid var(--color-sidebar-border);
-  padding-bottom: 0.5em;
 }
 
 #sidebar-end-collapsible {
-  border-bottom: 1px solid var(--color-sidebar-border);
   width: 100%;
 }
 
 #answers {
   grid-area: answers;
-  background: var(--color-answer-background);
-  padding: @result-padding;
-  margin: 1rem 0;
-  margin-top: 0;
-  color: var(--color-answer-font);
-  .rounded-corners;
+  background: var(--color-header-background);
+  padding: 1.5rem;
+  margin: 0 0.5rem;
+  color: var(--color-base-font);
+  .rounded-corners(25px);
 
   h4 {
     display: none;
   }
 
   span {
     overflow-wrap: anywhere;
   }
 
   .answer {
     display: flex;
     flex-direction: column;
   }
 
   .answer-url {
-    margin: 5px 10px 10px auto;
+    text-align: end;
   }
 }
 
 #infoboxes {
   form {
     min-width: 210px;
   }
 }
 
 #sidebar {
   grid-area: sidebar;
   word-wrap: break-word;
   color: var(--color-sidebar-font);
 
   .infobox {
-    margin: 10px 0 10px;
-    border: 1px solid var(--color-sidebar-border);
-    padding: 1rem;
-    font-size: 0.9em;
-    .rounded-corners;
+    margin: 0.5rem 0;
+    border: none;
+    padding: 1.5rem;
+    font-size: 1em;
+    .rounded-corners(25px);
+    background: var(--color-header-background);
 
     h2 {
       margin: 0 0 0.5em 0;
     }
 
     img {
       max-width: 100%;
       max-height: 12em;
-      display: block;
+      justify-self: center;
+      .rounded-corners(25px);
+      display: flex;
       margin: 0 auto;
       padding: 0;
     }
 
     dt {
       font-weight: bold;
     }
 
     .attributes {
       dl {
         margin: 0.5em 0;
       }
 
       dt {
         display: inline;
         margin-top: 0.5em;
         .ltr-margin-right(0.25em);
         margin-bottom: 0.5em;
         .ltr-margin-left(0);
         padding: 0;
@@ -763,48 +838,48 @@ summary.title {
 
 #engines_msg {
   .engine-name {
     width: 10rem;
   }
 
   .response-error {
     color: var(--color-error);
   }
 
   .bar-chart-value {
     width: auto;
   }
 }
 
 #search_url {
   div.selectable_url {
     pre {
       float: left;
       width: 200em;
+      line-height: 1.25;
     }
   }
 
   button#copy_url {
     float: right;
     padding: 0.4rem;
     margin-left: 0.5rem;
-    border-radius: 0.3rem;
     display: none; // will be shown by JS.
   }
 }
 
 #links_on_top {
   position: absolute;
   .ltr-right(1rem);
   .ltr-text-align-right();
   top: 2.7rem;
   padding: 0;
   border: 0;
   display: flex;
   align-items: center;
   font-size: 1em;
   color: var(--color-search-font);
 
   a {
     display: flex;
     align-items: center;
     margin-left: 1em;
@@ -836,52 +911,52 @@ summary.title {
   display: flex;
   flex-direction: row;
   justify-content: center;
   align-items: center;
   overflow: hidden;
 }
 
 .page_number {
   background: transparent !important;
   color: var(--color-result-link-font) !important;
   text-decoration: underline;
 }
 
 .page_number_current {
   background: transparent;
   color: var(--color-result-link-visited-font);
   border: none;
 }
 
 #backToTop {
-  border: 1px solid var(--color-backtotop-border);
+  border: none;
   margin: 0;
   padding: 0;
   font-size: 1em;
-  background: var(--color-backtotop-background);
+  background: var(--color-header-background);
   position: fixed;
   bottom: 8rem;
   .ltr-left(@results-width + @results-offset + (0.5 * @results-gap - 1.2em));
-  transition: opacity 0.5s;
+  transition: opacity 0.2s;
   opacity: 0;
   pointer-events: none;
-  .rounded-corners;
+  .rounded-corners(50px);
 
   a {
     display: block;
     margin: 0;
     padding: 0.7em;
   }
 
   a,
   a:visited,
   a:hover,
   a:active {
     color: var(--color-backtotop-font);
   }
 }
 
 #results.scrolling #backToTop {
   opacity: 1;
   pointer-events: all;
 }
 
@@ -892,83 +967,81 @@ summary.title {
 .results-tablet() {
   #links_on_top {
     span {
       display: none;
     }
   }
 
   .page_with_header {
     margin: 2rem 0.5rem;
     width: auto;
   }
 
   #infoboxes {
     position: inherit;
     max-width: inherit;
 
     .infobox {
       clear: both;
 
       img {
-        .ltr-float-left();
-        max-width: 10em;
+        max-width: 16em;
         margin-top: 0.5em;
         .ltr-margin-right(0.5em);
         margin-bottom: 0.5em;
         .ltr-margin-left(0);
       }
     }
   }
 
   #sidebar {
     margin: 0 @results-tablet-offset @results-margin @results-tablet-offset;
     padding: 0;
     float: none;
     border: none;
     width: auto;
 
     input {
       border: 0;
     }
   }
 
   .result {
     .thumbnail {
-      max-width: 98%;
+      height: 9rem;
     }
 
     .url {
       span.url {
         display: block;
         white-space: nowrap;
         text-overflow: ellipsis;
         overflow: hidden;
         width: 100%;
       }
     }
 
     .engines {
       .ltr-float-right();
       display: flex;
       flex-wrap: wrap;
       justify-content: flex-end;
-      padding: 3px 0 0 0;
     }
   }
 
   .result-images {
     border-bottom: none !important;
   }
 
   .image_result {
     max-width: 98%;
 
     img {
       max-width: 98%;
     }
   }
 
   #backToTop {
     display: none;
   }
 
   #pagination {
@@ -984,150 +1057,163 @@ summary.title {
       "answers" min-content
       "sidebar" min-content
       "urls" 1fr
       "pagination" min-content
       / @results-width;
     gap: 0;
   }
 }
 
 @media screen and (width <=calc(@tablet - 0.5px)) {
   #links_on_top {
     span {
       display: none;
     }
   }
 }
 
 @media screen and (width <=52rem) {
   body.results_endpoint {
     #links_on_top {
+
       .link_on_top_about,
       .link_on_top_donate {
         display: none;
       }
     }
   }
 }
 
 @media screen and (min-width: @phone) and (max-width: @tablet) {
+
   // when .center-alignment-yes, see style-center.less
   // the media query includes "min-width: @phone"
   // because the phone layout includes the tablet layout unconditionally.
   .center-alignment-no {
     .results-tablet();
   }
 }
 
 /* Misc */
 
 #main_results div#results.only_template_images {
-  margin: 1rem @results-tablet-offset 0 @results-tablet-offset;
+  margin: 0 @results-tablet-offset 0 @results-tablet-offset;
   display: grid;
   grid-template:
     "corrections" min-content
     "answers" min-content
     "sidebar" min-content
     "urls" 1fr
     "pagination" min-content
     / 100%;
   gap: 0;
 
   #sidebar {
     display: none;
   }
 
   #urls {
     margin: 0;
     display: flex;
     flex-wrap: wrap;
+    justify-content: center;
   }
 
   #urls::after {
     flex-grow: 10;
     content: "";
   }
 
   #backToTop {
     .ltr-left(auto);
     .ltr-right(1rem);
   }
 
   #pagination {
     .ltr-margin-right(4rem);
   }
 }
 
 /*
   phone layout
 */
 
 @media screen and (max-width: @phone) {
+
+  select,
+  select:focus,
+  textarea,
+  textarea:focus,
+  input,
+  input:focus,
+  #q {
+    font-size: 16px !important;
+  }
+
   // based on the tablet layout
   .results-tablet();
 
   html {
     background-color: var(--color-base-background-mobile);
   }
 
   #main_results div#results {
     grid-template-columns: 100%;
     margin: 0 auto;
   }
 
   #links_on_top {
     top: 1.4rem;
     .ltr-right(10px);
   }
 
   #main_index #links_on_top {
     top: 0.5rem;
     .ltr-right(0.5rem);
   }
 
   #results {
     margin: 0;
     padding: 0;
   }
 
   #pagination {
     margin: 2rem 1rem 0 1rem !important;
   }
 
   article[data-vim-selected] {
-    border: 1px solid var(--color-result-vim-arrow);
     .rounded-corners;
   }
 
   .result {
     background: var(--color-result-background);
-    border: 1px solid var(--color-result-background);
-    margin: 1rem 2%;
-    width: 96%;
-    .rounded-corners;
   }
 
   .result-images {
-    margin: 0;
-    height: @results-image-row-height-phone;
-    background: var(--color-base-background-mobile);
-    width: unset;
+    img {
+      border: none;
+      width: 45vw;
+      border-radius: 25px;
+      height: fit-content;
+      object-fit: contain;
+      min-width: 0;
+    }
   }
 
   .infobox {
     border: none !important;
     background-color: var(--color-sidebar-background);
   }
 
   .numbered_pagination {
     display: none;
   }
 
   .result-paper,
   .result-packages {
     .attributes {
       display: block;
 
       div {
         display: block;
 
         span {
@@ -1140,31 +1226,31 @@ summary.title {
 
         span:nth-child(2) {
           .ltr-margin-left(0.5rem);
         }
       }
     }
   }
 }
 
 /*
   small-phone layout
 */
 
 @media screen and (max-width: @small-phone) {
   .result-videos {
     img.thumbnail {
       float: none !important;
     }
 
     .content {
-      overflow: inherit;
+      overflow: hidden;
     }
   }
 }
 
 pre code {
   white-space: pre-wrap;
 }
 
 // import layouts of the Result types
 @import "result_types/keyvalue.less";
\ No newline at end of file
diff --git "a/c:\\Users\\cra88y\\Dev\\Repos\\simply-nord\\less-archive/toolkit.less" "b/c:\\Users\\cra88y\\Dev\\Repos\\simply-nord\\less-crab-nord/toolkit.less"
index f9bdbf7..00ded31 100644
--- "a/c:\\Users\\cra88y\\Dev\\Repos\\simply-nord\\less-archive/toolkit.less"
+++ "b/c:\\Users\\cra88y\\Dev\\Repos\\simply-nord\\less-crab-nord/toolkit.less"
@@ -314,73 +314,72 @@ html body .tabs > input:checked {
     color: inherit;
 
     &:hover {
       border-bottom: 2px solid var(--color-categories-item-border-selected);
     }
   }
 
   + label {
     border-bottom: 2px solid var(--color-categories-item-border-selected);
     background: var(--color-categories-item-selected);
     color: var(--color-categories-item-selected-font);
   }
 
   + label + section {
     display: block;
   }
 }
 
 /* -- select -- */
 select {
-  height: 2.4rem;
   margin-top: 0;
   .ltr-margin-right(1rem);
   margin-bottom: 0;
   .ltr-margin-left(0);
-  padding: 0.2rem !important;
+  padding: 0.25rem 0.5rem !important;
   color: var(--color-search-font);
   font-size: 0.9rem;
   z-index: 100;
 
   &:hover,
   &:focus {
     cursor: pointer;
   }
 }
 
 @supports (
   (background-position-x: 100%) and
     (
       (appearance: none) or (-webkit-appearance: none) or
         (-moz-appearance: none)
     )
 ) {
   select {
     appearance: none;
     -webkit-appearance: none;
     -moz-appearance: none;
     border-width: 0 2rem 0 0;
     border-color: transparent;
     background: data-uri("image/svg+xml;charset=UTF-8", @select-light-svg-path)
       no-repeat;
     background-position-x: calc(100% + 2rem);
-    background-size: 2rem;
+    background-size: 1.5rem;
     background-origin: content-box;
     background-color: var(--color-toolkit-select-background);
     outline: medium none;
     text-overflow: ellipsis;
     .rounded-corners-tiny;
 
     &:hover,
     &:focus {
       background-color: var(--color-toolkit-select-background-hover);
     }
 
     option {
       background-color: var(--color-base-background);
     }
   }
 
   @media (prefers-color-scheme: dark) {
     html.theme-auto select,
     html.theme-dark select {
       background-image: data-uri(
