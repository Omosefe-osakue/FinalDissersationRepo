(******************************************************************************
 * FONT_SIZE: Signature for standardized font size utilities for GTK widgets.
 *
 * Semantic font sizes are provided as references for headings (h1-h6), body, and caption
 * text. Utility functions allow conversion to Pango scale, markup generation, and direct
 * application of font size to GTK labels.
 *
 * Values:
 *   - h1Size ... captionSize: References to real values representing point sizes for
 *     semantic roles (e.g., h1 for largest heading, body for normal text).
 *
 * Functions:
 *   - toPangoScale: Converts a point size to a Pango markup scale string.
 *   - withSize: Wraps a string with Pango markup for a given size.
 *   - h1 ... h6, body, caption: Convenience functions to apply a semantic size to a label.
 ******************************************************************************)
open Gtk


signature FONT_SIZE =
sig
    (* Semantic size references *)
    val h1Size : real ref  (* Largest heading (e.g., page title, ~24pt) *)
    val h2Size : real ref  (* Second largest heading (e.g., section title, ~20pt) *)
    val h3Size : real ref  (* Third largest heading (e.g., sub-section, ~18pt) *)
    val h4Size : real ref  (* Fourth largest heading (e.g., minor heading, ~16pt) *)
    val h5Size : real ref  (* Fifth largest heading (e.g., widget label, ~14pt) *)
    val h6Size : real ref  (* Smallest heading (e.g., auxiliary text, ~12pt) *)
    val bodySize : real ref (* Regular body text (e.g., paragraphs, ~12pt) *)
    val captionSize : real ref (* Caption text (e.g., footnotes, ~10pt) *)

    (* Converts a point size to a Pango scale string .
     * Example: toPangoScale 12.0 = "12000"
     *)
    val toPangoScale : real -> string

    (* Wraps a string with Pango markup for the specified font size.
     * Example: withSize "Hello" 14.0 = "<span size='14000'>Hello</span>"
     *)
    val withSize : string -> real -> string

    (* Convenience functions that take a label and text *)
    val h1 : 'a Label.class -> string -> unit
    val h2 : 'a Label.class -> string -> unit
    val h3 : 'a Label.class -> string -> unit
    val h4 : 'a Label.class -> string -> unit
    val h5 : 'a Label.class -> string -> unit
    val h6 : 'a Label.class -> string -> unit
    val body : 'a Label.class -> string -> unit
    val caption : 'a Label.class -> string -> unit
end

structure FontSize : FONT_SIZE =
struct
    val h1Size = ref 32.0      (* xxlargeSize *)
    val h2Size = ref 28.0      (* xlargeSize *)
    val h3Size = ref 24.0      (* largeSize *)
    val h4Size = ref 16.0      (* mediumSize *)
    val h5Size = ref 14.0      (* smallSize *)
    val h6Size = ref 11.0      (* xsmallSize *)
    val bodySize = ref 14.0    (* Same as h5 by default *)
    val captionSize = ref 8.0  (* xxsmallSize *)

    (* Convert point size to Pango scale (multiply by 1000) *)
    fun toPangoScale size = Int.toString (Real.round (size * 1000.0))
    fun withSize text size = "<span size='" ^ toPangoScale size ^ "'>" ^ text ^ "</span>"

    (* Convenience functions that take a label and text *)
    fun h1 label text = Label.setMarkup label (withSize text (!h1Size))
    fun h2 label text = Label.setMarkup label (withSize text (!h2Size))
    fun h3 label text = Label.setMarkup label (withSize text (!h3Size))
    fun h4 label text = Label.setMarkup label (withSize text (!h4Size))
    fun h5 label text = Label.setMarkup label (withSize text (!h5Size))
    fun h6 label text = Label.setMarkup label (withSize text (!h6Size))
    fun body label text = Label.setMarkup label (withSize text (!bodySize))
    fun caption label text = Label.setMarkup label (withSize text (!captionSize))
end
