
(******************************************************************************
 * KPICard: Provides a reusable KPI (Key Performance Indicator) card widget for
 * ERP dashboards and analytics UI.
 *
 * This module defines the KPICard structure, exposing a function to create a
 * visually prominent card displaying a value, label, and optional trend indicator.
 * KPI cards are commonly used to highlight important metrics in a dashboard.
 *
 * Intended Usage:
 *   - Use KPICard.create {label, value, trend} to instantiate a styled card
 *     for displaying key metrics in grid or dashboard layouts.
 *   - Supports optional trend text (e.g., "+5%", "↓2%") for visualizing change.

 * create : {label : string, value : string, trend : string option} -> Gtk.widget
 *
 * Constructs a KPI card widget with a value, label, and optional trend indicator.
 *
 * Parameters:
 *   label : string         - The description or name of the KPI (e.g., "Revenue").
 *   value : string         - The main value to display (e.g., "$1,000").
 *   trend : string option  - Optional trend text (e.g., "+5%", "↓2%", or NONE).
 *
 * Returns:
 *   Gtk.widget - The assembled KPI card widget.
 *
 * Example usage:
 *   val card = KPICard.create {
 *     label = "Revenue",
 *     value = "$1,000",
 *     trend = SOME "+5%"
 *   }
 * Author: Omosefe Osakue
 * Date: 2025-05-13
 ******************************************************************************)

(*Importing required modules*)
use "../Tokens/SpacingScale.sml";
use "../Tokens/FontSize.sml";
use "../Tokens/CssLoader.sml";

structure KPICard = struct
  open Gtk
  fun create {label : string, value : string, trend : string option} =
    let
      val cardBox = Box.new (Orientation.VERTICAL, SpacingScale.small)
      val () = Container.setBorderWidth cardBox SpacingScale.medium
      val () = CssLoader.addClassToWidget cardBox "kpi-card" 

      (* Value label *)
      val valueLabel = Label.new (SOME value)
      val () = FontSize.h2 valueLabel value 
      val () = Widget.setHalign valueLabel Align.CENTER
      val () = Widget.setValign valueLabel Align.CENTER
      val () = Box.packStart cardBox (valueLabel, true, true, 0)

      (* Description label *)
      val labelLabel = Label.new (SOME label)
      val () = FontSize.h5 labelLabel label 
      val () = Widget.setHalign labelLabel Align.CENTER
      val () = Widget.setValign labelLabel Align.CENTER
      val () = Box.packStart cardBox (labelLabel, false, false, 0)

      (* Trend label (if provided) *)
      val () = case trend of
          SOME trendText => 
          let
              val trendLabel = Label.new(SOME trendText)
              val () = FontSize.caption trendLabel trendText
              val () = Widget.setHalign trendLabel Align.END
              val () = Box.packStart cardBox (trendLabel, false, false, 0)
          in
              ()
          end
      | NONE => ()
    in
      cardBox
    end
end
