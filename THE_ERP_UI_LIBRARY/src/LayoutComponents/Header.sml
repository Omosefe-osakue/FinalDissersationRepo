(******************************************************************************
 * Header.sml: Provides a reusable header component for ERP UI layouts.
 *
 * This module defines the Header structure, exposing a function to create
 * a header with an optional logo, company name, and username display.
 *
 * Intended Usage:
 *   - Use Header.create {imagePath, text, username} to generate a header widget.
 *
 * Example Usage:
 *   val header = Header.create {imagePath = SOME "logo.png", text = "ERP Corp", username = SOME "Alice"}
 *
 * Author: Omosefe Osakue
 * Date: 2025-05-09
 ******************************************************************************)

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