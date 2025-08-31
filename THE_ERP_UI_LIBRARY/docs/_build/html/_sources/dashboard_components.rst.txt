Dashboard Components
====================

Overview
--------

Dashboard components are specialized UI elements designed for data visualization, analytics, and information display in the ERP UI Library. These components implement common enterprise dashboard patterns such as KPI cards, content panels, and data grids, all built with functional programming principles.

These components demonstrate how functional programming concepts can be applied to create reusable, composable UI elements for business applications.

KPI Card
--------

The ``KPICard`` component displays key performance indicators (KPIs) with attention-grabbing visual styling. Each card prominently shows a value, label, and optional trend indicator.

.. code-block:: sml

    (* Create a KPI card for sales metrics *)
    val salesKPI = KPICard.create {
      label = "Total Sales", 
      value = "$1,245,000",
      trend = SOME "+12.5% vs last month"
    }
    
    (* Create a KPI card without trend data *)
    val ordersKPI = KPICard.create {
      label = "Open Orders",
      value = "27",
      trend = NONE
    }

Key Features:

- **Visual Prominence**: Designed to highlight important metrics
- **Trend Indication**: Optional field for showing change over time
- **Flexible Content**: Supports various data formats in the value field
- **Consistent Styling**: Uses the token system for visual consistency
- **Composability**: Can be arranged in grids or other layouts

Implementation Highlights:

- **Pure Functions**: The ``create`` function is pure, producing a consistent output for the same inputs
- **Pattern Matching**: Uses SML pattern matching to handle the optional trend field
- **Immutable Widgets**: Creates immutable widget structures rather than modifying existing ones

Content Panel
--------------

The ``ContentPanel`` component provides a standardized container for various types of content, with a consistent header and optional imagery.

.. code-block:: sml

    (* Create a text-based content panel *)
    val infoPanel = ContentPanel.create {
      title = "Company Information",
      content = SOME "Founded in 2010, our company has grown to...",
      alt = NONE,
      imagePath = NONE
    }
    
    (* Create an image-based content panel *)
    val chartPanel = ContentPanel.create {
      title = "Sales Trends",
      content = NONE,
      alt = SOME "Line chart showing increasing sales trend",
      imagePath = SOME "resources/images/sales_chart.png"
    }

Key Features:

- **Consistent Headers**: Standardized title presentation
- **Content Flexibility**: Supports text content, images, or both
- **Accessibility**: Support for alternative text with images
- **Visual Consistency**: Standard padding, borders, and styling

Functional Approach to Dashboard Components
------------------------------------------

The dashboard components demonstrate several key functional programming concepts:

1. **Immutable Data Structures**: All data passed to and from components is treated as immutable
2. **Higher-Order Functions**: Event handlers are implemented as higher-order functions
3. **Pure Component Creation**: Components are created through pure functions with no side effects
4. **Pattern Matching**: Optional fields and variations are handled through pattern matching
5. **Composition**: Complex dashboards are built by composing simple components

Implementation Examples
----------------------

Creating a KPI Dashboard
~~~~~~~~~~~~~~~~~~~~~~~

Here's how multiple KPI cards can be composed to create a dashboard:

.. code-block:: sml

    (* Create a grid for KPI cards *)
    val kpiGrid = Grid.new ()
    val () = Grid.setRowSpacing kpiGrid SpacingScale.medium
    val () = Grid.setColumnSpacing kpiGrid SpacingScale.medium
    
    (* Create individual KPI cards *)
    val salesKPI = KPICard.create {
      label = "Total Sales", 
      value = "$1,245,000",
      trend = SOME "+12.5%"
    }
    
    val ordersKPI = KPICard.create {
      label = "New Orders", 
      value = "127",
      trend = SOME "+5.3%"
    }
    
    val revenueKPI = KPICard.create {
      label = "Revenue", 
      value = "$287,400",
      trend = SOME "+8.7%"
    }
    
    (* Add cards to grid *)
    val () = Grid.attach kpiGrid (salesKPI, 0, 0, 1, 1)
    val () = Grid.attach kpiGrid (ordersKPI, 1, 0, 1, 1)
    val () = Grid.attach kpiGrid (revenueKPI, 2, 0, 1, 1)

Performance Considerations
-------------------------

Dashboard components are designed with performance in mind:

1. **Minimal State**: Limited use of mutable state reduces complexity and potential issues
2. **Lazy Loading**: Support for lazy loading of content when needed
3. **Efficient Updates**: Update patterns that minimize redraws and layout recalculations
4. **Memory Management**: Careful attention to resource cleanup when components are destroyed

Best Practices
------------

When working with dashboard components:

1. **Keep It Simple**: Focus on the most important metrics rather than overwhelming users
2. **Consistent Units**: Use consistent units and formats for similar metrics
3. **Contextual Information**: Provide context for numbers (e.g., comparison to previous periods)
4. **Responsive Design**: Consider how components will look at different screen sizes
5. **Functional Composition**: Build complex dashboards by composing simple components
