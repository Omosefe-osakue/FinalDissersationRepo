(******************************************************************************
 * SalesOrderPage.sml: Implements the ERP sales order page with order grid and actions.
 *
 * This module defines the SalesOrderPage structure, which uses the BasePage functor
 * to provide a standardized layout (header, footer, menu bar) and adds sales order-
 * specific content such as an order table and related actions.
 *
 * Intended Usage:
 *   - Use SalesOrderPage.create {stack, menuItems} to instantiate the sales order page.
 *   - Integrates with the navigation stack and menu system.
 *
 * Dependencies:
 *   - BasePage (for layout)
 *   - ContentPanel (for displaying order details)
 *   - ButtonActionRow (for order-related actions)
 *   - SalesOrderData (for order data)
 *   - Gtk (for UI components)
 *
 * Author: Omosefe Osakue
 * Date: 2025-05-09
 *******************************************************************************)

(* Import required modules *)
use "../Tokens/SpacingScale.sml";
use "../Tokens/FontSize.sml";
use "../LayoutComponents/AppState.sml";
use "BasePage.sml";
use "../DashboardComponents/ContentPanel.sml";
use "../LayoutComponents/ButtonActionRow.sml";
use "../data/SalesOrderData.sml";

structure SalesOrderPage :> PAGE = struct
  structure Gtk = Gtk
  open Gtk

  structure SalesOrderBase = BasePage(struct val title = "Sales Orders" end)

  fun create {stack: Gtk.Stack.t, menuItems: (string * string) list option} =
    let
      val (basePage, contentBox) = SalesOrderBase.create{
        stack = stack, 
        menuItems = menuItems
      }

      (* --- Sales Order Specific Content --- *) 

      val centeringBox = Box.new (Orientation.VERTICAL, 0)
      val () = Widget.setHalign centeringBox Align.CENTER
      val () = Widget.setVexpand centeringBox true
      val () = Widget.setHexpand centeringBox true
      
      val headerBox = Box.new (Orientation.HORIZONTAL, SpacingScale.medium)
      val () = Widget.setMarginTop headerBox SpacingScale.large
      val () = Widget.setMarginStart headerBox SpacingScale.large
      val () = Widget.setMarginEnd headerBox SpacingScale.large
      
      val titleLabel = Label.new(SOME "Sales Orders")
      val () = FontSize.h2 titleLabel "Sales Orders"
      val () = Widget.setHalign titleLabel Align.START
      val () = Box.packStart headerBox (titleLabel, false, false, 0)
      
      val backButton = Button.newWithLabel "Back to Dashboard"
      val buttonRow = LeftAlignedButtonRow.create [backButton]
      
      val _ = Signal.connect backButton (Button.clickedSig, fn _ =>
        let
          val () = print ("Navigating back to Dashboard\n")
          val () = Stack.setVisibleChildName stack "dashboard"
        in
          ()
        end)
      
      val () = Box.packStart centeringBox (headerBox, false, false, 0)
      
      val () = Box.packStart centeringBox (buttonRow, false, false, 0)
      
      val frame = Frame.new(NONE)
      val () = Widget.setMarginTop frame SpacingScale.medium
      val () = Widget.setMarginStart frame SpacingScale.large
      val () = Widget.setMarginEnd frame SpacingScale.large
      val () = Widget.setMarginBottom frame SpacingScale.large
      
      val tableBox = Box.new (Orientation.VERTICAL, 0)
      val () = Container.add frame tableBox
      
      val headerRow = Box.new (Orientation.HORIZONTAL, 0)
      val () = Box.setHomogeneous headerRow true
      
      val () = List.app (fn text => 
        let
          val label = Label.new(SOME text)
          val () = Label.setMarkup label ("<b>" ^ text ^ "</b>")
          val () = Widget.setHalign label Align.START
          val () = Widget.setMarginStart label SpacingScale.small
          val () = Widget.setMarginEnd label SpacingScale.small
          val () = Widget.setMarginTop label SpacingScale.small
          val () = Widget.setMarginBottom label SpacingScale.small
          val () = Box.packStart headerRow (label, true, true, 0)
        in
          ()
        end) (SalesOrderData.headers)
      
      val () = Box.packStart tableBox (headerRow, false, false, 0)
      
      val separator = Separator.new Orientation.HORIZONTAL
      val () = Box.packStart tableBox (separator, false, false, 0)
      
      val () = List.app (fn rowData =>
        let
          val row = Box.new (Orientation.HORIZONTAL, 0)
          val () = Box.setHomogeneous row true
          
          (* Create cells for each column in the data *)
          val () = List.app (fn cellText =>
            let
              val label = Label.new(SOME cellText)
              val () = Widget.setHalign label Align.START
              val () = Widget.setMarginStart label SpacingScale.small
              val () = Widget.setMarginEnd label SpacingScale.small
              val () = Widget.setMarginTop label SpacingScale.small
              val () = Widget.setMarginBottom label SpacingScale.small
              val () = Box.packStart row (label, true, true, 0)
            in
              ()
            end
          ) rowData
          
          val () = Box.packStart tableBox (row, false, false, 0)
          
          val rowSeparator = Separator.new Orientation.HORIZONTAL
          val () = Box.packStart tableBox (rowSeparator, false, false, 0)
        in
          ()
        end
      ) SalesOrderData.rows
      
      val () = Box.packStart centeringBox (frame, true, true, 0)
      
      val () = Container.add contentBox centeringBox

    in
      (basePage, contentBox)
    end
end
