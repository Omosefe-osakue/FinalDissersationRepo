Design Tokens
=============

Overview
--------

Design tokens form the foundation of the ERP UI Library's design system. They provide a centralized way to manage visual attributes such as font sizes, spacing, and colors across the application, ensuring consistency and making it easier to maintain or update the design.

The token system demonstrates functional programming's ability to create simple, reusable abstractions that can be composed to build more complex systems.



Font Size Hierarchy
~~~~~~~~~~~~~~~~~~~

The module provides a semantic type scale that ranges from largest (h1) to smallest (caption):

.. code-block:: text

    h1Size     -> 32.0pt - Main page titles, most prominent text
    h2Size     -> 28.0pt - Section titles 
    h3Size     -> 24.0pt - Subsection headings
    h4Size     -> 16.0pt - Minor headings
    h5Size     -> 14.0pt - Widget labels, small headings
    h6Size     -> 11.0pt - Auxiliary text elements
    bodySize   -> 14.0pt - Regular paragraph text (same as h5 by default)
    captionSize -> 8.0pt  - Small caption text, footnotes

Usage Patterns
~~~~~~~~~~~~~~

1. **Direct Access to Size Values**

   .. code-block:: sml

       (* Access the raw size values directly when needed *)
       val largestSize = !FontSize.h1Size  (* 32.0 points *)
       val normalTextSize = !FontSize.bodySize  (* 14.0 points *)

2. **Applying Font Sizes to Labels**

   The most common usage pattern is to apply a semantic font size directly to a GTK label:

   .. code-block:: sml

       (* Create a new label *)
       val titleLabel = Label.new (SOME "Dashboard")

       (* Apply h1 style to make it a page title *)
       val () = FontSize.h1 titleLabel "Dashboard"

       (* For secondary headings, use h2 *)
       val sectionLabel = Label.new (SOME "Recent Activity")
       val () = FontSize.h2 sectionLabel "Recent Activity"

       (* For regular text, use body *)
       val descriptionLabel = Label.new (SOME "This dashboard shows KPIs")
       val () = FontSize.body descriptionLabel "This dashboard shows KPIs"

3. **Using Pango Markup for Complex Text**

   .. code-block:: sml

       (* Create text with custom size using Pango markup *)
       val customSizedText = FontSize.withSize "Critical Alert" (!FontSize.h3Size)
       val alertLabel = Label.new (NONE)
       val () = Label.setMarkup alertLabel customSizedText

       (* Combine with other markup for rich text *)
       val enrichedText = "<b>" ^ (FontSize.withSize "Warning" (!FontSize.h4Size)) ^ "</b>"
       val () = Label.setMarkup warningLabel enrichedText

4. **Converting Sizes for Other Uses**

   .. code-block:: sml

       (* Convert to Pango scale (multiplied by 1000) *)
       val pangoSize = FontSize.toPangoScale (!FontSize.bodySize)  (* "14000" *)

Best Practices
~~~~~~~~~~~~~~

1. **Use Semantic Sizes**: Always use the semantic functions (h1, h2, etc.) rather than hard-coded values to ensure consistency across the application.

2. **Maintain Visual Hierarchy**: Use the font size hierarchy to establish clear relationships between elements:
   
   - h1, h2 for main page elements
   - h3, h4 for sections and subsections
   - h5, h6 for widget labels and auxiliary text
   - body for regular paragraph text
   - caption for small supporting text

3. **Consistent Approach**: Always use the same pattern for similar elements; for example, all page titles should use h1, all section headings should use h2, etc.

4. **Modularity**: The values are stored as references, allowing for potential runtime adjustment if needed (though this should be used sparingly).

Spacing Scale
-------------

The ``SpacingScale`` module implements a consistent spacing system based on a modular scale. It provides standardized values for margins, padding, and layout spacing to ensure visual consistency throughout the application.

.. code-block:: sml

    (* Use spacing values for consistent layout *)
    val () = Container.setBorderWidth container SpacingScale.medium
    val () = Grid.setColumnSpacing grid SpacingScale.large

