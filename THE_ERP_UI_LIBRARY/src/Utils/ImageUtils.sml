(* Utility functions for working with images in GTK *)

structure ImageUtils = struct
  open Gtk
  open GdkPixbuf

  (*
    [scaledImageFromFile (path, (width, height))] loads an image from the given file path,
    scales it to the given width and height, and returns a Gtk.Image.t widget.
    If the image cannot be loaded, returns a fallback icon.
  *)
  fun scaledImageFromFile (path: string, (width: int, height: int)) : Gtk.Image.t =
    let
      val pixbuf = Pixbuf.newFromFile path
      val scaledPixbuf =
        getOpt (
          Pixbuf.scaleSimple pixbuf (LargeInt.fromInt width, LargeInt.fromInt height, InterpType.BILINEAR),
          pixbuf
        )
    in
      Image.newFromPixbuf (SOME scaledPixbuf)
    end
    handle GLib.Error _ => Image.newFromIconName (SOME "image-missing", 1)
end
