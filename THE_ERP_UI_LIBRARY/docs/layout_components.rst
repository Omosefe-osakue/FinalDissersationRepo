Layout Components
=================

Overview
--------

Layout components form the structural foundation of the ERP UI Library. These components handle the overall application structure, including headers, footers, navigation systems, and dialog boxes. They provide a consistent framework for organizing content and maintaining a coherent user experience.

Unlike object-oriented UI frameworks, the layout components in this library use functional programming principles to maintain clean separation of concerns, avoid mutable state, and enable easy composition.

Header Component
----------------

The ``Header`` component creates a consistent application header with support for branding, navigation, and user information.

.. code-block:: sml

  (* Header: Displays the company logo, name, and username at the top of the UI. *)
  structure Header = struct
    fun create {imagePath : string option, text : string, username : string option} =
      let
        open Gtk
        val containerBox = Box.new (Orientation.VERTICAL, 0)
        val headerBox = Box.new (Orientation.HORIZONTAL, 10)
        val () = Widget.setSizeRequest headerBox (1000, 60)
        
        (* Add logo *)
        val () = case imagePath of
            SOME path =>
              let
                val logoBox = Box.new (Orientation.HORIZONTAL, 0)
                val () = Box.packStart headerBox (logoBox, false, false, 10)
                
                val aspectFrame = AspectFrame.new (NONE, 0.0, 0.5, 1.0, false)
                val image = ImageUtils.scaledImageFromFile (path, (36, 36))
                val () = Container.add aspectFrame image
                val () = Box.packStart logoBox (aspectFrame, false, false, 0)
              in
                ()
              end
          | NONE => ()
      

        val spacer1 = Box.new (Orientation.HORIZONTAL, 0)
        val () = Box.packStart headerBox (spacer1, true, true, 0)
        
        val label = Label.new (SOME text)
        val () = Widget.setName label "company_name"
        val () = FontSize.h4 label text
        val () = Box.packStart headerBox (label, false, false, 20)

        val spacer2 = Box.new (Orientation.HORIZONTAL, 0)
        val () = Box.packStart headerBox (spacer2, true, true, 0)

        (* Adds username if provided *)
        val () = case username of
          SOME name =>
            let
              val userLabel = Label.new (SOME name) 
              val () = Widget.setName userLabel "username"
              val () = FontSize.h4 userLabel name
              val () = Box.packEnd headerBox (userLabel, false, false, 20)
            in
              ()
            end
        | NONE => ()
        
        val () = Box.packStart containerBox (headerBox, false, false, 10)

        val separator = Separator.new Orientation.HORIZONTAL
        val () = Box.packStart containerBox (separator, false, true, 0)
      in
        containerBox
      end
  end

.. code-block:: sml

    (* Create a basic header with company name and user *)
    val headerWidget = Header.create {
        imagePath = SOME "resources/images/logo.png",  
        text = Inputs.title,            
        username = username     
    }

    (* Create a minimal header with just company name *)
    val minimalHeader = Header.create {
      imagePath = NONE, 
      text = Inputs.title,
      username = NONE
    }

    (* Add the header to the main box *)
    val () = Box.packStart mainBox (headerWidget, false, false, 0)

Key Features:

- **Logo Integration**: Optional company logo display
- **Company Name**: Prominently displays the application or company name
- **User Information**: Optional username display
- **Styling**: Consistent styling using the design token system
- **Separation**: Visual separator at bottom for clear content distinction

Implementation Highlights:

- **Pure Function**: The ``create`` function takes configuration parameters and returns a new widget without modifying external state
- **Pattern Matching**: Uses SML's pattern matching to handle optional fields like imagePath and username
- **Immutability**: Treats all UI elements as immutable values, reflecting functional programming principles

Footer Component
----------------

The ``Footer`` component provides a consistent application footer with copyright information, links, and auxiliary content.