Key Components:

- **Base Unit**: The fundamental spacing unit (4px) from which other values are derived
- **Scale Values**: ``xxsmall``, ``xsmall``, ``small``, ``medium``, ``large``, ``xlarge``
- **Arithmetic Relationship**: Each value is related to others through a consistent scale factor
- **Semantic Aliases**: Named references to common spacing use cases like ``inline``, ``stack``, ``inset``, and ``section``

Spacing Values
~~~~~~~~~~~~~~

The module provides a complete set of spacing values based on a 4px base unit:

.. code-block:: text

    xxsmall  -> 4px  - Minimal spacing for tight layouts (1× base unit)
    xsmall   -> 8px  - Fine spacing for compact elements (2× base unit)
    small    -> 12px - Default spacing between related items (3× base unit)
    medium   -> 16px - Standard container padding (4× base unit)
    large    -> 24px - Spacing between major UI sections (6× base unit)
    xlarge   -> 32px - Generous spacing for visual separation (8× base unit)

Semantic Spacing
~~~~~~~~~~~~~~~~

Beyond numeric scale values, the module offers semantic aliases for common layout needs:

.. code-block:: text

    inline  -> 8px  (xsmall) - Horizontal spacing between inline elements
    stack   -> 12px (small)  - Vertical spacing between stacked elements
    inset   -> 16px (medium) - Internal padding for container elements
    section -> 24px (large)  - Separation between major content sections

Usage Patterns
~~~~~~~~~~~~~~

1. **Basic Spacing Application**

   .. code-block:: sml
   
       (* Apply spacing to GTK containers *)
       val container = Box.new (Orientation.VERTICAL, SpacingScale.small)
       val () = Container.setBorderWidth container SpacingScale.medium
       
       (* Apply spacing to grid layouts *)
       val () = Grid.setRowSpacing grid SpacingScale.medium
       val () = Grid.setColumnSpacing grid SpacingScale.small

2. **Using Semantic Aliases**

   .. code-block:: sml
   
       (* Create a layout with semantic spacing *)
       val mainBox = Box.new (Orientation.VERTICAL, SpacingScale.stack)
       val () = Container.setBorderWidth mainBox SpacingScale.inset
       
       (* Separate major sections *)
       val () = Widget.setMarginBottom sectionTitle SpacingScale.section

3. **Custom Spacing with get Function**

   .. code-block:: sml
   
       (* Get spacing for custom step count *)
       val customSpacing = SpacingScale.get 5  (* 20px = 5× base unit *)
       val () = Widget.setMarginTop specialWidget customSpacing

4. **Combining with Other Design Tokens**

   .. code-block:: sml
   
       (* Create a card with consistent tokens *)
       val card = Box.new (Orientation.VERTICAL, SpacingScale.small)
       val cardLabel = Label.new (SOME "KPI Card")
       val () = FontSize.h4 cardLabel "KPI Card"
       val () = Container.setBorderWidth card SpacingScale.inset

Best Practices
~~~~~~~~~~~~~~

1. **Consistent Usage**: Use the SpacingScale values throughout your application rather than hardcoded pixel values to maintain consistency.

2. **Semantic Purpose**: Select spacing values based on their semantic purpose:
   
   - Use ``inline`` for horizontal spacing between elements in a row
   - Use ``stack`` for vertical spacing between elements in a column
   - Use ``inset`` for padding inside containers and components
   - Use ``section`` to separate major content sections

3. **Visual Rhythm**: Follow consistent patterns where similar relationships use the same spacing values:
   
   - Related elements: ``small`` or ``xsmall``
   - Parent-child relationships: ``medium``
   - Separate sections: ``large``
   - Major page areas: ``xlarge``

4. **Responsive Considerations**: Remember that spacing contributes to how components adapt to different screen sizes. Using the SpacingScale system makes it easier to adjust spacing globally if needed.

5. **Extensibility**: The ``baseUnit`` value is stored as a reference, allowing for potential adjustment if the entire spacing scale needs to be proportionally modified.

CSS Loader
----------

