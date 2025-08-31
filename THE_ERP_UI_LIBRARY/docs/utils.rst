Utilities
=========

Overview
--------

The Utils module in the ERP UI Library contains utility functions that support the creation of complex UI components. The module currently provides two key utilities:

1. **TableUtils**: Functions for creating and managing tables using GTK Grid
2. **ImageUtils**: Functions for loading and scaling images for UI components

These utilities demonstrate how functional programming principles like higher-order functions and pure functions can be applied to simplify common UI development tasks.

Table Utilities
--------------

The ``TableUtils`` structure provides functions for creating and managing dynamic tables with GTK Grid. It simplifies the process of constructing properly styled, consistent tables for displaying data in ERP applications.

.. code-block:: sml

    (* Create a table with headers and initial data *)  
    val tableData = ref [
        ["001", "Widget A", "5", "$10.00"],
        ["002", "Gadget B", "12", "$25.50"]
    ]
    
    val table = TableUtils.createTable {
        headers = ["ID", "Product Name", "Quantity", "Price"],
        rows = tableData
    }

Key Features:

- **Grid-Based Tables**: Creates tables using GTK Grid for flexible layout
- **Styled Headers**: Properly styled table headers with consistent spacing
- **Dynamic Data**: Uses references for mutable table data that can be updated
- **Consistent Styling**: Applies CSS classes for standardized appearance
- **Helper Functions**: Includes utility functions like ``appi`` for indexed iteration over lists

Implementation:

``TableUtils`` includes two main components:

1. ``appi``: A higher-order function for indexed iteration over lists, useful for creating table rows and cells

2. ``createTable``: The main function that constructs a GTK Grid widget with headers and data rows

   Parameters:
   - ``headers``: A list of strings for column headers
   - ``rows``: A reference to a list of string lists, where each inner list represents a row

   Returns:
   - A configured GTK Grid widget representing the table

Each table cell is properly styled using:
- Consistent margins via ``SpacingScale`` values
- CSS classes ("table-header-cell" and "table-data-cell")
- Proper alignment settings

Image Utilities
--------------

The ``ImageUtils`` structure provides functions for working with images in GTK-based UI components. It simplifies the process of loading, scaling, and displaying images with proper error handling.

.. code-block:: sml

    (* Load and scale an image from a file *)  
    val logoImage = ImageUtils.scaledImageFromFile ("resources/logo.png", (64, 64))
    
    (* Can be added directly to containers *)  
    val () = Container.add imageContainer logoImage

Key Features:

- **Image Loading**: Simplified loading of images from file paths
- **Automatic Scaling**: Built-in scaling to requested dimensions
- **Error Handling**: Graceful fallback to a default icon if image loading fails
- **Integration with GTK**: Returns Gtk.Image.t widgets ready for use in UI

Implementation:

``ImageUtils`` provides a key function:

``scaledImageFromFile``: Loads and scales an image from a file path

   Parameters:
   - ``path``: String path to the image file
   - ``(width, height)``: Tuple of integers specifying the desired dimensions

   Returns:
   - A GTK Image widget containing the loaded and scaled image
   - If loading fails, returns a "image-missing" stock icon instead

The implementation uses GTK's GdkPixbuf for loading and scaling images, handling errors gracefully with pattern matching and exception handling.

Functional Programming Approach
-----------------------------

Both utilities demonstrate functional programming principles:

1. **Higher-Order Functions**: ``TableUtils.appi`` takes a function as an argument
2. **Pure Functions**: Core operations have no side effects
3. **Exception Handling**: ``ImageUtils`` uses pattern matching for handling error cases
4. **Immutable Values**: Most values are treated as immutable
5. **Separation of Concerns**: Each utility focuses on a single responsibility

Usage Best Practices
------------------

When working with these utilities:

1. **Table Data Management**: Keep table data in references if it needs to be updated
2. **Image Path Management**: Ensure image paths are correct relative to the application
3. **Error Handling**: Consider the fallback behavior of ``ImageUtils`` when images might be missing
4. **Styling Consistency**: Use the built-in styling from these utilities for visual consistency
5. **Functional Style**: Leverage the functional patterns in your own code that uses these utilities
