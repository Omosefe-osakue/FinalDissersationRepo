(******************************************************************************
 * ErrorDialog.sml: Provides a reusable error dialog for displaying error messages.
 *
 * This module defines the ErrorDialog structure, exposing a function to create
 * and display a modal dialog with a title and error message. Intended for use in
 * ERP UI applications to provide consistent error reporting.
 *
 * Intended Usage:
 *   - Use ErrorDialog.create {title, message} to display an error dialog.
 *
 * Example Usage:
 *   ErrorDialog.create {title = "Error", message = "Something went wrong."}
 *
 * Author: Omosefe Osakue
 * Date: 2025-05-09
 ******************************************************************************)

(* Importing required modules *)
use "../Tokens/SpacingScale.sml";
use "../Tokens/FontSize.sml";
use "../Tokens/CssLoader.sml";

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