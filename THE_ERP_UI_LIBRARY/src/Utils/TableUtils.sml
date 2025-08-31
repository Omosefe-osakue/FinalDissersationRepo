(******************************************************************************
 * TableUtils.sml: Utility functions for creating and managing tables with GTK Grid.
 *
 * This module defines the TableUtils structure, providing helpers for constructing
 * dynamic tables (with headers and rows) in GTK-based ERP UIs. It standardizes table
 * layout, spacing, and styling using ERP UI conventions.
 *
 * Intended Usage:
 *   - Use TableUtils.createTable {headers, rows} to create a styled GTK Grid table.
 *   - Use TableUtils.appi for indexed iteration over lists (for grid construction).
 *
 * Dependencies:
 *   - Gtk (for UI components)
 *   - CssLoader (for applying CSS classes)
 *   - SpacingScale, FontSize (for spacing and typography)
 *
 * Parameters:
 *   - headers: string list (column headers)
 *   - rows: string list list ref (mutable rows, each a list of cell strings)
 * Returns: Gtk.Grid.t (the constructed table grid)
 *
 * Author: Omosefe Osakue
 * Date: 2025-05-09
 *******************************************************************************)

use "../Tokens/SpacingScale.sml";
use "../Tokens/FontSize.sml";
use "../Tokens/CssLoader.sml";

structure TableUtils = struct

  structure Gtk = Gtk
  open Gtk

  (* Indexed iteration over lists *)
  fun appi f xs = let fun loop (i, []) = () | loop (i, y::ys) = (f(i, y); loop (i+1, ys)) in loop (0, xs) end

  (* createTable: Constructs a GTK Grid table with headers and rows.*)
  fun createTable {headers: string list, rows: string list list ref} : Grid.t =
    let
      val grid = Grid.new ()
      val () = Grid.setRowSpacing grid 1 
      val () = Grid.setColumnSpacing grid 1
      val () = CssLoader.addClassToWidget grid "dynamic-table" 

      (* Adds Headers *)
      val () = appi (fn (colIdx, headerText) =>
        let
          val headerLabel = Label.new (SOME headerText)
          val () = Widget.setHalign headerLabel Align.START 
          val () = Widget.setMarginTop headerLabel SpacingScale.small
          val () = Widget.setMarginBottom headerLabel SpacingScale.small
          val () = Widget.setMarginStart headerLabel SpacingScale.medium
          val () = Widget.setMarginEnd headerLabel SpacingScale.medium
          val () = CssLoader.addClassToWidget headerLabel "table-header-cell"
          val () = Grid.attach grid (headerLabel,
                LargeInt.fromInt colIdx, 
                LargeInt.fromInt 0,      
                LargeInt.fromInt 1,      
                LargeInt.fromInt 1)     
        in () end
      ) headers

      (* Add Data Rows *)
      val () = appi (fn (rowIdx, rowData) =>
        let
           val () = appi (fn (colIdx, cellData) =>
             let
               val cellLabel = Label.new (SOME cellData)
               val () = Widget.setHalign cellLabel Align.START 
               val () = Widget.setMarginTop cellLabel SpacingScale.small
               val () = Widget.setMarginBottom cellLabel SpacingScale.small
               val () = Widget.setMarginStart cellLabel SpacingScale.medium
               val () = Widget.setMarginEnd cellLabel SpacingScale.medium
               val () = CssLoader.addClassToWidget cellLabel "table-data-cell"
               val () = Grid.attach grid (cellLabel,
                     LargeInt.fromInt colIdx,           
                     LargeInt.fromInt (rowIdx + 1),     
                     LargeInt.fromInt 1,                
                     LargeInt.fromInt 1)                
             in () end
           ) rowData
        in () end
      ) (!rows) 

    in
      grid 
    end

end
