(******************************************************************************
 * SettingsPage.sml: Implements the ERP application settings page for user preferences.
 *
 * This module defines the SettingsPage structure, which uses the BasePage functor
 * to provide a standardized layout (header, footer, menu bar) and adds settings-
 * specific content such as application preferences and theme controls.
 *
 * Intended Usage:
 *   - Use SettingsPage.create {stack, menuItems} to instantiate the settings page.
 *   - Integrates with the navigation stack and menu system.
 *
 * Dependencies:
 *   - BasePage (for layout)
 *   - Theme (for theme controls)
 *   - AppState (for application state)
 *   - Gtk (for UI components)
 *
 * Author: Omosefe Osakue
 * Date: 2025-05-09
 *******************************************************************************)

(* Import required modules *)
use "BasePage.sml";
use "../Tokens/SpacingScale.sml";
use "../Tokens/Theme.sml";
use "../LayoutComponents/AppState.sml";

structure SettingsPage :> PAGE = struct
  structure Gtk = Gtk
  open Gtk
  
  structure SettingsBase = BasePage(struct val title = "Settings" end)
  
  fun create {stack : Gtk.Stack.t, menuItems : (string * string) list option} =
    let
      val (mainBox, contentBox) = SettingsBase.create {stack = stack, menuItems = menuItems}
      
      val settingsContainer = Box.new (Orientation.VERTICAL, SpacingScale.medium)
      val () = Container.setBorderWidth settingsContainer SpacingScale.medium
      val () = Widget.setHalign settingsContainer Align.CENTER
      val () = Widget.setHexpand settingsContainer true
      
      val headerLabel = Label.new (SOME "Application Settings")
      val () = Widget.setHalign headerLabel Align.START
      val () = Label.setMarkup headerLabel "<span font_weight='bold' font_size='large'>Application Settings</span>"
      val () = Box.packStart settingsContainer (headerLabel, false, false, SpacingScale.small)
      
      val descriptionLabel = Label.new (SOME "Customize the application appearance")
      val () = Widget.setHalign descriptionLabel Align.START
      val () = Box.packStart settingsContainer (descriptionLabel, false, false, SpacingScale.xsmall)
      
      val separator = Separator.new Orientation.HORIZONTAL
      val () = Box.packStart settingsContainer (separator, false, false, SpacingScale.medium)
      
      val themeBox = Box.new (Orientation.VERTICAL, SpacingScale.small)
      val () = Container.setBorderWidth themeBox SpacingScale.small
      
      val themeLabel = Label.new (SOME "Color Theme")
      val () = Widget.setHalign themeLabel Align.START
      val () = Label.setMarkup themeLabel "<span font_weight='bold'>Color Theme</span>"
      val () = Box.packStart themeBox (themeLabel, false, false, SpacingScale.xsmall)
      
      val buttonsBox = Box.new (Orientation.VERTICAL, SpacingScale.xsmall)
      val () = Container.setBorderWidth buttonsBox SpacingScale.small
      
      val lightButton = Button.newWithLabel "Light Theme"
      val darkButton = Button.newWithLabel "Dark Theme"
      val pastelButton = Button.newWithLabel "Pastel Theme"
      
      val _ = Signal.connect lightButton (Button.clickedSig, fn () => 
        let 
          val () = print "Setting Light Theme\n"
        in () end)
        
      val _ = Signal.connect darkButton (Button.clickedSig, fn () => 
        let 
          val () = print "Setting Dark Theme\n"
        in () end)
        
      val _ = Signal.connect pastelButton (Button.clickedSig, fn () => 
        let 
          val () = print "Setting Pastel Theme\n"
        in () end)
      
      val () = Box.packStart buttonsBox (lightButton, false, false, 0)
      val () = Box.packStart buttonsBox (darkButton, false, false, 0)
      val () = Box.packStart buttonsBox (pastelButton, false, false, 0)
      
      val () = Box.packStart themeBox (buttonsBox, false, false, 0)
      val () = Box.packStart settingsContainer (themeBox, false, false, 0)
      
      val () = Container.add contentBox settingsContainer
    in
      (mainBox, contentBox)
    end
end
