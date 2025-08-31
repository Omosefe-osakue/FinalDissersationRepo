(******************************************************************************
 * CssLoader.sml: Provides utilities for loading and applying CSS styles to GTK widgets.
 *
 * This module defines the CssLoader structure, which allows you to load global CSS
 * stylesheets and apply CSS classes to GTK widgets for consistent UI theming.
 *
 * Intended Usage:
 *   - Use CssLoader.loadStyles path to load a CSS stylesheet globally.
 *   - Use CssLoader.addClassToWidget widget className to add a CSS class to a widget.
 *
 * Dependencies:
 *   - Gtk (for UI components)
 *   - Gdk (for display/screen management)
 *   - GLib (for error handling)
 *   - GiraffeLog (for logging)
 *
 * Author: Omosefe Osakue
 * Date: 2025-05-09
 *******************************************************************************)

structure CssLoader = struct
  open Gtk

  (* Function to load CSS styles globally *)
  fun loadStyles cssPath =
    let
      val cssProvider = CssProvider.new()
      val displayOpt = Gdk.Display.getDefault()
      val screen = case displayOpt of
                     SOME display => Gdk.Display.getDefaultScreen display
                   | NONE => raise Fail "Could not get default display"
    in
      CssProvider.loadFromPath cssProvider cssPath;
      StyleContext.addProviderForScreen
        (screen, CssProvider.asStyleProvider cssProvider, STYLE_PROVIDER_PRIORITY_USER)
        handle
          GLib.Error (_, error) => GiraffeLog.critical (#get GLib.Error.message error)
    end

  (* Helper function to add a CSS class to a widget *)
  fun addClassToWidget widget className =
    let
      val context = Widget.getStyleContext widget
    in
      StyleContext.addClass context className
    end
end