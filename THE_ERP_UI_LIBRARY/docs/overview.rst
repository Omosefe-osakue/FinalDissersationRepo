Overview
========

The ERP UI Library
------------------

The ERP UI Library is a comprehensive Standard ML (SML) library for building Enterprise Resource Planning (ERP) user interfaces using functional programming principles. It demonstrates how functional programming concepts can be applied to create maintainable, type-safe, and consistent UI components for complex business applications.

Core Design Principles
---------------------

1. **Pure Functional Approach**: Emphasizes immutability and pure functions to reduce side effects and improve predictability
2. **Strong Type System**: Leverages SML's powerful type system to prevent runtime errors
3. **Composition Over Inheritance**: Uses functional composition to build complex components from simpler ones
4. **Consistent Design Language**: Implements a design token system for consistent visual styling
5. **Modular Architecture**: Organizes code into well-defined modules with clear interfaces

Library Structure
----------------

The library is organized into five main module categories:

1. **Tokens**: Design system primitives like font sizes, spacing scales, and CSS utilities
2. **Layout Components**: Structural UI elements like headers, footers, and navigation
3. **Dashboard Components**: Specialized widgets for data visualization and KPIs
4. **Pages**: Complete page implementations built from components
5. **Utils**: Helper functions and utilities

Technology Stack
--------------

* **Standard ML**: The core programming language providing functional features and type safety
* **Giraffe**: SML bindings for the GTK UI toolkit
* **GTK+**: The underlying UI toolkit for rendering widgets and handling events

Functional Programming Features
------------------------------

The library showcases several key functional programming concepts:

* Higher-order functions for event handling and component customization
* Function composition for building complex behaviors
* Pattern matching for robust handling of component variations
* Immutable data structures to simplify state management
* Functors for creating parameterized components

Example Usage
-----------

Here's a simplified example of how components can be composed:

.. code-block:: sml

    (* Create a basic dashboard page *)
    val (page, contentBox) = DashboardPage.create {
      stack = navigationStack,
      menuItems = SOME [
        ("Dashboard", "dashboard"),
        ("Inventory", "inventory"),
        ("Settings", "settings")
      ]
    }

    (* Add a KPI card to track sales *)
    val salesKPI = KPICard.create {
      label = "Monthly Sales", 
      value = "$123,456",
      trend = SOME "+10% vs last month"
    }
    
    (* Add the KPI to the page content *)
    val () = Container.add contentBox salesKPI