The ``CssLoader`` module handles the application of CSS styles to GTK widgets, enabling consistent visual theming across the ERP UI application. It provides a functional interface to GTK's style system, bridging the gap between CSS and Standard ML.

.. code-block:: sml

    (* Apply CSS classes to widgets *)
    val card = Box.new (Orientation.VERTICAL, SpacingScale.small)
    val () = CssLoader.addClassToWidget card "kpi-card"
    
    (* Load global CSS stylesheet *)
    val () = CssLoader.loadStyles "resources/css/erp-theme.css"

Key Components:

- **Class Application**: Functions for adding CSS classes to widgets
- **CSS Loading**: Utilities for loading CSS from external files
- **Error Handling**: Functional approach to CSS loading errors

Core Functionality
~~~~~~~~~~~~~~~~~~

The module provides two primary functions:

1. **loadStyles**: Loads a CSS stylesheet globally for the application

   .. code-block:: text
   
       loadStyles: string -> unit
       
       # Loads CSS from the specified path and applies it to the application
       # Handles errors gracefully using functional error handling

2. **addClassToWidget**: Applies a CSS class to a specific widget

   .. code-block:: text
   
       addClassToWidget: 'a Widget.class -> string -> unit
       
       # Applies the named CSS class to the specified widget
       # Works with any widget that inherits from GTK's Widget class

Usage Patterns
~~~~~~~~~~~~~~

1. **Global Stylesheet Application**

   Load application-wide styles at startup:

   .. code-block:: sml
   
       (* Load the main application stylesheet *)
       val () = CssLoader.loadStyles "resources/css/erp-theme.css"
       
       (* Load additional theme variants if needed *)
       val () = CssLoader.loadStyles "resources/css/dark-theme.css"

2. **Component-Specific Styling**

   Apply specific CSS classes to individual components:

   .. code-block:: sml
   
       (* Create widgets with specific styling *)
       val kpiCard = Box.new (Orientation.VERTICAL, SpacingScale.small)
       val () = CssLoader.addClassToWidget kpiCard "kpi-card"
       
       val alertBanner = Box.new (Orientation.HORIZONTAL, SpacingScale.small)
       val () = CssLoader.addClassToWidget alertBanner "alert"
       val () = CssLoader.addClassToWidget alertBanner "alert-warning"

3. **Combined with Other Design Tokens**

   Use CSS classes alongside other design tokens for comprehensive styling:

   .. code-block:: sml
   
       (* Create a styled header with tokens and CSS *)
       val header = Box.new (Orientation.HORIZONTAL, SpacingScale.medium)
       val headerLabel = Label.new (SOME "Dashboard")
       
       (* Apply design tokens *)
       val () = FontSize.h1 headerLabel "Dashboard"
       val () = Widget.setMargin header SpacingScale.inset
       
       (* Apply CSS classes *)
       val () = CssLoader.addClassToWidget header "page-header"
       val () = CssLoader.addClassToWidget headerLabel "header-title"

4. **Error Handling with Functional Programming**

   The module uses functional error handling patterns:

   .. code-block:: sml
   
       (* CSS loading with error handling built in *)
       val () = CssLoader.loadStyles "path/to/theme.css"
       (* Errors are logged through GiraffeLog and handled gracefully *)

CSS Styling Guidelines
~~~~~~~~~~~~~~~~~~~~~

When creating CSS for use with the CssLoader module:

1. **Use Class Selectors**: Structure your CSS to work with the class-based approach:

   .. code-block:: css
   
       .kpi-card {
           background-color: #ffffff;
           border-radius: 4px;
           box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
       }
       
       .alert {
           padding: 8px 16px;
           border-left: 4px solid;
       }
       
       .alert-warning {
           background-color: #fff3cd;
           border-left-color: #ffc107;
       }

2. **Widget-Specific Styling**: Target GTK widget classes when needed:

   .. code-block:: css
   
       button.primary {
           background-color: #0d6efd;
           color: white;
       }
       
       label.header-title {
           font-weight: bold;
           color: #333333;
       }

