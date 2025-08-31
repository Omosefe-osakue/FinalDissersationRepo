(* Button panel for actions - place below the scrollable table *)
      val buttonBox = Box.new (Orientation.HORIZONTAL, SpacingScale.medium)
      val () = Widget.setMarginTop buttonBox SpacingScale.medium
      val () = Widget.setMarginBottom buttonBox SpacingScale.medium
      val () = Widget.setMarginStart buttonBox SpacingScale.medium
      val () = Widget.setMarginEnd buttonBox SpacingScale.medium
      val () = Box.packStart contentBox (buttonBox, false, false, 0)

      (* Add Inventory button *)
     (*val addBtn = Button.newWithLabel "Add Inventory Item"
      val _ = Widget.setSizeRequest addBtn (200, 0)
      val () = Box.packStart buttonBox (addBtn, false, false, 0)*)

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
      
      (* Create vertical centering box *)
      val verticalCenterBox = Box.new (Orientation.VERTICAL, 0)
      val () = Box.packStart formContainer (verticalCenterBox, true, true, 0)
      
      (* Add spacer at the top for vertical centering *)
      val () = Box.packStart verticalCenterBox (Box.new (Orientation.VERTICAL, 0), true, true, 0)
      
      (* Create horizontal centering box for the form *)
      val horizontalCenterBox = Box.new (Orientation.HORIZONTAL, 0)
      val () = Box.packStart verticalCenterBox (horizontalCenterBox, false, false, 0)
      
      (* Add spacer at the bottom for vertical centering *)
      val () = Box.packStart verticalCenterBox (Box.new (Orientation.VERTICAL, 0), true, true, 0)
      
      (* Add spacer on the left for horizontal centering *)
      val () = Box.packStart horizontalCenterBox (Box.new (Orientation.HORIZONTAL, 0), true, false, 0)
      
      (* Create the actual form box with proper spacing and padding *)
      val formBox = Box.new (Orientation.VERTICAL, SpacingScale.medium)
      val () = Container.setBorderWidth formBox SpacingScale.inset
      val () = Box.packStart horizontalCenterBox (formBox, false, false, 0)
      
      (* Add spacer on the right for horizontal centering *)
      val () = Box.packStart horizontalCenterBox (Box.new (Orientation.HORIZONTAL, 0), true, false, 0)
  
      (* Username field *)
      val usernameLabel = Label.new (SOME "Username:")
      val () = Widget.setHalign usernameLabel Align.START
      val () = Box.packStart formBox (usernameLabel, false, false, SpacingScale.xxsmall)
      
      val usernameEntry = Entry.new ()
      val () = Widget.setSizeRequest usernameEntry (200, 0)
      val () = Box.packStart formBox (usernameEntry, false, false, SpacingScale.xxsmall)
      
      (* Password field with consistent spacing *)
      val passwordLabel = Label.new (SOME "Password:")
      val () = Widget.setHalign passwordLabel Align.START 
      val () = Box.packStart formBox (passwordLabel, false, false, SpacingScale.xxsmall)
      
      val passwordEntry = Entry.new ()
      val () = Entry.setVisibility passwordEntry false
      val () = Widget.setSizeRequest passwordEntry (200, 0)
      val () = Box.packStart formBox (passwordEntry, false, false, SpacingScale.xxsmall)
      
      (* Login button with proper spacing above *)
      val loginButton = Button.newWithLabel "Login"
      val _ = Widget.setSizeRequest loginButton (180, 36)
      val buttonRow = CenterAlignedButtonRow.create [loginButton]
      val () = Box.packStart formBox (buttonRow, false, false, 0)

      (* Connect login button click event *)
      val _ = Signal.connect loginButton (Button.clickedSig, fn _ => 
      
        let
          val username = Entry.getText usernameEntry
          val password = Entry.getText passwordEntry
          val _ = print ("Login attempt: " ^ username ^ "\n")
          
          val loginSuccess = authenticate (username, password) 
          
          val () = if loginSuccess then
            (   
              (* Set the current user in the application state *)
              AppState.setCurrentUser username;
              
              (* Navigate to the dashboard page *)
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
  
  (* Apply the BasePage functor here, outside the create function *)
  structure LoginPageBase = BasePage(struct val title = "Login" val menuItems = NONE end)

  (* Create the complete login page with BasePage integration *)
  fun create {stack: Gtk.Stack.t} =
    let
      open Gtk
      
      (* Create the base page and get both the main box and content box *)
      val (basePage, contentBox) = LoginPageBase.create{ stack = stack, menuItems = NONE }
      
      (* Create login form *)
      val loginForm = createLoginForm stack
      
      (* Add login form to the content box directly *)
      val () = Box.packStart contentBox (loginForm, true, true, 0)
    in
      (* Return the main basePage box *)
      basePage 
    end
end

  val mainBox = Box.new (Orientation.VERTICAL, 0)

      val username = if Inputs.title = "Login" 
                     then NONE
                     else SOME AppState.getCurrentUser()