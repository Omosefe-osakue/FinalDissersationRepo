(******************************************************************************
 * InventoryPage.sml: Implements the ERP inventory page with a tabular list and
 * Excel-like editing features.
 *
 * This module defines the InventoryPage structure, which uses the BasePage functor
 * to provide a standardized layout (header, footer, menu bar) and adds inventory-
 * specific content such as a dynamic, editable table for inventory items.
 *
 * Intended Usage:
 *   - Use InventoryPage.create {stack, menuItems} to instantiate the inventory page.
 *   - Integrates with the navigation stack and menu system.
 *
 * Dependencies:
 *   - BasePage (for layout)
 *   - ButtonActionRow, ErrorDialog (for actions and error handling)
 *   - Gtk (for UI components)
 *
 * Author: Omosefe Osakue
 * Date: 2025-05-09
 *******************************************************************************)

(* Import required modules *)
use "../Tokens/SpacingScale.sml";
use "../Tokens/FontSize.sml";
use "../Tokens/CssLoader.sml";
use "../LayoutComponents/AppState.sml";
use "../LayoutComponents/ButtonActionRow.sml";
use "../LayoutComponents/ErrorDialog.sml";
use "BasePage.sml";

structure InventoryPage :> PAGE = struct
  structure Gtk = Gtk
  open Gtk

  fun removeAt (xs, n) =
    let
      fun loop (i, acc, []) = List.rev acc
        | loop (i, acc, y::ys) =
            if i = n then loop (i+1, acc, ys)
            else loop (i+1, y::acc, ys)
    in
      loop (0, [], xs)
    end

  (* Apply BasePage functor *)
  structure InventoryBase = BasePage(struct val title = "Inventory" end)

  fun create {stack : Gtk.Stack.t, menuItems : (string * string) list option} =
    let
      
      fun appi f xs = let fun loop (i, []) = ()
                          | loop (i, y::ys) = (f(i, y); loop (i+1, ys))
                      in loop (0, xs) end

      
      val (basePage, pageBox) = InventoryBase.create{
        stack = stack,
        menuItems = menuItems
      }
     
      val contentBox = Box.new (Orientation.VERTICAL, 0)
      val () = Container.add pageBox contentBox

      val addBtn = Button.newWithLabel "Add Inventory Item"
      val _ = Widget.setSizeRequest addBtn (180, 36)
      val buttonRow = RightAlignedButtonRow.create [addBtn]
      val () = Box.packStart contentBox (buttonRow, false, false, 0)

      (* Create table specific scroll window *)
      val tableScrollWindow = ScrolledWindow.new (NONE, NONE)
      val () = Widget.setMarginTop tableScrollWindow SpacingScale.medium
      val () = Widget.setMarginStart tableScrollWindow SpacingScale.medium
      val () = Widget.setMarginEnd tableScrollWindow SpacingScale.medium
      val () = Widget.setMarginBottom tableScrollWindow SpacingScale.medium
      val () = ScrolledWindow.setShadowType tableScrollWindow ShadowType.ETCHED_IN
      
      val () = Widget.setSizeRequest tableScrollWindow (500, 500)
      
      val () = Box.packStart contentBox (tableScrollWindow, true, true, 0)
      
      val () = Widget.setVexpand tableScrollWindow true
      val () = Widget.setHexpand tableScrollWindow true


      (*Inventory Records*)
      val inventoryItemsRef = ref [
        ("Widget A", "WID123", 50, 9.99),
        ("Widget B", "WID456", 20, 19.99),
        ("Gadget C", "GAD789", 75, 14.49)
      ]

      (* Define column headers *)
      val headers = ["Name", "SKU", "Quantity", "Price (GBP)", "Actions"]

      fun columnIndexToLetter idx =
        let
          fun convert n acc =
            if n < 0 then acc
            else
              let
                val remainder = n mod 26
                val letter = String.str(Char.chr(65 + remainder))
              in
                convert ((n div 26) - 1) (letter ^ acc)
              end
        in
          convert idx ""
        end

      
      val tableGrid = ref (Grid.new ())
      val () = Grid.setRowSpacing (!tableGrid) SpacingScale.small
      val () = Grid.setColumnSpacing (!tableGrid) SpacingScale.medium
      val () = CssLoader.addClassToWidget (!tableGrid) "excel-table"
      
      val () = Container.add tableScrollWindow (!tableGrid)
      val () = CssLoader.addClassToWidget (!tableGrid) "excel-table-scrollable"
      
      val () = Widget.setSizeRequest (!tableGrid) (800, 600) 

      val cellPadding = SpacingScale.small
      
      fun refreshTable () =
        let
          val oldGrid = !tableGrid
          val () = Container.remove tableScrollWindow oldGrid
          
          val newGrid = Grid.new ()
          val () = Grid.setRowSpacing newGrid SpacingScale.small
          val () = Grid.setColumnSpacing newGrid SpacingScale.medium
          val () = CssLoader.addClassToWidget newGrid "excel-table"

          val () = Widget.setName newGrid "excel-grid"
          val () = Grid.setRowHomogeneous newGrid true
          val () = Grid.setColumnHomogeneous newGrid true
          
          val () = Grid.setRowSpacing newGrid 1
          val () = Grid.setColumnSpacing newGrid 1
          
          val () = Widget.setMarginStart newGrid 0
          val () = Widget.setMarginEnd newGrid 0
          val () = Widget.setMarginTop newGrid 0
          val () = Widget.setMarginBottom newGrid 0
          
          val () = CssLoader.addClassToWidget newGrid "excel-table-border"
          val () = CssLoader.addClassToWidget newGrid "excel-grid"
          
          val () = Widget.setSizeRequest newGrid (800, 600)
          
          val cornerLabel = Label.new (SOME "")
          val () = CssLoader.addClassToWidget cornerLabel "excel-header"
          val () = Widget.setSizeRequest cornerLabel (30, ~1)
          val () = Widget.setName cornerLabel "corner-cell"
          val () = Grid.attach newGrid (cornerLabel,
                LargeInt.fromInt 0,
                LargeInt.fromInt 0,
                LargeInt.fromInt 1,
                LargeInt.fromInt 1)
          
          (* Add column letters in the first row (A, B, C, etc.) *)
          val () = appi (fn (colIndex, _) =>
            let
              val letter = columnIndexToLetter colIndex
              val letterLabel = Label.new (SOME letter)
              val () = FontSize.h5 letterLabel letter
              val () = Widget.setHalign letterLabel Align.CENTER
              val () = Widget.setMarginTop letterLabel cellPadding
              val () = Widget.setMarginBottom letterLabel cellPadding
              val () = Widget.setMarginStart letterLabel cellPadding
              val () = Widget.setMarginEnd letterLabel cellPadding
              val () = CssLoader.addClassToWidget letterLabel "excel-header"
              val () = CssLoader.addClassToWidget letterLabel "excel-column-letter"
              val () = Widget.setSizeRequest letterLabel (~1, 25)
              val () = Widget.setName letterLabel ("col-" ^ letter)
              
              val () = Grid.attach newGrid (letterLabel,
                    LargeInt.fromInt (colIndex + 1),
                    LargeInt.fromInt 0,
                    LargeInt.fromInt 1,
                    LargeInt.fromInt 1)
            in () end
          ) headers
          
          val zeroLabel = Label.new (SOME "0")
          val () = Widget.setHalign zeroLabel Align.CENTER
          val () = Widget.setMarginStart zeroLabel cellPadding
          val () = Widget.setMarginEnd zeroLabel cellPadding
          val () = Widget.setMarginTop zeroLabel cellPadding
          val () = Widget.setMarginBottom zeroLabel cellPadding
          val () = Widget.setSizeRequest zeroLabel (30, ~1) 
          val () = Widget.setName zeroLabel "header-row-num"
          val () = Grid.attach newGrid (zeroLabel,
                LargeInt.fromInt 0,
                LargeInt.fromInt 1,
                LargeInt.fromInt 1,
                LargeInt.fromInt 1)
                
          val () = appi (fn (colIndex, header) =>
            let
              val headerLabel = Label.new (SOME header)
              val () = FontSize.h5 headerLabel header
              val () = Widget.setHalign headerLabel Align.START
              val () = Widget.setMarginTop headerLabel cellPadding
              val () = Widget.setMarginBottom headerLabel cellPadding
              val () = Widget.setMarginStart headerLabel cellPadding
              val () = Widget.setMarginEnd headerLabel cellPadding
              val () = CssLoader.addClassToWidget headerLabel "excel-header"
              
              val () = Grid.attach newGrid (headerLabel,
                    LargeInt.fromInt (colIndex + 1),
                    LargeInt.fromInt 1,
                    LargeInt.fromInt 1,
                    LargeInt.fromInt 1)
            in () end
          ) headers
          
          (* Table row population function *)
          val () = appi (fn (rowIndex, (name, sku, qty, price)) =>
            let
              val actualRow = rowIndex + 2
              val rowNumLabel = Label.new (SOME (Int.toString (rowIndex + 1))) 
              val () = Widget.setHalign rowNumLabel Align.CENTER
              val () = Widget.setMarginStart rowNumLabel cellPadding
              val () = Widget.setMarginEnd rowNumLabel cellPadding
              val () = Widget.setMarginTop rowNumLabel cellPadding
              val () = Widget.setMarginBottom rowNumLabel cellPadding
              val () = CssLoader.addClassToWidget rowNumLabel "excel-row-number"
              val () = Widget.setSizeRequest rowNumLabel (30, ~1)
              val () = Widget.setName rowNumLabel ("row-num-" ^ Int.toString rowIndex)
              val () = Grid.attach newGrid (rowNumLabel,
                    LargeInt.fromInt 0,
                    LargeInt.fromInt actualRow,
                    LargeInt.fromInt 1,
                    LargeInt.fromInt 1)
              
              (* Create data cells *)
              val cellsData = [name, sku, Int.toString qty, "GBP " ^ Real.toString price]
              val () = appi (fn (colIndex, cellData) =>
                let
                  val cellLabel = Label.new (SOME cellData)
                  val () = Widget.setHalign cellLabel Align.START
                  val () = Widget.setMarginStart cellLabel cellPadding
                  val () = Widget.setMarginEnd cellLabel cellPadding
                  val () = Widget.setMarginTop cellLabel cellPadding
                  val () = Widget.setMarginBottom cellLabel cellPadding
                  val () = CssLoader.addClassToWidget cellLabel "excel-cell"
                  val () = Widget.setName cellLabel ("cell-" ^ Int.toString rowIndex ^ "-" ^ Int.toString colIndex)
                  
                  val () = Grid.attach newGrid (cellLabel,
                        LargeInt.fromInt (colIndex + 1),
                        LargeInt.fromInt actualRow,
                        LargeInt.fromInt 1,
                        LargeInt.fromInt 1)
                  val () = Widget.setHexpand cellLabel true
                  val () = Widget.setVexpand cellLabel false
                in () end
              ) cellsData
              
              (* Adds Remove button in Actions column *)
              val removeBtn = Button.newWithLabel "Remove"
              val () = CssLoader.addClassToWidget removeBtn "excel-action-button"
              val () = Widget.setName removeBtn ("action-" ^ Int.toString rowIndex)
              
              val () = Widget.setMarginStart removeBtn cellPadding
              val () = Widget.setMarginEnd removeBtn cellPadding
              val () = Widget.setMarginTop removeBtn cellPadding
              val () = Widget.setMarginBottom removeBtn cellPadding
              
              val _ = Signal.connect removeBtn (Button.clickedSig, fn _ =>
                let
                  val currentItems = !inventoryItemsRef
                  val updatedItems = removeAt (currentItems, rowIndex)
                  val () = inventoryItemsRef := updatedItems
                  val () = refreshTable ()
                in () end)
              
              val actionsCol = List.length headers - 1
              val () = Grid.attach newGrid (removeBtn,
                    LargeInt.fromInt (actionsCol + 1),
                    LargeInt.fromInt actualRow,
                    LargeInt.fromInt 1,
                    LargeInt.fromInt 1)
              
              val isLastRow = rowIndex = (List.length (!inventoryItemsRef)) - 1
              val () = if not isLastRow then
                let
                  val rowSeparator = Separator.new (Orientation.HORIZONTAL)
                  val () = CssLoader.addClassToWidget rowSeparator "excel-row-separator"
                  val () = Grid.attach newGrid (rowSeparator,
                        LargeInt.fromInt 0,
                        LargeInt.fromInt (actualRow + 1),
                        LargeInt.fromInt (List.length headers + 1),
                        LargeInt.fromInt 1)
                in () end
              else ()
            in () end
          ) (!inventoryItemsRef)
          
          val () = tableGrid := newGrid
          val () = CssLoader.addClassToWidget newGrid "excel-table-scrollable"
          val () = CssLoader.addClassToWidget newGrid "excel-table-border"
          val () = Container.add tableScrollWindow newGrid
          val () = Widget.showAll newGrid
        in
          ()
        end

      val () = refreshTable ()

      val _ = Signal.connect addBtn (Button.clickedSig, fn _ =>
        let 
          val dialog = Dialog.new ()
          val _ = Window.setTitle dialog "Add Inventory Item"
          val _ = Window.setDefaultSize dialog (400, 300)
          val _ = Dialog.addButton dialog ("Cancel", LargeInt.fromInt (IntInf.toInt ResponseType.CANCEL))
          val _ = Dialog.addButton dialog ("Add", LargeInt.fromInt (IntInf.toInt ResponseType.OK))
          val contentArea = Dialog.getContentArea dialog

          val nameLabel = Label.new (SOME "Name:")
          val () = Widget.setHalign nameLabel Align.START
          val () = Box.packStart contentArea (nameLabel, false, false, SpacingScale.xxsmall)
          val nameEntry = Entry.new ()
          val () = Widget.setSizeRequest nameEntry (200, 0)
          val () = Box.packStart contentArea (nameEntry, false, false, SpacingScale.xxsmall)

          val skuLabel = Label.new (SOME "SKU:")
          val () = Widget.setHalign skuLabel Align.START
          val () = Box.packStart contentArea (skuLabel, false, false, SpacingScale.xxsmall)
          val skuEntry = Entry.new ()
          val () = Widget.setSizeRequest skuEntry (200, 0)
          val () = Box.packStart contentArea (skuEntry, false, false, SpacingScale.xxsmall)

          val qtyLabel = Label.new (SOME "Quantity (integer):")
          val () = Widget.setHalign qtyLabel Align.START
          val () = Box.packStart contentArea (qtyLabel, false, false, SpacingScale.xxsmall)
          val qtyEntry = Entry.new ()
          val () = Widget.setSizeRequest qtyEntry (200, 0)
          val _ = Entry.setInputPurpose qtyEntry InputPurpose.DIGITS
          val () = Entry.setPlaceholderText qtyEntry (SOME "Enter integer value")
          val () = Box.packStart contentArea (qtyEntry, false, false, SpacingScale.xxsmall)

          val priceLabel = Label.new (SOME "Price (GBP):")
          val () = Widget.setHalign priceLabel Align.START
          val () = Box.packStart contentArea (priceLabel, false, false, SpacingScale.xxsmall)
          val priceEntry = Entry.new ()
          val () = Widget.setSizeRequest priceEntry (200, 0)
          val () = Entry.setPlaceholderText priceEntry (SOME "Enter price (numeric value)")
          val _ = Entry.setInputPurpose priceEntry InputPurpose.NUMBER
          val () = Box.packStart contentArea (priceEntry, false, false, SpacingScale.xxsmall)

          val () = Dialog.setDefaultResponse dialog ResponseType.OK
          val () = Widget.showAll dialog
          val resp = Dialog.run dialog

          val () = if resp = ResponseType.OK then
            let
              val n = Entry.getText nameEntry
              val s = Entry.getText skuEntry
              val qText = Entry.getText qtyEntry
              val pText = Entry.getText priceEntry
              
              (* Validate quantity as integer *)
              fun isValidInt str =
                case Int.fromString str of
                  SOME _ => true
                | NONE => false
                
              (* Validate price as real *)
              fun isValidReal str =
                case Real.fromString str of
                  SOME _ => true
                | NONE => false
              
              (* Convert quantity to int, defaulting to 0 if invalid *)
              val q = case Int.fromString qText of
                        SOME num => num
                      | NONE => 0
                        
              (* Convert price to real, defaulting to 0.0 if invalid *)
              val p = case Real.fromString pText of
                        SOME num => num
                      | NONE => 0.0
              
              (* Only add if we have required fields and valid numeric values *)
              val () = if n <> "" andalso s <> "" andalso isValidInt qText andalso isValidReal pText then
                let
                  val newList = !inventoryItemsRef @ [(n,s,q,p)]
                  val () = inventoryItemsRef := newList
                  val () = refreshTable ()
                in () end
              else
                (
                  ErrorDialog.create {
                    title = "Input Error",
                    message = "Please enter valid values. Quantity must be an integer and Price must be a number."
                  }
                )
            in () end
          else ()
          val () = Widget.destroy dialog
        in () end)
    in
      (basePage, contentBox)
    end
end