Best Practices
~~~~~~~~~~~~~~

1. **Separation of Concerns**: Use the CssLoader to separate visual styling from functional behavior in your SML code.

2. **Consistent Class Naming**: Establish a consistent naming convention for CSS classes, such as:
   
   - Component name (e.g., ``kpi-card``, ``data-table``)
   - Component variants (e.g., ``alert-success``, ``button-primary``)
   - State indicators (e.g., ``is-active``, ``is-disabled``)

3. **Style Hierarchy**: Organize your CSS files to reflect your component hierarchy:
   
   - Base styles for all components
   - Component-specific styles
   - Page-specific overrides

4. **Load CSS Early**: Call ``loadStyles`` early in your application initialization to ensure styles are applied before widgets are rendered.

5. **Functional Composition**: Combine CssLoader with other token systems (FontSize, SpacingScale) for complete styling:
   
   - Use FontSize for typography
   - Use SpacingScale for layout margins and padding
   - Use CssLoader for colors, borders, and other visual properties

ERP Theme Implementation
~~~~~~~~~~~~~~~~~~~~~~~

The ERP UI Library includes a comprehensive stylesheet (``style.css``) that implements a consistent visual language across the application. This CSS file is loaded via the CssLoader module and provides three theme variants: light (default), dark, and pastel.

.. code-block:: css

    /* Light theme styles (default) */
    window {
        background-color: #F8F9FA;
        color: #212529;
        font-size: 14px;
        font-family: sans-serif;
    }
    
    /* Dark theme styles */
    window.dark, .dark window {
        background-color: #212529;
        color: #F8F9FA;
        font-family: sans-serif;
    }
    
    /* Pastel theme styles */
    window.pastel, .pastel window {
        background-color: #e3f0fb;
        color: #3A4454;
        font-family: sans-serif;
    }

The stylesheet provides consistent styling for common ERP UI components through a system of standardized CSS classes:

1. **Basic Controls**
   
   - ``.erp-button``, ``.erp-button-primary``, ``.erp-button-secondary`` - Button variants
   - ``.erp-entry``, ``.erp-input`` - Text input fields
   - ``.erp-label`` - Text labels

2. **Data Visualization**
   
   - ``.excel-table`` - Data grid with Excel-like appearance
   - ``.excel-cell``, ``.excel-header`` - Table cell styling
   - ``.excel-row-number``, ``.excel-column-letter`` - Row/column identifiers

Using this themed approach allows for consistent styling across the ERP application while enabling different visual themes to be applied universally with a single CSS class change.

To apply the themes:

.. code-block:: sml

    (* Load the base CSS file *)  
    val () = CssLoader.loadStyles "path/to/style.css"
    
    (* Apply dark theme to the main window *)
    val mainWindow = Window.new WindowType.TOPLEVEL
    val () = CssLoader.addClassToWidget mainWindow "dark"
    
    (* Or apply pastel theme *)
    val () = CssLoader.addClassToWidget mainWindow "pastel"

Benefits of Token-Based Design
------------------------------

1. **Consistency**: Ensures UI elements maintain a consistent look and feel
2. **Maintainability**: Changes to design values can be made in one place
3. **Scalability**: Easy to extend with new token types as needed
4. **Abstraction**: Hides implementation details of styling from component logic
5. **Functional Purity**: Promotes immutability and referential transparency

Implementation Details
---------------------

The token system demonstrates several functional programming concepts:

- **Immutable References**: Values are stored as ``ref`` types, preserving the ability to update them system-wide while maintaining local immutability. For example, in FontSize.sml:

  .. code-block:: sml

      val h1Size = ref 32.0  (* Stored as a reference *)
      val h2Size = ref 28.0

  This allows potential theme changes while ensuring that individual component usages remain pure.

- **Pure Functions**: Token operations don't produce side effects, focusing only on their input-output relationships. For example, in FontSize.sml:

  .. code-block:: sml

      (* Pure function converting size to Pango scale *)
      fun toPangoScale size = Int.toString (Real.round (size * 1000.0))

