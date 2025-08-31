(******************************************************************************
 * CONTENT_PANEL: Provides a reusable content panel widget for ERP dashboards.
 *
 * This module defines the CONTENT_PANEL structure, exposing a function to
 * create a panel with a title, optional content, optional placeholder (alt text),
 * and optional image. Panels are designed for use in grid or dashboard layouts,
 * promoting modularity and consistency in ERP UI development.
 *
 * Intended Usage:
 *   - Use CONTENT_PANEL.create {title, content, alt, imagePath} to instantiate
 *     a framed panel with a title and optional content or placeholder.
 *   - Supports placeholder text if content is absent, and optional image display.
 *
 * create : {title : string, content : Widget.t option, alt : string option, imagePath : string option} -> Gtk.widget
 *
 * Constructs a content panel widget framed with a title, optional content,
 * optional placeholder (alt text), and optional image.
 *
 * Parameters:
 *   title     : string           - The panel's title (displayed at the top).
 *   content   : Widget.t option  - The main widget/content to display. If NONE,
 *                                  a placeholder is shown instead.
 *   alt       : string option    - Placeholder text if content is missing.
 *   imagePath : string option    - Optional path to an image to display.
 *
 * Returns:
 *   Gtk.widget - The assembled content panel widget.
 *
 * Example usage:
 *   val panel = CONTENT_PANEL.create {
 *     title = "Recent Activity",
 *     content = SOME myWidget,
 *     alt = SOME "No activity to display",
 *     imagePath = NONE
 *   }
 * Author: Omosefe Osakue 
 * Date: 2025-05-09
 ******************************************************************************)
 (*Importing required modules*)
use "../Tokens/SpacingScale.sml";
use "../Tokens/FontSize.sml";
use "../Tokens/CssLoader.sml";



structure CONTENT_PANEL = struct
  open Gtk
  fun create {title : string, content : Widget.t option, alt : string option, imagePath : string option} =
    let
      (* Create frame *)
      val frame = Frame.new(NONE)   
      
      (* Create content box *)
      val contentBox = Box.new(Orientation.VERTICAL, SpacingScale.small)
      val () = Container.setBorderWidth contentBox SpacingScale.inset
      val () = Container.add frame contentBox
      
      (* Title *)
      val titleLabel = Label.new(SOME title)
      val () = Widget.setHalign titleLabel Align.START
      val () = FontSize.h4 titleLabel title 
      val () = Box.packStart contentBox (titleLabel, false, false, 0)

      (* Handle content or placeholder correctly *)
      val () = case content of
          SOME widget =>
            (* Add the actual content widget *)
            Container.add contentBox widget
        | NONE =>
            (* No content, add placeholder using alt text *)
            let
              val () = case alt of
                         SOME altText =>
                           let
                              val placeholder = Label.new(SOME altText)
                              val () = Widget.setSizeRequest placeholder (0, 200) 
                              val () = Box.packStart contentBox (placeholder, true, true, SpacingScale.small)
                           in ()
                           end
                       | NONE => ()
            in
              ()
            end

      (* Handle image *)
      val () = case imagePath of
          SOME path =>
            let
              val aspectFrame = AspectFrame.new (NONE, 0.0, 0.5, 1.0, false)
              val () = Widget.setSizeRequest aspectFrame (100, 100)

              val image =
                (Image.newFromFile path)
                handle _ => Image.newFromIconName (SOME "image-missing", 1)

              val () = Image.setPixelSize image 100
              val () = Container.add aspectFrame image
              val () = Box.packStart contentBox (aspectFrame, false, false, SpacingScale.small)
            in
              ()
            end
        | NONE =>
            (* No image, so handle content or placeholder *) 
            case content of
                SOME widget =>
                  (* Add the actual content widget *) 
                  Container.add contentBox widget
              | NONE =>
                  (* No content and no image, add placeholder ONLY if alt is provided *) 
                  case alt of
                      SOME altText =>
                        let
                          val placeholder = Label.new(SOME altText)
                          val () = Widget.setSizeRequest placeholder (0, 200) (* Placeholder size *)
                          val () = Box.packStart contentBox (placeholder, true, true, SpacingScale.small)
                        in ()
                        end
                    | NONE => ()
    in
      frame
    end
end