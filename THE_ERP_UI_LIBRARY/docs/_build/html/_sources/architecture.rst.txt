Architecture
============

System Architecture
------------------

The ERP UI Library is built on a functional architecture that emphasizes immutability, composition, and type safety. This architectural approach differs significantly from traditional object-oriented UI frameworks, providing unique advantages for complex enterprise applications.

Key Architectural Principles
---------------------------

1. **Functional Core, Imperative Shell**
   
   The library follows the "functional core, imperative shell" pattern:
   
   * **Functional Core**: The inner logic of components is implemented with pure functions
   * **Imperative Shell**: GTK interactions at the boundaries are handled with imperative code
   * **Clear Separation**: Distinct boundary between pure functional code and side-effecting code

2. **Module Hierarchy**
   
   The codebase is organized into a clear module hierarchy:
   
   .. code-block:: text
   
       THE_ERP_UI_LIBRARY/
       ├── code/
       │   ├── main.sml           # Entry point and application setup
       │   └── src/               # Library components
       │       ├── Tokens/        # Design system primitives
       │       ├── Utils/         # Helper functions
       │       ├── LayoutComponents/ # Structural components
       │       ├── DashboardComponents/ # Data visualization
       │       └── Pages/         # Complete page implementations

3. **Component Composition**
   
   Components are designed for composition:
   
   * Pages are composed of layout components and dashboard components
   * Layout components are composed of primitive widgets and other layout components
   * Higher-level components delegate to lower-level components rather than inheriting from them

4. **Functor-Based Templates**
   
   The library uses SML functors to create parameterized templates:
   
   * ``BasePage`` functor creates page templates with consistent structure
   * Functors enable code reuse while maintaining type safety
   * Parameterization allows for customization without code duplication

Component Interaction Flow
-------------------------

The diagram below illustrates how components interact in a typical application flow:

.. code-block:: text

    User Input → Widget Events → Event Handlers → State Updates → UI Updates
        │             │              │                │             │
        └─────────────┴──────────────┘                └─────────────┘
                      │                                     │
                  Pure Functions                       Side Effects
                (Business Logic)                    (GTK Interactions)

In this flow:

1. User interacts with GTK widgets
2. Events are captured by event handlers
3. Pure functions process the events and compute new state
4. State changes trigger UI updates via GTK functions

State Management
--------------

The library manages state using functional patterns:

1. **Immutable State**:
   
   * State is represented as immutable values
   * Updates create new state rather than mutating existing state
   * References (``ref``) are used where necessary for global state

2. **Unidirectional Data Flow**:
   
   * State flows down from containers to contained components
   * Events flow up from components to containers
   * Clear, predictable data flow in a single direction

3. **Centralized App State**:
   
   * ``AppState`` module provides centralized state management
   * Components access state through pure functions
   * Updates follow a consistent pattern

Type System Usage
---------------

The library leverages SML's type system for safety and clarity:

1. **Signatures and Structures**:
   
   * Components define clear signatures (interfaces)
   * Implementations are provided in structures
   * Abstract types hide implementation details

2. **Algebraic Data Types**:
   
   * Sum types for representing variants (e.g., dialog types)
   * Product types for representing complex data
   * Pattern matching for exhaustive handling of all cases

3. **Parameterized Types**:
   
   * Polymorphic functions for flexibility
   * Type constructors for creating specialized types
   * Type annotations for clarity

GTK Integration
-------------

The library integrates with GTK while maintaining functional principles:

1. **Wrapping Imperative APIs**:
   
   * Pure function wrappers around imperative GTK functions
   * Clear separation between pure logic and GTK interactions
   * Consistent patterns for widget creation and manipulation

2. **Signal Handling**:
   
   * Higher-order functions for event handling
   * Clean separation of event logic from UI structure
   * Pure functions for computing responses to events

3. **Widget Lifecycle**:
   
   * Functional approach to creating widget hierarchies
   * Careful management of widget references
   * Consistent patterns for widget destruction

Error Handling
------------

The library uses functional error handling patterns:

1. **Option Types**:
   
   * ``option`` type for representing optional values
   * Pattern matching for handling presence/absence
   * Clear handling of "no value" cases

2. **Result Types**:
   
   * Custom result types for operations that can fail
   * Pattern matching for handling success/failure
   * Composition of results through higher-order functions

3. **Exceptions**:
   
   * Limited use of exceptions for truly exceptional conditions
   * Clean exception boundaries
   * Consistent error reporting

Build System
-----------

The library uses a structured build system:

1. **Makefile-Based Build**:
   
   * Central ``Makefile`` for primary build tasks
   * ``app.mk`` for application-specific build configuration
   * Consistent build patterns across environments

2. **PolyML Configuration**:
   
   * ``polyml-libs.sml`` for library dependencies
   * ``polyml-app.sml`` for application configuration
   * Clean separation of library and application builds

3. **Documentation Generation**:
   
   * Sphinx-based documentation system
   * RST format for documentation files
   * Automated HTML generation

Application Structure
-------------------

A typical application built with the library has this runtime structure:

.. code-block:: text

    - App
      |- Main Window
         |- Navigation Stack
            |- Login Page
            |- Dashboard Page
               |- Header
               |- KPI Cards
               |- Content Panels
               |- Footer
            |- Inventory Page
            |- Settings Page
            |- Sales Order Page

This structure is created through function composition rather than inheritance, with each component created by functions that return GTK widgets.

Design Patterns
-------------

The library demonstrates several functional design patterns:

1. **Smart Constructors**:
   
   * Functions that validate inputs and ensure invariants
   * Abstraction of complex construction logic
   * Consistent naming patterns (``create``, ``build``, etc.)

2. **Higher-Order Components**:
   
   * Functions that transform or enhance existing components
   * Separation of generic and specific component logic
   * Composition of behaviors through function composition

3. **Type-Driven Development**:
   
   * Using types to guide implementation
   * Designing interfaces before implementations
   * Leveraging the type system for correctness

Architectural Benefits
--------------------

This functional architecture provides several benefits:

1. **Predictability**: Pure functions produce consistent results
2. **Testability**: Pure functions are easier to test
3. **Maintainability**: Clear separation of concerns simplifies maintenance
4. **Scalability**: Composition enables building complex systems from simple parts
5. **Reliability**: Strong typing and immutability reduce certain classes of bugs
