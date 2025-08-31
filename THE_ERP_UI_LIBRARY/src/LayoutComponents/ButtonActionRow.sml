(******************************************************************************
 * ButtonActionRow.sml: Provides reusable button row layout components for ERP UI.
 *
 * This module defines three structures for arranging buttons in a horizontal row:
 *   - RightAlignedButtonRow: Buttons aligned to the right.
 *   - LeftAlignedButtonRow: Buttons aligned to the left.
 *   - CenterAlignedButtonRow: Buttons centered horizontally.
 *
 * Intended Usage:
 *   - Use the create function from the desired structure to generate a Gtk.Box.t
 *     containing the provided list of Gtk.Button.t widgets, aligned as specified.
 *
 * Author: Omosefe Osakue
 * Date: 2025-05-09
 ******************************************************************************)

(*Importing Required Modules*)
use "../Tokens/SpacingScale.sml";
use "../Tokens/FontSize.sml";
use "../Tokens/CssLoader.sml";

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

