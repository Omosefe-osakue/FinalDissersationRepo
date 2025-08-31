(* Theme management for the application *)
structure Theme = struct
  open Gtk

  (* Apply the CSS theme from file *)
  fun applyCss () =
    let
      val screen = Gdk.Screen.getDefault ()
      val cssProvider = CssProvider.new ()
      val _ = CssProvider.loadFromPath cssProvider "src/Tokens/style.css"
      val () = StyleContext.addProviderForScreen
                (Option.valOf screen, CssProvider.asStyleProvider cssProvider, STYLE_PROVIDER_PRIORITY_USER)
    in
      ()
    end
    handle
      Option => GiraffeLog.critical "Error: could not get screen\n"
      | GLib.Error (_, error) => GiraffeLog.critical (#get GLib.Error.message error)
  
  (* Change the current theme by adding/removing theme classes *)
  fun setTheme (window, theme : string) =
    let
      val styleContext = Widget.getStyleContext window
      val () = StyleContext.removeClass styleContext "light"
      val () = StyleContext.removeClass styleContext "dark"
      val () = StyleContext.removeClass styleContext "pastel"
      val () = StyleContext.addClass styleContext theme
    in
      ()
    end
end