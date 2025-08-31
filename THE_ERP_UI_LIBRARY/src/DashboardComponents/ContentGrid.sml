  (******************************************************************************
   * CONTENT_GRID: Provides a reusable two-column content grid for ERP dashboards.
   *
   * This module defines the CONTENT_GRID structure, which exposes a function to
   * create a standardized two-column layout using Gtk.Grid. The grid is populated
   * with four panels: Recent Activity, Analytics, Tasks, and Notifications.
   *
   * Intended Usage:
   *   - Use CONTENT_GRID.create2ColumnContentGrid () to instantiate a grid widget
   *     for dashboard-like layouts in ERP UI applications.
   *   - Panels are created using CONTENT_PANEL and attached to the grid in a 2x2
   *     arrangement, promoting consistency and modularity in UI design.
   *
   * Dependencies:
   *   - Gtk (for UI components)
   *   - CONTENT_PANEL (for panel widgets)
   *   - SpacingScale (for spacing constants)
   *
   * Author: [Omosefe Osakue]
   * Date: [2025-05-09]
   *****************************************************************************)

(*Importing required modules*)
use "../Tokens/SpacingScale.sml";
use "../Tokens/FontSize.sml";
use "../Tokens/CssLoader.sml";
use "../DashboardComponents/ContentPanel.sml";
 
structure CONTENT_GRID = struct
  open Gtk
  fun create2ColumnContentGrid () =
    let
      open Gtk
      
      (* Creates a grid container *)
      val grid = Grid.new()
      val () = Container.setBorderWidth grid SpacingScale.inset
      val () = Grid.setColumnSpacing grid SpacingScale.medium
      val () = Grid.setRowSpacing grid SpacingScale.medium
      
      (* Left column content *)
      val recentActivityPanel = CONTENT_PANEL.create {title = "Recent Activity", alt = SOME "Recent Activity", imagePath = NONE}
      val () = Grid.attach grid (recentActivityPanel, 0, 0, 1, 1)
      
      (* Right column content *)
      val analyticsPanel = CONTENT_PANEL.create {title = "Analytics", alt = SOME "Analytics", imagePath = NONE}
      val () = Grid.attach grid (analyticsPanel, 1, 0, 1, 1)
      
      (* Second row content *)
      val tasksPanel = CONTENT_PANEL.create {title = "Tasks", alt = SOME "Tasks", imagePath = NONE}
      val () = Grid.attach grid (tasksPanel, 0, 1, 1, 1)
      
      val notificationsPanel = CONTENT_PANEL.create {title = "Notifications", alt = SOME "Notifications", imagePath = NONE}
      val () = Grid.attach grid (notificationsPanel, 1, 1, 1, 1)
    in
      grid
    end
  end
end