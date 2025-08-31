use "src/Tokens/FontSize.sml";
use "src/LayoutComponents/Footer.sml";
use "src/LayoutComponents/Header.sml";
use "src/LayoutComponents/ErrorDialog.sml";
use "src/Pages/LoginPage.sml";
use "src/Pages/BasePage.sml";
use "src/Pages/DashboardPage.sml";
use "src/Pages/InventoryPage.sml";
use "src/Pages/SettingsPage.sml";
use "src/Pages/SalesOrderPage.sml";
use "src/Tokens/Theme.sml";  (* Add Theme import *)
use "src/LayoutComponents/AppState.sml";
use "src/Tokens/CssLoader.sml";
use "src/LayoutComponents/ButtonActionRow.sml";


(* Main application code *)
fun activate app () =
  let
    open Gtk
    (* Create window *)
    val window = ApplicationWindow.new app
    val () = Theme.applyCss ()
    val () = Window.setTitle window "ERP System Login"
    val () = Window.setDefaultSize window (1000, 1000)
    val () = Container.setBorderWidth window 20
       
    (* Apply CSS classes to window *)
    val () = CssLoader.addClassToWidget window "app-window"

    (* Create main box *)
    val mainBox = Box.new (Orientation.VERTICAL, 5)
    val () = Container.add window mainBox
    val () = CssLoader.addClassToWidget mainBox "main-container"

    (* Add content box *)
    val contentBox = Box.new (Orientation.VERTICAL, 40)
    val () = CssLoader.addClassToWidget contentBox "content-box"
    val () = Box.packStart mainBox (contentBox, true, true, 0)

    (* Create page stack before using it *)
    val pageStack = Stack.new ()

    (* Create and add login page *)
    val loginPage = LoginPage.create {stack = pageStack}
    val () = Stack.addNamed pageStack (loginPage, "login")
    
    (* Create and add dashboard page *)
    val dashboardPage = DashboardPage.create { 
      stack = pageStack,
      menuItems = SOME [
        ("Dashboard", "dashboard"),
        ("Inventory", "inventory"),
        ("Settings", "settings"),
        ("Logout", "login")
      ]
    }
    val () = Stack.addNamed pageStack (#1 dashboardPage, "dashboard")
    
    (* Create and add inventory page *)
    val inventoryPage = InventoryPage.create {
      stack = pageStack,
      menuItems = SOME [
        ("Dashboard", "dashboard"),
        ("Inventory", "inventory"),
        ("Settings", "settings"),
        ("Logout", "login")
      ]
    }
    val () = Stack.addNamed pageStack (#1 inventoryPage, "inventory")
    
    (* Create and add settings page *)
    val settingsPage = SettingsPage.create {
      stack = pageStack,
      menuItems = SOME [
        ("Dashboard", "dashboard"),
        ("Inventory", "inventory"),
        ("Settings", "settings"),
        ("Logout", "login")
      ]
    }
    val () = Stack.addNamed pageStack (#1 settingsPage, "settings")
    
    (* Create and add sales order page *)
    val salesOrderPage = SalesOrderPage.create {
      stack = pageStack,
      menuItems = SOME [
        ("Dashboard", "dashboard"),
        ("Inventory", "inventory"),
        ("Settings", "settings"),
        ("Logout", "login")
      ]
    }
    val () = Stack.addNamed pageStack (#1 salesOrderPage, "salesorder")
    
    (* Set initial page to login *)
    val () = Stack.setVisibleChildName pageStack "login"
    
    val () = Box.packStart contentBox (pageStack, true, true, 0)

    (* Show window *)
    val () = Theme.setTheme (window, "dark")
    val () = Widget.showAll window
  in
    ()
  end

fun main () =
  let
    val app = Gtk.Application.new (SOME "org.gtk.example", Gio.ApplicationFlags.FLAGS_NONE)
    val id = Signal.connect app (Gio.Application.activateSig, activate app)

    val argv = Utf8CPtrArrayN.fromList (CommandLine.name () :: CommandLine.arguments ())
    val status = Gio.Application.run app argv

    val () = Signal.handlerDisconnect app id
  in
    Giraffe.exit status
  end
    handle e => Giraffe.error 1 ["Uncaught exception\n", exnMessage e, "\n"]