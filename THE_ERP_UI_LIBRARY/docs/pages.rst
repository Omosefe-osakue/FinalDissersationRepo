Pages
=====

Overview
--------

The Pages module represents complete application screens in the ERP UI Library. These components combine layout elements, dashboard components, and business logic to create fully functional ERP application interfaces. The Pages module demonstrates how functional programming principles can be applied to create complex, interactive screens with clean architecture and maintainable code.

Each page is built using a consistent pattern of composition, leveraging SML's functional features to create reusable page templates that can be customized for different business needs.

Base Page Pattern
----------------

The ``BasePage`` functor provides a consistent template for all pages in the application. It implements the common structure found in ERP applications, including:

- Header with branding and user information
- Navigation menu with standardized links
- Content area with flexible layout
- Footer with copyright and auxiliary information

.. code-block:: sml

    (* Define a page-specific implementation *)
    structure MyCustomPage = BasePage(struct val title = "My Custom Page" end)
    
    (* Create an instance of the page *)
    val (page, contentBox) = MyCustomPage.create {
      stack = navigationStack,
      menuItems = SOME [
        ("Dashboard", "dashboard"),
        ("Inventory", "inventory"),
        ("Settings", "settings"),
        ("Logout", "login")
      ]
    }
    
    (* Add page-specific content to the contentBox *)
    val myContent = Box.new (Orientation.VERTICAL, 10)
    val () = Container.add contentBox myContent

Key Features:

- **Functor-Based Design**: Uses SML functors to create page templates with customizable parameters
- **Consistent Layout**: Standardized structure for all pages
- **Navigation Integration**: Built-in support for navigation between pages
- **Content Flexibility**: Exposes content container for page-specific components

Login Page
---------

The ``LoginPage`` implements a secure authentication interface with username and password fields, validation, and error handling.

.. code-block:: sml

    (* Create a login page and add it to the navigation stack *)
    val loginPage = LoginPage.create {
      stack = navigationStack
    }
    val () = Stack.addNamed navigationStack (loginPage, "login")

Key Features:

- **Form Validation**: Client-side validation for form inputs
- **Error Handling**: Clear error messages for authentication failures
- **Security Considerations**: Password field masking and secure input handling
- **Navigation Flow**: Automatic transition to dashboard upon successful login

Dashboard Page
------------

The ``DashboardPage`` presents a high-level overview of business metrics and activities using KPI cards and content panels.

.. code-block:: sml

    (* Create a dashboard page *)
    val (dashboardPage, contentBox) = DashboardPage.create {
      stack = navigationStack,
      menuItems = SOME [
        ("Dashboard", "dashboard"),
        ("Inventory", "inventory"),
        ("Settings", "settings"),
        ("Logout", "login")
      ]
    }
    val () = Stack.addNamed navigationStack (dashboardPage, "dashboard")

Key Features:

- **KPI Display**: Prominent display of key business metrics
- **Activity Overview**: Visualization of recent business activities
- **Interactive Elements**: Clickable areas for drilling down into details
- **Responsive Layout**: Grid-based layout that adapts to different screen sizes

Inventory Page
-------------

The ``InventoryPage`` provides functionality for viewing and managing inventory items, with filtering, sorting, and CRUD operations.

.. code-block:: sml

    (* Create an inventory page *)
    val (inventoryPage, contentBox) = InventoryPage.create {
      stack = navigationStack,
      menuItems = SOME [
        ("Dashboard", "dashboard"),
        ("Inventory", "inventory"),
        ("Settings", "settings"),
        ("Logout", "login")
      ]
    }
    val () = Stack.addNamed navigationStack (inventoryPage, "inventory")

Key Features:

- **Data Grid**: Tabular display of inventory items
- **Filtering**: Ability to filter items by various criteria
- **Sorting**: Interactive column sorting
- **CRUD Operations**: Support for adding, editing, and removing inventory items

Settings Page
-----------

The ``SettingsPage`` allows users to configure application preferences, user settings, and system parameters.

.. code-block:: sml

    (* Create a settings page *)
    val (settingsPage, contentBox) = SettingsPage.create {
      stack = navigationStack,
      menuItems = SOME [
        ("Dashboard", "dashboard"),
        ("Inventory", "inventory"),
        ("Settings", "settings"),
        ("Logout", "login")
      ]
    }
    val () = Stack.addNamed navigationStack (settingsPage, "settings")

Key Features:

- **Form Layout**: Organized grouping of related settings
- **Preference Persistence**: Saving and loading of user preferences
- **System Configuration**: Access to system-level settings
- **Validation**: Validation of user inputs before saving

Sales Order Page
--------------

The ``SalesOrderPage`` provides an interface for creating, viewing, and managing customer orders.

.. code-block:: sml

    (* Create a sales order page *)
    val (salesOrderPage, contentBox) = SalesOrderPage.create {
      stack = navigationStack,
      menuItems = SOME [
        ("Dashboard", "dashboard"),
        ("Inventory", "inventory"),
        ("Settings", "settings"),
        ("Logout", "login")
      ]
    }
    val () = Stack.addNamed navigationStack (salesOrderPage, "salesorder")

Key Features:

- **Order Entry**: Form for creating new sales orders
- **Line Item Management**: Adding and removing items from orders
- **Pricing Calculation**: Automatic calculation of totals and taxes
- **Order Status**: Visualization of order processing status

Functional Approach to Page Design
--------------------------------

The pages module demonstrates several key functional programming concepts:

1. **Functors**: Using SML functors to create parameterized page templates
2. **Higher-Order Functions**: Implementing event handlers as higher-order functions
3. **Immutable State Management**: Treating page state as immutable data
4. **Composition**: Building complex pages by composing simpler components
5. **Type Safety**: Using SML's type system to ensure page consistency

Navigation Architecture
---------------------

The navigation system uses GTK's Stack widget and a functional approach to page transitions:

.. code-block:: sml

    (* Navigate to another page *)
    fun navigateToPage pageName =
      let
        val () = print ("Navigating to " ^ pageName ^ "\n")
        val () = Stack.setVisibleChildName navigationStack pageName
      in
        ()
      end
      
    (* Connect navigation to a button *)
    val () = Signal.connect button (Button.clickedSig, fn _ => navigateToPage "inventory")

Key Navigation Concepts:

1. **Declarative Transitions**: Page transitions are handled through declarative function calls
2. **Stack-Based Architecture**: Pages are managed in a stack for efficient memory usage
3. **Named Pages**: Pages are referenced by name for easy navigation
4. **Clean Separation**: Navigation logic is separated from page content

Best Practices
------------

When developing with the Pages module:

1. **Use the BasePage Functor**: Start with the BasePage functor to ensure consistency
2. **Separate Content Creation**: Keep page-specific content creation separate from the base page
3. **Handle Events Functionally**: Use higher-order functions for event handling
4. **Maintain Immutability**: Don't modify page components after creation
5. **Follow Navigation Patterns**: Use consistent navigation methods between pages
