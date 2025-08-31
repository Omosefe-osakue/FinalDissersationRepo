use "$(GIRAFFE_SML_LIB)/general/polyml.sml";
use "$(GIRAFFE_SML_LIB)/ffi/polyml.sml";
use "$(GIRAFFE_SML_LIB)/gir/polyml.sml";
use "$(GIRAFFE_SML_LIB)/glib-2.0/polyml.sml";
use "$(GIRAFFE_SML_LIB)/gobject-2.0/polyml.sml";
use "$(GIRAFFE_SML_LIB)/gio-2.0/polyml.sml";
use "$(GIRAFFE_SML_LIB)/gmodule-2.0/polyml.sml";
use "$(GIRAFFE_SML_LIB)/cairo-1.0/polyml.sml";
use "$(GIRAFFE_SML_LIB)/pango-1.0/polyml.sml";
use "$(GIRAFFE_SML_LIB)/pangocairo-1.0/polyml.sml";
use "$(GIRAFFE_SML_LIB)/gdkpixbuf-2.0/polyml.sml";
use "$(GIRAFFE_SML_LIB)/atk-1.0/polyml.sml";
use "$(GIRAFFE_SML_LIB)/gdk-3.0/polyml.sml";
use "$(GIRAFFE_SML_LIB)/xlib-2.0/polyml.sml";
use "$(GIRAFFE_SML_LIB)/gtk-3.0/polyml.sml";

(* --- ErpUI Library --- *)
(* Tokens *)
use "src/Tokens/FontSize.sml";
use "src/Tokens/SpacingScale.sml";
use "src/Tokens/CssLoader.sml";

(*-------- Utils --------*)
use "src/Utils/TableUtils.sml";
use "src/Utils/ImageUtils.sml";

(* Core App State *)
use "src/LayoutComponents/AppState.sml";

(* Theme *)
use "src/Tokens/CssLoader.sml";

(* Layout Components *)
use "src/LayoutComponents/Header.sml";
use "src/LayoutComponents/Footer.sml";
use "src/LayoutComponents/ErrorDialog.sml";
use "src/LayoutComponents/ButtonActionRow.sml";

(* Base Page *)
use "src/Pages/BasePage.sml";

(* Dashboard Components *)
use "src/DashboardComponents/KPICard.sml";
use "src/DashboardComponents/ContentPanel.sml";

(* --- ErpUI Pages --- *)
use "src/Pages/LoginPage.sml";
use "src/Pages/DashboardPage.sml";
use "src/Pages/SettingsPage.sml";
use "src/Pages/InventoryPage.sml";
use "src/Pages/SalesOrderPage.sml";