.. code-block:: sml

  (* Footer: Displays copyright and version information at the bottom of the UI. *)
  structure Footer = struct
    fun create {copyright, version} =
      let
        open Gtk
        val containerBox = Box.new (Orientation.VERTICAL, 0)
        
        val separator = Separator.new Orientation.HORIZONTAL
        val () = Box.packStart containerBox (separator, false, true, 0)

        val footerBox = Box.new (Orientation.VERTICAL, 5)
        
        val copyrightLabel = Label.new (SOME copyright)
        val () = Widget.setName copyrightLabel "copyright_label"
        val () = FontSize.h6 copyrightLabel copyright
        val () = Box.packStart footerBox (copyrightLabel, false, false, 0)

        val versionLabel = Label.new (SOME version)
        val () = Widget.setName versionLabel "version_label"
        val () = FontSize.caption versionLabel version
        val () = Box.packStart footerBox (versionLabel, false, false, 0)

        val () = Box.packStart containerBox (footerBox, false, false, 10)
      in
        containerBox
      end
  end

.. code-block:: sml

    (* Create a basic footer *)
    val footerWidget = Footer.create {
        copyright = "(C) 2024 ACME. All rights reserved.",
        version = "Version 1.0.0"
      }

    (* Add the footer to the main box *)
    val () = Box.packStart mainBox (footerWidget, false, false, 0)

Key Features:

- **Copyright Information**: Standard copyright text
- **Styling**: Consistent styling using the design token system (fontSize)

Error Dialog
------------

The ``ErrorDialog`` component provides a standardized way to display error messages to users.

.. code-block:: sml

  structure ErrorDialog = struct
    open Gtk

    fun create {title : string, message : string} =
      let
        val dialog = Dialog.new ()
        val () = Window.setTitle dialog title
        val () = Window.setDefaultSize dialog (300, 150)
        val contentArea = Dialog.getContentArea dialog
        val errorLabel = Label.new (SOME message)
        val () = Label.setLineWrap errorLabel true
        val () = Widget.setMarginStart errorLabel SpacingScale.medium
        val () = Widget.setMarginEnd errorLabel SpacingScale.medium
        val () = Widget.setMarginTop errorLabel SpacingScale.medium
        val () = Widget.setMarginBottom errorLabel SpacingScale.medium
        val () = Box.packStart contentArea (errorLabel, false, false, 0)
        val _ = Dialog.addButton dialog ("OK", LargeInt.fromInt (IntInf.toInt ResponseType.OK))
        val () = Widget.showAll dialog
        val _ = Dialog.run dialog
        val () = Widget.destroy dialog
      in () end
  end

.. code-block:: sml

    (* Create and show an error dialog *)
    ErrorDialog.create {
        title = "Login Error",
        message = "Invalid username or password."
    }
    
Key Features:

- **Consistent Error Presentation**: Standardized visual design for all error messages
- **Modal Interaction**: Interrupts workflow appropriately for critical errors
- **Customizable Content**: Support for different error titles and descriptions

Button Action Row
-----------------

The ``ButtonActionRow`` provides layout utilities for consistent button placement, supporting both left-aligned and right-aligned button arrangements.

.. code-block:: sml

  (******************************************************************************
   * RightAlignedButtonRow: Arranges buttons in a row aligned to the right.
   *
   * Usage:
   *   val row = RightAlignedButtonRow.create [button1] or
   *   val row = RightAlignedButtonRow.create [button1, button2]
   ******************************************************************************)
  structure RightAlignedButtonRow = struct
    structure Gtk = Gtk
    open Gtk

    fun create (buttons : Gtk.Button.t list) : Gtk.Box.t =
      let
        val box = Box.new (Orientation.HORIZONTAL, 0)
        val () = Widget.setMarginTop box SpacingScale.medium
        val () = Widget.setMarginBottom box SpacingScale.small
        val () = Widget.setMarginStart box SpacingScale.medium
        val () = Widget.setMarginEnd box SpacingScale.medium

        val spacer = Label.new (SOME "")
        val () = Box.packStart box (spacer, true, true, 0)

        val () = List.app (fn w => Box.packStart box (w, false, false, 0)) buttons
      in
        box
      end
  end

