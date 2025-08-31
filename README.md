# ERP System UI Library (Standard ML + GTK/Giraffe)

This project implements a modular, maintainable user interface library for ERP systems using Standard ML (SML) and GTK via the Giraffe bindings. The codebase is structured for clarity, reusability, and consistency, inspired by modern UI development practices.

## Directory Structure (2025)

### Table of Contents

1.  [Overview and Objectives](#overview-and-objectives)
2.  [System Requirements](#system-requirements)
3.  [Requirements](#requirements)
4.  [Architecture and Component Hierarchy](#architecture-and-component-hierarchy)
    *   [Directory Structure](#directory-structure)
    *   [File Interactions](#file-interactions)
5.  [Detailed Component and Method Analysis](#detailed-component-and-method-analysis)
    *   [Main Application (`pages.sml`)](#main-application-pagessml)
    *   [Page Management (`Gtk.Stack`)](#page-management-gtkstack)
    *   [Core Pages (`src/Pages/`)](#core-pages-srcpages)
    *   [Layout Components (`src/LayoutComponents/`)](#layout-components-srclayoutcomponents)
    *   [Design Tokens (`src/Tokens/`)](#design-tokens-srctokens)
6.  [Documentation](#documentation)
    *   [Sphinx Documentation](#sphinx-documentation)
    *   [Building the Documentation](#building-the-documentation)
    *   [Viewing the Documentation](#viewing-the-documentation)
7.  [Code Quality and Examples](#code-quality-and-examples)
    *   [Environment Setup](#environment-setup)
    *   [Compilation](#compilation)
    *   [Running the Application](#running-the-application)

### Directory Structure

```
THE_ERP_UI_LIBRARY/
├── main.sml                  # Main application entry point
├── polyml-libs.sml           # Poly/ML library loader
├── app.mk, Makefile          # Build configuration files
├── docs/                     # Documentation files generated with Sphinx
├── src/
│   ├── DashboardComponents/   # Dashboard-specific UI widgets
│   │   ├── ContentGrid.sml
│   │   ├── ContentPanel.sml
│   │   └── KPICard.sml
│   ├── LayoutComponents/      # Shared layout and utility components
│   │   ├── AppState.sml
│   │   ├── ButtonActionRow.sml
│   │   ├── ErrorDialog.sml
│   │   ├── Footer.sml
│   │   └── Header.sml
│   ├── Pages/                 # Main application pages (views)
│   │   ├── BasePage.sml
│   │   ├── DashboardPage.sml
│   │   ├── InventoryPage.sml
│   │   ├── LoginPage.sml
│   │   ├── SalesOrderPage.sml
│   │   └── SettingsPage.sml
│   ├── Tokens/                # Design tokens and utilities
│   │   ├── CssLoader.sml
│   │   ├── FontSize.sml
│   │   ├── SpacingScale.sml
│   │   ├── Theme.sml          # Theme management
│   │   └── style.css
│   ├── Utils/                 # Utility modules (tables, images, etc.)
│   │   ├── ImageUtils.sml
│   │   └── TableUtils.sml
│   └── data/                  # Data models and sample data
│       └── SalesOrderData.sml
└── resources/                 # (Optional) Static resources/assets
```

## Component Overview

- **main.sml**: Application initialization, page stack setup, and theming.
- **src/Pages/**: Core UI pages (Login, Dashboard, Inventory, Sales Order, Settings). Each page is a self-contained module.
- **src/LayoutComponents/**: Shared layout elements and utilities (headers, footers, error dialogs, state management).
- **src/DashboardComponents/**: Specialized widgets for dashboard KPIs and content grids.
- **src/Tokens/**: Design tokens for consistent spacing, font sizes, and CSS theming. Includes utilities for loading/applying styles.
- **src/Utils/**: Utility modules (e.g., TableUtils for dynamic table construction, ImageUtils for image handling).
- **src/data/**: Example data models used by pages/components.

## Setup & Usage

1. **Install Poly/ML** and GTK+ (with Giraffe bindings).
2. **Build the project** (see `Makefile` or `app.mk`).
3. **Run the application** via Poly/ML, loading `main.sml` or using `polyml-libs.sml` as the library loader.

## Design Principles

- **Component Modularity:** Each UI element/page is an independent SML structure.
- **Declarative Layout:** UI is constructed using SML functions and modules, mirroring modern UI frameworks.
- **Design Tokens:** Centralized styling for spacing, typography, and colors via `src/Tokens/`.
- **Maintainability:** Extensive documentation and clear directory structure.

## Authors
- Omosefe Osakue (2025)

---

For further details on component APIs, customization, or contributing, see the inline documentation in each `.sml` file and the comments in `style.css`.
**Build Requirements:**

*   **Poly/ML Compiler:** The application is built using Poly/ML. Ensure it is installed and configured.
*   **Giraffe Library:** The GTK+ bindings are provided by the Giraffe library. The `Makefile` assumes it's installed (e.g., in `/opt/giraffe`). The `GIRAFFEHOME` environment variable should point to the installation directory.
*   **GTK+ 3 Libraries:** Development libraries for GTK+ 3, GLib 2.0, and GIO 2.0 are required. (`gobject-2.0`, `gio-2.0`, `gtk+-3.0` pkg-config files).
*   **Make:** The build process relies on GNU Make.

## Architecture and Component Hierarchy

### Directory Structure

```
pages/
├── src/
│   ├── Tokens/            # Design tokens (e.g., colors, fonts)
│   │   └── fontSize.sml
│   ├── Pages/             # Application pages (views)
│   │   ├── LoginPage.sml
│   │   ├── DashboardPage.sml
│   │   └── BasePage.sml
│   ├── LayoutComponents/  # Reusable layout parts
│       ├── footer.sml
│       ├── header.sml
│       └── AppState.sml
│  
├── resources/             # Static assets 
├── polyml-libs.sml        # Poly/ML library precompilation list
├── polyml-app.sml         # Main application file list for Poly/ML
├── pages.sml              # Main application entry point and setup
├── make-polyml-libs.sml   # Script to build Poly/ML libraries state
├── make-polyml-app.sml    # Script to build Poly/ML application object
├── app.mk                 # Application-specific Makefile variables
└── Makefile               # Main build script using Giraffe conventions
```

### File Interactions

1.  **`Makefile`:** Orchestrates the build process. It reads configuration from `app.mk` and `$(GIRAFFEHOME)/config.mk`. It uses `make-polyml-libs.sml` and `make-polyml-app.sml` to invoke the Poly/ML compiler.
2.  **`app.mk`:** Defines application name (`pages`), source files (`SRC_POLYML`), target binary (`TARGET_POLYML`), and library dependencies (`LIB_NAMES`: `gobject-2.0`, `gio-2.0`, `gtk-3.0`).
3.  **`make-polyml-libs.sml`:** Used by `Makefile` to potentially pre-compile library dependencies into `polyml-libs.state`. Relies on `polyml-libs.sml`.
4. **`make-polyml-app.sml`**: Build script used by the `Makefile` to compile the main application. It takes the source files listed in `polyml-app.sml` and produces the application object file.
5. **`polyml-app.sml`**: Simple list of SML source files to be included in the build. Usually just points to `main.sml`.
6. **`main.sml`**: The true entry point for the ERP UI app. It:
   - Initializes the GTK application and main window
   - Sets up the page navigation stack
   - Loads all UI modules (pages, layouts, tokens)
   - Defines the `activate` (startup) and `main` (entry) functions
7. **`src/` directory**: Contains all the actual UI code, organized into subfolders:
   - `Pages/`: Main UI pages (Login, Dashboard, etc.)
   - `LayoutComponents/`: Shared layout and helper components
   - `DashboardComponents/`: Dashboard-specific widgets
   - `Tokens/`: Design tokens and CSS
   - `Utils/`: Utility modules
   - `data/`: Example data models

All SML modules are loaded using `use` statements in `main.sml` for a clear, modular structure.

## Detailed Component and Method Analysis

### Main Application (`pages.sml`)

This file serves as the entry point and orchestrator for the UI.

*   **`activate : Gtk.Application.t -> unit -> unit`**:
    *   **Purpose:** Initializes the main application window and its contents when the GTK application is activated.
    *   **Parameters:** Takes the `Gtk.Application.t` instance.
    *   **Implementation:**
        *   Creates an `ApplicationWindow`.
        *   Sets window properties (title, default size).
        *   Creates a `Gtk.Stack` widget (`pageStack`) to manage different application pages.
        *   Instantiates `LoginPage` and `DashboardPage` from their respective modules (`src/Pages/`).
        *   Adds the instantiated pages to the `pageStack` with unique names ("login", "dashboard").
        *   Sets the initially visible page to "login".
        *   Shows the main window and all its widgets.
    *   **Code Snippet:**
        ```sml
        fun activate app () =
          let
            open Gtk
            (* Create window *)
            val window = ApplicationWindow.new app
            val () = Window.setTitle window "ERP System "
            val () = Window.setDefaultSize window (1000, 800)
            val () = Container.setBorderWidth window 0

            val pageStack = Stack.new ()
            val () = Widget.setVexpand pageStack true 
            val () = Container.add window pageStack

            (* Create and add login page *)
            val loginPage = LoginPage.create {stack = pageStack}
            val () = Stack.addNamed pageStack (loginPage, "login")

            (* Create and add dashboard page *)
            val dashboardPage = DashboardPage.create { stack = pageStack }
            val () = Stack.addNamed pageStack (dashboardPage, "dashboard")

            (* Set initial page to login *)
            val () = Stack.setVisibleChildName pageStack "login"

            (* Show window *)
            val () = Widget.showAll window
          in
            ()
          end
        ```

*   **`main : unit -> unit`**:
    *   **Purpose:** The main entry point of the SML program. Sets up and runs the GTK application event loop.
    *   **Implementation:**
        *   Creates a new `Gtk.Application` instance with a unique ID.
        *   Connects the `activate` function to the application's `activate` signal.
        *   Runs the application using `Gio.Application.run`, passing command-line arguments.
        *   Handles application exit status and potential exceptions.
    *   **Code Snippet:**
        ```sml
        fun main () =
          let
            val app = Gtk.Application.new (SOME "org.gtk.example", Gio.ApplicationFlags.FLAGS_NONE)
            val id = Signal.connect app (Gio.Application.activateSig, activate app)

            val argv = Utf8CPtrArrayN.fromList (CommandLine.name () :: CommandLine.arguments ())
            val status = Gio.Application.run app argv

            val () = Signal.handlerDisconnect app id
          in
            Giraffe.exit status
          end
            handle e => Giraffe.error 1 ["Uncaught exception\n", exnMessage e, "\n"]
        ```

### Page Management (`Gtk.Stack`)

The application uses a `Gtk.Stack` widget (`pageStack`) within the main window to handle navigation between different views (Pages).

*   **Mechanism:** Pages are added to the stack using `Stack.addNamed`, associating a widget (the page content) with a unique string name. Switching between pages is done by calling `Stack.setVisibleChildName` with the desired page's name. This allows for a single-window interface where content areas are swapped out.
*   **Dependencies:** Pages like `LoginPage` and `DashboardPage` likely receive the `pageStack` instance during creation (`{stack = pageStack}`) to enable them to trigger navigation (e.g., login button navigating to "dashboard").

### Core Pages (`src/Pages/`)

*   **`LoginPage.sml`:** Defines the `LoginPage` structure/module. Contains a `create` function that likely builds the UI elements for the login screen (username/password fields, login button) and takes the `Gtk.Stack` as a parameter for navigation.
*   **`DashboardPage.sml`:** Defines the `DashboardPage` structure/module. Contains a `create` function to build the dashboard UI, potentially taking the `Gtk.Stack` for logout or further navigation.
*   **`BasePage.sml`:** May define a common structure or helper functions shared by different pages (e.g., standard layout with header/footer).

### Layout Components (`src/LayoutComponents/`)

*   **`header.sml`, `footer.sml`:** Likely define reusable header and footer widgets/modules that could be incorporated into `BasePage` or individual pages.
*   **`AppState.sml`:** Would potentially manage shared application state accessible by different components, although its usage isn't directly visible in `pages.sml`.

### Design Tokens (`src/Tokens/`)

Design tokens centralize fundamental UI design decisions (like colors, spacing, typography) to ensure consistency and ease of modification. This project includes an initial implementation for font sizes.

*   **`fontSize.sml`:** Defines the `FontSize` structure, which provides:
    *   **Semantic Sizes:** References (`real ref`) to standard font point sizes (e.g., `h1Size`, `h2Size`, `bodySize`). These refs allow potential runtime modification if needed, but primarily serve as named constants.
    *   **Pango Markup:** Helper functions (`withSize`, `toPangoScale`) to convert these sizes into Pango markup strings required by GTK labels.
    *   **Convenience Functions:** Functions (`h1`, `h2`, `body`, etc.) that directly apply the corresponding semantic font size to a `Gtk.Label` widget using `Label.setMarkup`.

*   **Usage Example:**

    To use these tokens, you would typically import the `FontSize` structure (likely done implicitly if `pages.sml` uses all `src/**/*.sml`) and apply the convenience functions to label widgets.

    ```sml
    open Gtk FontSize

    (* Create a label *)
    val myTitleLabel = Label.new (NONE : string option)
    val myBodyLabel = Label.new (NONE : string option)

    (* Apply semantic font sizes using the convenience functions *)
    val () = h1 myTitleLabel "Main Section Title"
    val () = body myBodyLabel "This is paragraph text using the standard body size."

    (* Manually create markup using withSize *)
    val customMarkup = withSize "Special Caption" (!captionSize)
    val () = Label.setMarkup someOtherLabel customMarkup
    ```

    This approach ensures that all "h1" headings or "body" text elements across the application use the same font size defined in `FontSize.sml`, making global style changes easier.

## Documentation

The project includes comprehensive documentation built with Sphinx, providing detailed information about the architecture, components, and usage of the ERP UI Library.

### Sphinx Documentation

The documentation is written in reStructuredText (RST) format and organized into several sections:

* **Architecture** - System architecture, component interaction flow, and design patterns
* **Installation** - Setup and installation instructions
* **Pages** - Detailed documentation of the application pages
* **Layout Components** - Reusable UI components and their usage
* **Dashboard Components** - Components specific to the dashboard interface
* **Tokens** - Design tokens for consistent styling and theming
* **Utils** - Utility functions and helpers
* **Overview** - General project overview and objectives
* **Usage** - How to use the library components

### Building the Documentation

To build the Sphinx documentation:

1. Set up a Python virtual environment:
   ```bash
   python3 -m venv venv
   ```

2. Activate the virtual environment:
   ```bash
   source venv/bin/activate
   ```

3. Install the required dependencies:
   ```bash
   python -m pip install -r requirements.txt
   ```

4. Build the HTML documentation:
   ```bash
   cd docs
   sphinx-build -b html . _build/html
   ```

### Viewing the Documentation

After building, the documentation can be accessed by opening the HTML files in a web browser:

```bash
xdg-open docs/_build/html/index.html
```

## Code Quality and Examples

The code follows a modular structure by separating concerns into different directories (`Pages`, `LayoutComponents`, `Tokens`). It utilizes SML features and Giraffe bindings for GTK+. Comments exist but could be more extensive for complex logic within components.

### Environment Setup

1.  **Install Poly/ML:** Follow official Poly/ML installation instructions.
2.  **Install Giraffe:** Install the Giraffe library, typically in `/opt/giraffe`.
3.  **Set `GIRAFFEHOME`:** Export the environment variable: `export GIRAFFEHOME=/path/to/giraffe` (e.g., `/opt/giraffe`).
4.  **Install GTK+ 3 Dev Libraries:** Use your system's package manager (e.g., `apt`, `yum`, `brew`) to install development packages for GTK+ 3, GLib, and GIO. Common package names include `libgtk-3-dev`, `libglib2.0-dev`.

### Compilation

Navigate to the `OmosefesDissertationRepo/pages` directory in your terminal and run:

```bash
make polyml
```

This command executes the build process defined in the `Makefile`, using Poly/ML to compile the SML sources listed directly or indirectly via `polyml-app.sml` and link against the necessary Giraffe and GTK libraries specified in `app.mk`. The output binary will be named `pages-polyml` (as defined by `TARGET_POLYML` in `app.mk`).

### Running the Application

After successful compilation, run the executable:

```bash
./pages-polyml
```

## Documentation

### Prerequisites for Documentation

1. **Python**: Required to build the Sphinx documentation
2. **Sphinx**: The documentation system used for generating HTML docs

```bash
# Install Python (if not already installed)
# Then install Sphinx using pip:
pip install sphinx
```

### Building the Documentation

The ERP UI Library includes comprehensive documentation in the `docs/` directory using the Sphinx documentation system. To build and access the docs:

```bash
# Navigate to the docs directory
cd docs

# Build the HTML documentation
python -m sphinx -b html . _build/html
```

### Accessing the Documentation

After building, you can access the documentation by opening the generated HTML files in your browser:

```bash
# Windows (PowerShell or CMD)
start docs/_build/html/index.html

# macOS
open docs/_build/html/index.html

# Linux
xdg-open docs/_build/html/index.html
```

The documentation covers:

- Design token systems (FontSize, SpacingScale, CSS)  
- Layout components
- Page implementations
- Dashboard components
- Utility functions
- Installation and setup guides

### Documentation Structure

The documentation is organized into several sections:

- **Overview**: Introduction to the ERP UI Library
- **Installation**: Setup and requirements
- **Token System**: Design tokens for consistent UI appearance
- **Layout Components**: Header, footer, application state components
- **Pages**: Base page architecture, specific page implementations
- **Dashboard Components**: KPI cards and content panels
- **Utilities**: Helper functions for tables, images, etc.

## Implementation Process and Decision Justifications

*   **Page Management:** `Gtk.Stack` was selected for managing different views within a single window, a common pattern for modern application navigation. This avoids managing multiple top-level windows.
*   **Modular Structure:** The code is organized into `src/Pages`, `src/LayoutComponents`, and `src/Tokens`. This separation promotes code reuse, maintainability, and follows standard practices for UI development. Each component (like `LoginPage`) is encapsulated in its own module.
*   **Build System:** The standard Giraffe Makefile structure is adopted, providing integration with Poly/ML and handling library dependencies automatically via `pkg-config`.
*   **Originality vs. Adaptation:** As stated in the Overview, the core application structure (`Gtk.Application`, `ApplicationWindow`, signal handling) follows standard GTK/Giraffe practices. The **key contribution lies in adapting component-based UI design patterns**, similar to those found in frameworks like React, to the SML/GTK+ context. This involves the specific implementation of the Pages (`LoginPage`, `DashboardPage`), the component breakdown (`src/`), and the use of design tokens (`FontSize`) to create a modular and maintainable UI foundation within SML. The use of `Gtk.Stack` is a standard GTK technique chosen to facilitate the single-page application feel common in adapted web framework patterns.
