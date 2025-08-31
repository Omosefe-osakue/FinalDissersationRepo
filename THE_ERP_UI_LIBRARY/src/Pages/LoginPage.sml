(******************************************************************************
 * LoginPage.sml: Implements the ERP login page with authentication logic and form UI.
 *
 * This module defines the LoginPage structure, which provides a login form for user
 * authentication in the ERP system. It uses the BasePage layout and integrates with
 * AppState for session management. Error handling and user feedback are provided.
 *
 * Intended Usage:
 *   - Use LoginPage.create {stack, menuItems} to instantiate the login page.
 *   - Handles user authentication and navigation upon successful login.
 *

 *
 * Author: Omosefe Osakue
 * Date: 2025-05-09
 *******************************************************************************)

(* Import required modules *)
use "../Tokens/SpacingScale.sml";
use "../Tokens/FontSize.sml";
use "../LayoutComponents/AppState.sml";
use "../LayoutComponents/ButtonActionRow.sml";
use "../LayoutComponents/ErrorDialog.sml";
use "BasePage.sml";  

structure LoginPage = struct

  val validUsers = [("admin", "password")]

  fun authenticate (username, password) =
    List.exists (fn (u, p) => u = username andalso p = password) validUsers

  (* Create login form content *)
  fun createLoginForm (stack: Gtk.Stack.t) =
    let
      open Gtk
      
      (* Create form container *)
      val formContainer = Box.new (Orientation.VERTICAL, 0)
      
      val verticalCenterBox = Box.new (Orientation.VERTICAL, 0)
      val () = Box.packStart formContainer (verticalCenterBox, true, true, 0)
      
      val () = Box.packStart verticalCenterBox (Box.new (Orientation.VERTICAL, 0), true, true, 0)
      
      val horizontalCenterBox = Box.new (Orientation.HORIZONTAL, 0)
      val () = Box.packStart verticalCenterBox (horizontalCenterBox, false, false, 0)
      
      val () = Box.packStart verticalCenterBox (Box.new (Orientation.VERTICAL, 0), true, true, 0)
      
      val () = Box.packStart horizontalCenterBox (Box.new (Orientation.HORIZONTAL, 0), true, false, 0)
      
      val formBox = Box.new (Orientation.VERTICAL, SpacingScale.medium)
      val () = Container.setBorderWidth formBox SpacingScale.inset
      val () = Box.packStart horizontalCenterBox (formBox, false, false, 0)
      
      val () = Box.packStart horizontalCenterBox (Box.new (Orientation.HORIZONTAL, 0), true, false, 0)
  
      val usernameLabel = Label.new (SOME "Username:")
      val () = Widget.setHalign usernameLabel Align.START
      val () = Box.packStart formBox (usernameLabel, false, false, SpacingScale.xxsmall)
      
      val usernameEntry = Entry.new ()
      val () = Widget.setSizeRequest usernameEntry (200, 0)
      val () = Box.packStart formBox (usernameEntry, false, false, SpacingScale.xxsmall)
      
      val passwordLabel = Label.new (SOME "Password:")
      val () = Widget.setHalign passwordLabel Align.START 
      val () = Box.packStart formBox (passwordLabel, false, false, SpacingScale.xxsmall)
      
      val passwordEntry = Entry.new ()
      val () = Entry.setVisibility passwordEntry false
      val () = Widget.setSizeRequest passwordEntry (200, 0)
      val () = Box.packStart formBox (passwordEntry, false, false, SpacingScale.xxsmall)
      
      val loginButton = Button.newWithLabel "Login"
      val _ = Widget.setSizeRequest loginButton (180, 36)
      val buttonRow = CenterAlignedButtonRow.create [loginButton]
      val () = Box.packStart formBox (buttonRow, false, false, 0)

      val _ = Signal.connect loginButton (Button.clickedSig, fn _ => 
      
        let
          val username = Entry.getText usernameEntry
          val password = Entry.getText passwordEntry
          val _ = print ("Login attempt: " ^ username ^ "\n")
          
          val loginSuccess = authenticate (username, password) 
          
          val () = if loginSuccess then
            (   
              AppState.setCurrentUser username;
              Stack.setVisibleChildName stack "dashboard";
              print "Navigating to Dashboard...\n"
            )
          else 
            (
              ErrorDialog.create {
                title = "Login Error",
                message = "Invalid username or password."
              }
            )
        in
          ()
        end)


    in
      formContainer
    end
  (*Create the base page here outside the create function*)
  structure LoginPageBase = BasePage(struct val title = "Login" val menuItems = NONE end)

  fun create {stack: Gtk.Stack.t} =
    let
      open Gtk
      
      val (basePage, contentBox) = LoginPageBase.create{ stack = stack, menuItems = NONE }
      
      val loginForm = createLoginForm stack
      
      val () = Box.packStart contentBox (loginForm, true, true, 0)
    in
      basePage 
    end
end 