
(******************************************************************************
 * SPACING_SCALE: Signature for standardized spacing utilities in UI layout.
 *
 * Provides predefined constants and functions for consistent spacing (margins, padding)
 * throughout the application. Spacing values are given in pixels and mapped semantically
 * for clarity and maintainability.
 *
 * Values:
 *   - xxsmall, xsmall, small, medium, large, xlarge: Predefined spacing steps (in px).
 *   - inline: Horizontal spacing between inline elements (alias for small).
 *   - stack: Vertical spacing between stacked elements (alias for medium).
 *   - inset: Internal padding for containers (alias for medium).
 *   - section: Spacing between major UI sections (alias for large).
 *
 * Functions:
 *   - get: Returns a spacing value based on the number of steps (e.g., get 2 = 8px).
 *
 * Example usage:
 * 
 * open SpacingScale
 * 
 * (* Get spacing for 2 steps (8px) *)
 * val padding = get 2
 * 
 * (* Use predefined spacing *)
 * val margin = medium  (* 16px *)
 * 
 * (* Use semantic spacing *)
 * val boxPadding = inset  (* 16px *)
 * 
 * (* In GTK context *)
 * val box = Gtk.Box.new(Gtk.Orientation.VERTICAL, stack)
 * val () = Gtk.Container.setBorderWidth container inset
 *
 * Author: Omosefe Osakue
 * Date: 2025-05-09
 ******************************************************************************)

signature SPACING_SCALE =
sig
    (* Base spacing unit in pixels *)
    val baseUnit : LargeInt.int ref
    
    (* Predefined spacing steps *)
    val xxsmall : LargeInt.int  (* 4px: Extra extra small spacing, e.g., fine grid lines *)
    val xsmall : LargeInt.int   (* 8px: Extra small spacing, e.g., icon padding *)
    val small : LargeInt.int    (* 12px: Small spacing, e.g., between buttons *)
    val medium : LargeInt.int   (* 16px: Medium spacing, e.g., between form fields *)
    val large : LargeInt.int    (* 24px: Large spacing, e.g., between sections *)
    val xlarge : LargeInt.int   (* 32px: Extra large spacing, e.g., page margins *)
    
    (* Returns the spacing value for a given number of steps (0 = 0px, 1 = 4px, ...).
     * Example: get 3 = 12px
     *)
    val get : int -> LargeInt.int
    
    (* Semantic aliases for common spacing needs *)
    val inline : LargeInt.int  (* Horizontal spacing between inline elements (small) *)
    val stack: LargeInt.int   (* Vertical spacing between stacked elements (medium) *)
    val inset : LargeInt.int   (* Internal padding for containers (medium) *)
    val section : LargeInt.int (* Spacing between major sections (large) *)
end

structure SpacingScale : SPACING_SCALE =
struct
    (* Base spacing unit - can be adjusted if needed *)
    val baseUnit = ref (LargeInt.fromInt 4)
    
    (* Calculate spacing based on steps *)
    fun get steps = 
        case steps of
            0 => LargeInt.fromInt 0
          | 1 => !baseUnit      (* 4px *)
          | 2 => LargeInt.* (!baseUnit, LargeInt.fromInt 2)  (* 8px *)
          | 3 => LargeInt.* (!baseUnit, LargeInt.fromInt 3)  (* 12px *)
          | 4 => LargeInt.* (!baseUnit, LargeInt.fromInt 4)  (* 16px *)
          | 6 => LargeInt.* (!baseUnit, LargeInt.fromInt 6)  (* 24px *)
          | 8 => LargeInt.* (!baseUnit, LargeInt.fromInt 8)  (* 32px *)
          | n => if n < 0 then LargeInt.fromInt 0 
                 else LargeInt.* (!baseUnit, LargeInt.fromInt n)
    
    (* Spacing constants *)
    val xxsmall = get 1  (* 4px *)
    val xsmall = get 2   (* 8px *)
    val small = get 3    (* 12px *)
    val medium = get 4   (* 16px *)
    val large = get 6    (* 24px *)
    val xlarge = get 8   (* 32px *)
    
    (* Semantic spacing aliases *)
    val inline = xsmall     (* 8px - good for horizontal spacing *)
    val stack = small       (* 12px - good for vertical spacing *)
    val inset = medium      (* 16px - good for padding *)
    val section = large     (* 24px - good for section separation *)
end
