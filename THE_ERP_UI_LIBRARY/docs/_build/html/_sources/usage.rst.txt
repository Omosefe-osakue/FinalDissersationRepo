Usage Guide
===========


This section provides practical guidance on how to use the ERP UI Library components built with Standard ML.

Installation
-------------

To use this library in your Standard ML project:

1. Include the library files in your project directory
2. Import the necessary modules using the SML module system

.. code-block:: sml

   use "path/to/THE_ERP_UI_LIBRARY/main.sml";

Core Components
----------------

Design Tokens
~~~~~~~~~~~~~

The library provides a robust design token system for consistent styling:

.. code-block:: sml

   (* Example of using design tokens *)
   val spacingScale = Tokens.spacingScale.small;
   val fontSize = Tokens.fontSize.large;

Layout Components
~~~~~~~~~~~~~~~~~

Header Component
^^^^^^^^^^^^^^^^

The Header component provides a consistent application header with optional logo and username display:

.. code-block:: sml

    (* Header: Displays the company logo, name, and username at the top of the UI. *)
    structure Header = struct
      fun create {imagePath : string option, text : string, username : string option} =
        let
          open Gtk
          val containerBox = Box.new (Orientation.VERTICAL, 0)
          val headerBox = Box.new (Orientation.HORIZONTAL, 10)
          val () = Widget.setSizeRequest headerBox (1000, 60)
          
          (* Add logo if provided *)
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

          (* Add title in center *)
          val spacer1 = Box.new (Orientation.HORIZONTAL, 0)
          val () = Box.packStart headerBox (spacer1, true, true, 0)
          
          val label = Label.new (SOME text)
          val () = Widget.setName label "company_name"
          val () = FontSize.h4 label text
          val () = Box.packStart headerBox (label, false, false, 20)

          val spacer2 = Box.new (Orientation.HORIZONTAL, 0)
          val () = Box.packStart headerBox (spacer2, true, true, 0)

          (* Add username if provided *)
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
          
          (* Add horizontal separator *)
          val () = Box.packStart containerBox (headerBox, false, false, 10)
          val separator = Separator.new Orientation.HORIZONTAL
          val () = Box.packStart containerBox (separator, false, true, 0)
        in
          containerBox
        end
    end

Usage
~~~~~

.. code-block:: sml

   (* Creating a header component *)
   val header = Layout.Header.create {
     title = "My ERP Application",
     user = Some "Admin User",
     notifications = 3
   };

Dashboard Components
--------------------

KPI Cards
~~~~~~~~~

.. code-block:: sml

   (* Creating a KPI card *)
   val salesKPI = Dashboard.KPICard.create {
     title = "Total Sales",
     value = "$1,245,000",
     change = Some { value = 12.5, positive = true },
     icon = Some Icons.trendingUp
   };

Page Templates
--------------

Use functors to create consistent page templates:

.. code-block:: sml

   (* Creating a data listing page *)
   structure InventoryPage = PageTemplate(
     struct
       val title = "Inventory Management"
       val table = { 
         columns = ["ID", "Product", "Quantity", "Status"],
         data = inventoryData
       }
     end
   );

Best Practices
---------------

1. Maintain immutability by using the provided update functions instead of modifying component state directly
2. Use pattern matching for handling component variations
3. Leverage higher-order functions for component callbacks
4. Compose components using the functional composition operators