.. code-block:: sml

  (******************************************************************************
   * LeftAlignedButtonRow: Arranges buttons in a row aligned to the left.
   *
   * Usage:
   *   val row = LeftAlignedButtonRow.create [button1] or
   *   val row = LeftAlignedButtonRow.create [button1, button2]
   ******************************************************************************)
  structure LeftAlignedButtonRow = struct
    structure Gtk = Gtk
    open Gtk

    fun create (buttons : Gtk.Button.t list) : Gtk.Box.t =
      let
        val box = Box.new (Orientation.HORIZONTAL, 0)
        val () = Widget.setMarginTop box SpacingScale.medium
        val () = Widget.setMarginBottom box SpacingScale.small
        val () = Widget.setMarginStart box SpacingScale.medium
        val () = Widget.setMarginEnd box SpacingScale.medium

        val () = List.app (fn w => Box.packStart box (w, false, false, 0)) buttons
      in
        box
      end
  end

.. code-block:: sml

  (******************************************************************************
   * CenterAlignedButtonRow: Arranges buttons in a row centered horizontally.
   *
   * Usage:
   *   val row = CenterAlignedButtonRow.create [button1] or
   *   val row = CenterAlignedButtonRow.create [button1, button2]
   ******************************************************************************)
  structure CenterAlignedButtonRow = struct
    structure Gtk = Gtk
    open Gtk

    fun create (buttons : Gtk.Button.t list) : Gtk.Box.t =
      let
        val box = Box.new (Orientation.HORIZONTAL, 0)
        val () = Widget.setMarginTop box SpacingScale.medium
        val () = Widget.setMarginBottom box SpacingScale.small
        val () = Widget.setMarginStart box SpacingScale.medium
        val () = Widget.setMarginEnd box SpacingScale.medium

        val leftSpacer = Label.new (SOME "")
        val rightSpacer = Label.new (SOME "")
        val () = Box.packStart box (leftSpacer, true, true, 0)
        val () = List.app (fn w => Box.packStart box (w, false, false, 0)) buttons
        val () = Box.packStart box (rightSpacer, true, true, 0)
      in
        box
      end
  end


.. code-block:: sml

    (* Usage examples *)
    (* Create a row of action buttons *)
    val saveBtn = Button.newWithLabel "Save"
    val cancelBtn = Button.newWithLabel "Cancel"

    (* Set size request for add button *)
    val _ = Widget.setSizeRequest addBtn (180, 36)
    
    (* Right-aligned buttons (common for action buttons) *)
    val actionButtons = RightAlignedButtonRow.create [saveBtn, cancelBtn]
    
    (* Left-aligned buttons (common for navigation buttons) *)
    val navButtons = LeftAlignedButtonRow.create [backBtn]

    (* Add buttons to content box *)
    val () = Box.packStart contentBox (actionButtons, false, false, 0)


Key Features:

- **Alignment Options**: Support for both left and right alignment
- **Consistent Spacing**: Standardized spacing between buttons
- **Order Preservation**: Maintains the order of buttons as specified

Application State
-----------------

The AppState structure provides centralized state management for user authentication in a functional manner, following SML's paradigms.

.. code-block:: sml

  structure AppState = struct
    (* Current logged-in username (NONE if not logged in) *)
    val currentUser = ref (NONE : string option)
    
    (* Sets the current user after successful login *)
    fun setCurrentUser username = 
      currentUser := SOME username
    
    (* Clears the current user on logout *)
    fun clearCurrentUser () = 
      currentUser := NONE
    
    (* Gets the current user *)
    fun getCurrentUser () = 
      !currentUser
    
    (* Checks if a user is logged in *)
    fun isLoggedIn () = 
      case !currentUser of
        SOME _ => true
      | NONE => false
  end  

