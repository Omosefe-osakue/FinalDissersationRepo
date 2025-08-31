(******************************************************************************
 * Footer.sml: Provides a reusable footer component for ERP UI layouts.
 *
 * This module defines the Footer structure, exposing a function to create
 * a footer with copyright and version information, styled for ERP applications.
 *
 * Intended Usage:
 *   - Use Footer.create {copyright, version} to generate a footer widget.
 * Usage:
 *   val footer = Footer.create {copyright = "© 2025 Omosefe", version = "v1.0"}
 *
 * Author: Omosefe Osakue
 * Date: 2025-05-09
 ******************************************************************************)

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