- **Higher-Order Functions**: Token application functions take widgets and functions as parameters. For example, in CssLoader.sml:

  .. code-block:: sml
  
      (* Higher order function for applying styles *)
      fun addClassToWidget widget className =
        let
          val context = Widget.getStyleContext widget
        in
          StyleContext.addClass context className
        end

- **Composition**: Tokens can be combined to create more complex styles through functional composition. For example, in SpacingScale.sml:

  .. code-block:: sml
  
      (* Building more complex spaces through composition *)
      val section = large     (* 24px = 6× base unit *)

Example: Combining Tokens
-------------------------

The real power of the token system emerges when combining multiple token systems to create cohesive UI components. Here's a complete example of creating a styled KPI card component using all three token systems:

.. code-block:: sml

    (* Create a KPI Card component with consistent styling *)
    fun createKpiCard {label, value, trend} =
      let
        (* Create the container box with proper spacing *)
        val card = Box.new (Orientation.VERTICAL, SpacingScale.small)
        val () = Container.setBorderWidth card SpacingScale.inset
        
        (* Apply CSS classes for visual styling *)
        val () = CssLoader.addClassToWidget card "kpi-card"
        
        (* Create and style the label *)
        val labelWidget = Label.new (SOME label)
        val () = CssLoader.addClassToWidget labelWidget "kpi-label"
        val () = FontSize.h5 labelWidget label
        val () = Widget.setHalign labelWidget Align.START
        
        (* Create and style the value with larger font *)
        val valueWidget = Label.new (SOME value)
        val () = CssLoader.addClassToWidget valueWidget "kpi-value"
        val () = FontSize.h2 valueWidget value
        val () = Widget.setHalign valueWidget Align.START
        
        (* Add optional trend indicator if provided *)
        val () = case trend of
                   NONE => ()
                 | SOME trendText => 
                     let
                       val trendWidget = Label.new (SOME trendText)
                       val () = CssLoader.addClassToWidget trendWidget "kpi-trend"
                       val () = FontSize.caption trendWidget trendText
                       val () = Widget.setHalign trendWidget Align.START
                     in
                       Box.packEnd card (trendWidget, false, false, 0)
                     end
        
        (* Pack widgets into container *)
        val () = Box.packStart card (labelWidget, false, false, 0)
        val () = Box.packStart card (valueWidget, false, false, 0)
      in
        card
      end

This example demonstrates:

1. **Consistent Spacing**: Using ``SpacingScale.small`` for vertical spacing and ``SpacingScale.inset`` for padding
2. **Typography Hierarchy**: Using ``FontSize.h2`` for the value, ``FontSize.h5`` for the label, and ``FontSize.caption`` for the trend
3. **Visual Styling**: Using CSS classes (``kpi-card``, ``kpi-label``, etc.) for colors, backgrounds, and borders
4. **Functional Pattern**: Using a pure function that takes parameters and returns a styled widget

The complementary CSS might look like:

.. code-block:: css

    .kpi-card {
        background-color: #ffffff;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
    
    .kpi-value {
        color: #0D6EFD;
        font-weight: 700;
    }
    
    .kpi-trend {
        color: #198754;
    }

This approach demonstrates how tokens enable consistent, maintainable UI components through functional composition.

.. code-block:: sml

    (* Create a card with consistent padding and typography *)
    fun createInfoCard title content =
      let
        val cardBox = Box.new (Orientation.VERTICAL, SpacingScale.small)
        val () = Container.setBorderWidth cardBox SpacingScale.medium
        val () = CssLoader.addClassToWidget cardBox "info-card"
        
        val titleLabel = Label.new (SOME title)
        val () = FontSize.h4 titleLabel title
        val () = Widget.setHalign titleLabel Align.START
        
        val contentLabel = Label.new (SOME content)
        val () = FontSize.body contentLabel content
        
        val () = Box.packStart cardBox (titleLabel, false, false, 0)
        val () = Box.packStart cardBox (contentLabel, true, true, SpacingScale.small)
      in
        cardBox
      end