.. code-block:: sml

    (* Usage examples *)
    (* Check if a user is currently logged in *)
    val isUserLoggedIn = AppState.isLoggedIn ()

    (* Log a user in *)
    val () = AppState.setCurrentUser "admin"

    (* Get the current user *)
    val username = AppState.getCurrentUser ()

    (* Log the user out *)
    val () = AppState.clearCurrentUser ()

Key Features:

- **Authentication State Management**: Tracks the currently logged-in user
- **Functional References**: Uses SML's reference cells to maintain state in a controlled manner
- **Pattern Matching**: Leverages SML's strong type system to ensure state consistency
- **Simple API**: Provides clear, focused functions for state manipulation and queries


Menu Navigation System
----------------------

The menu navigation system provides a consistent navigation experience across different pages in the ERP application.

.. code-block:: sml

 (* Creates menu bar *)
  fun createMenuBar (stack : Gtk.Stack.t, items : (string * string) list) =
    let
      val menuBarBox = Box.new (Orientation.HORIZONTAL, SpacingScale.small)
      val () = Container.setBorderWidth menuBarBox SpacingScale.xsmall
      
      fun createMenuButton (label, pageName) =
        let
          val button = Button.newWithLabel label
          val () = Button.setRelief button ReliefStyle.NONE
          val () = Widget.setMarginStart button SpacingScale.small
          val () = Widget.setMarginEnd button SpacingScale.small
          
          val _ = Signal.connect button (Button.clickedSig, fn _ =>
            let
              val () = print ("Navigating to " ^ pageName ^ "\n")
              val () = Stack.setVisibleChildName stack pageName
            in
              ()
            end)
        in
          button
        end
      
      val () = List.app (fn item =>
        let
          val button = createMenuButton item
        in
          Box.packStart menuBarBox (button, false, false, 0)
        end) items
    in
      menuBarBox
    end

.. code-block:: sml

    (* Usage Examples *)
    (* Create and add menu bar if page specif menuItems are provided *)
    val () = case menuItems of
        NONE => ()
      | SOME items =>
          let
            val menuBarWidget = createMenuBar (stack, items)
            val () = Box.packStart mainBox (menuBarWidget, false, false, 0)
            
            val separator = Separator.new Orientation.HORIZONTAL
            val () = Widget.setMarginTop separator SpacingScale.xsmall
            val () = Widget.setMarginBottom separator SpacingScale.xsmall
            val () = Box.packStart mainBox (separator, false, false, 0)
          in
            ()
          end

    (* Create a page with no menu bar *)
    structure LoginPageBase = BasePage(struct val title = "Login" val menuItems = NONE end)
    
    (* Create a page with predefined menu bar *)
    val (basePage, contentBox) = DashboardBase.create{stack = stack, menuItems = menuItems}
    
    (* Add content to the content box *)
    val () = Box.packStart contentBox (loginForm, false, false, 0)

Functional Approach to Layout
-----------------------------

The layout components demonstrate several key functional programming concepts:

1. **Immutability**: All widget creation is handled through pure functions that don't modify external state
2. **Composition**: Complex layouts are built by composing simpler components
3. **Separation of Concerns**: Each component focuses on a single responsibility
4. **Higher-Order Functions**: Event handling uses functions as first-class values
5. **Referential Transparency**: Given the same inputs, components consistently produce the same outputs

Best Practices
--------------

When working with layout components:

1. **Compose Don't Inherit**: Build complex layouts by composing simple components, not through inheritance
2. **Respect Immutability**: Don't attempt to modify components after creation; create new ones instead
3. **Use Consistent Patterns**: Follow the established patterns for component creation and configuration
4. **Leverage the Type System**: Use SML's type system to catch errors at compile time
