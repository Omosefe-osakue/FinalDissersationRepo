Installation
============

Prerequisites
------------

Before using the ERP UI Library, ensure you have the following prerequisites installed:

1. **Standard ML implementation**: The library is written with Poly/ML.
2. **GTK+3**: The underlying UI toolkit.
3. **Giraffe**: SML bindings for GTK+.

Installing Dependencies
---------------------

Windows Setup
~~~~~~~~~~~~

1. **Install Poly/ML**

   * Download the installer from the `Poly/ML download page <https://www.polyml.org/download.html>`__
   * Run the installer and follow the on-screen instructions

   Alternatively, build from source using MSYS2:

   .. code-block:: bash

       git clone https://github.com/polyml/polyml.git
       cd polyml
       ./configure
       make
       make install

2. **Install GTK+3**

   * Install MSYS2 from `MSYS2 website <https://www.msys2.org/>`__
   * Open the MSYS2 terminal and update package database:

   .. code-block:: bash

       pacman -Syu

   * Install GTK+3 libraries:

   .. code-block:: bash

       pacman -S mingw-w64-x86_64-gtk3

   * Add ``C:\msys64\mingw64\bin`` to your system's PATH environment variable



3. **Configure Visual Studio Code (Optional)**

   * Install the SML Environment 2024 extension from the `VS Code Marketplace <https://marketplace.visualstudio.com/items?itemName=zyck.sml-environment>`__
   * Configure the extension to use your preferred SML implementation
   * Use Ctrl+Enter to send code to the REPL

4. **Install Python for Documentation**

   .. code-block:: PowerShell

       # Install Sphinx for documentation
       py -m pip install sphinx

macOS Setup
~~~~~~~~~~

1. **Install Homebrew** (if not already installed)

   .. code-block:: bash

       /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
       # Visit `Homebrew <https://brew.sh/>`__ for more information

2. **Install Poly/ML**

   .. code-block:: bash

       brew install polyml

3. **Install GTK+3**

   .. code-block:: bash

       brew install gtk+3

4. **Configure Visual Studio Code (Optional)**

   * Install the SML Environment 2024 extension from the `VS Code Marketplace <https://marketplace.visualstudio.com/items?itemName=zyck.sml-environment>`__
   * Configure the extension to use your preferred SML implementation
   * Use Ctrl+Enter to send code to the REPL

5. **Install Python for Documentation**

   .. code-block:: bash

       pip3 install sphinx

Ubuntu/Debian Setup
~~~~~~~~~~~~~~~~~

1. **Install Poly/ML**

   .. code-block:: bash

       sudo apt-get update
       sudo apt-get install polyml

2. **Install GTK+3**

   .. code-block:: bash

       sudo apt-get install libgtk-3-dev

3. **Configure Visual Studio Code (Optional)**

   * Install the SML Environment 2024 extension from the `VS Code Marketplace <https://marketplace.visualstudio.com/items?itemName=zyck.sml-environment>`__
   * Configure the extension to use your preferred SML implementation
   * Use Ctrl+Enter to send code to the REPL

4. **Install Python for Documentation**

   .. code-block:: bash

       sudo apt-get install python3-pip
       pip3 install sphinx

Setting Up the Library
---------------------

Clone the Repository
~~~~~~~~~~~~~~~~~~

.. code-block:: bash

    git clone https://github.com/yourusername/THE_ERP_UI_LIBRARY.git
    cd THE_ERP_UI_LIBRARY

Create a Configuration File
~~~~~~~~~~~~~~~~~~~~~~~~~

Create a ``config.sml`` file in the project root with your system-specific paths:

.. code-block:: sml

    (* config.sml *)
    structure Config = struct
        val gtkPath = "/path/to/your/gtk/installation"
        val giraffePath = "/path/to/your/giraffe/installation"
    end

Building the Project
------------------

Using the Makefile
~~~~~~~~~~~~~~~

For systems with GNU Make installed:

.. code-block:: bash

    make all

Manual Compilation
~~~~~~~~~~~~~~~

For Windows systems:

.. code-block:: PowerShell

    # Ensure you have MSYS2 environment with make available
    make all

Project Structure
---------------

The ERP UI Library is organized into several modules:

.. code-block:: text

    THE_ERP_UI_LIBRARY/
    ├── code/
    │   ├── src/
    │   │   ├── Tokens/        # Design tokens for consistent UI
    │   │   ├── Components/    # Reusable UI components
    │   │   ├── Pages/         # ERP application pages
    │   │   └── Utils/         # Utility functions
    │   ├── test/              # Test cases
    │   └── examples/          # Usage examples
    ├── docs/                  # Documentation
    ├── resources/             # Assets and resources
    │   ├── css/               # Stylesheets
    │   └── images/            # Icons and images
    └── scripts/               # Build and utility scripts

Common Make Commands
------------------

.. code-block:: bash

    make clean          # Clean build artifacts
    make test           # Run tests
    make examples       # Build examples
    make docs           # Generate documentation
    make all            # Build everything

Configuration
------------

The library can be configured through the following:

1. **Environment Variables**:
   * ``ERP_UI_PATH``: Path to the library installation
   * ``ERP_UI_DEBUG``: Set to "true" for debug output

2. **Configuration Files**:
   * ``config.sml``: Main configuration
   * ``theme.css``: Custom theme

Troubleshooting
-------------

Common Issues
~~~~~~~~~~

1. **Missing GTK Libraries**

   * Error: "Cannot find GTK libraries"
   * Solution: Ensure GTK is properly installed and in your PATH

2. **SML Compilation Errors**

   * Error: "Unbound structure Gtk"
   * Solution: Check that Giraffe bindings are properly installed

3. **Documentation Build Failures**

   * Error: "sphinx-build command not found"
   * Solution: Ensure Python and Sphinx are installed

Additional Resources
------------------

1. **SML Resources**:
   * `Standard ML of New Jersey <https://www.smlnj.org/>`__
   * `ML for the Working Programmer <https://www.cl.cam.ac.uk/~lp15/MLbook/>`__

2. **GTK Resources**:
   * `GTK Documentation <https://www.gtk.org/docs/>`__
   * `Giraffe Bindings <https://github.com/giraffeml/giraffe>`__

3. **ERP Design Patterns**:
   * `Enterprise Patterns <https://martinfowler.com/eaaCatalog/>`__
   * `Functional UI Patterns <https://github.com/functionalui/patterns>`__
