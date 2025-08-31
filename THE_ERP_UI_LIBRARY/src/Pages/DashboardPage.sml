(* DashboardPage.sml
 * A complete dashboard page implementation with KPI row and two-column content layout
 * that integrates with BasePage for consistent header and footer
 *)

use "../Tokens/SpacingScale.sml";
use "../Tokens/FontSize.sml";
use "../LayoutComponents/AppState.sml";
use "BasePage.sml";
use "../DashboardComponents/KPICard.sml";
use "../DashboardComponents/ContentPanel.sml";
use "../LayoutComponents/ButtonActionRow.sml";

structure DashboardPage :> PAGE = struct
  structure Gtk = Gtk
  open Gtk

  (* Apply the BasePage functor *) 
  structure DashboardBase = BasePage(struct val title = "Dashboard" end)

  (* Updated signature to match PAGE signature *) 
  fun create {stack: Gtk.Stack.t, menuItems: (string * string) list option} =
    let
      (* Use the passed menuItems for BasePage *) 
      val (basePage, contentBox) = DashboardBase.create{
        stack = stack, 
        menuItems = menuItems
      }

      (* --- Dashboard Specific Content --- *) 

      (* Create a container box to center the grid *)
      val centeringBox = Box.new (Orientation.VERTICAL, 0)
      val () = Widget.setHalign centeringBox Align.CENTER
      val () = Widget.setHexpand centeringBox true
      
      (* Create a Grid to hold dashboard widgets *) 
      val dashboardGrid = Grid.new ()
      val () = Grid.setRowSpacing dashboardGrid 20
      val () = Grid.setColumnSpacing dashboardGrid 20
      val () = Widget.setMarginTop dashboardGrid 20
      val () = Widget.setMarginBottom dashboardGrid 20
      val () = Widget.setMarginStart dashboardGrid 20
      val () = Widget.setMarginEnd dashboardGrid 20
      val () = Widget.setHalign dashboardGrid Align.CENTER
      val () = Widget.setHexpand dashboardGrid false

      (* Create KPI Cards using the reusable component *) 
      val kpiSales = KPICard.create {label = "Today's Sales", value = "$12,345", trend = SOME "+12% vs last month"}
      val kpiOrders = KPICard.create {label = "Open Orders", value = "8", trend = NONE}
      val kpiInventory = KPICard.create {label = "Items Low Stock", value = "3", trend = NONE}
      val kpiRevenue = KPICard.create {label = "Monthly Revenue", value = "$45,876", trend = SOME "+5% vs last month"}
      val kpiCustomers = KPICard.create {label = "New Customers", value = "12", trend = NONE}
      val kpiShipment = KPICard.create {label = "Shipment", value = "25", trend = NONE}
      
      (* Add KPI cards to the grid - Use correct tuple syntax and center them *) 
      val () = Grid.attach dashboardGrid (kpiSales, 0, 0, 1, 1)
      val () = Grid.attach dashboardGrid (kpiOrders, 1, 0, 1, 1)
      val () = Grid.attach dashboardGrid (kpiInventory, 2, 0, 1, 1)
      val () = Grid.attach dashboardGrid (kpiRevenue, 0, 1, 1, 1)
      val () = Grid.attach dashboardGrid (kpiCustomers, 1, 1, 1, 1)
      val () = Grid.attach dashboardGrid (kpiShipment, 2, 1, 1, 1)
      
      (* Set alignment for each KPI card to ensure they're centered within their cells *)
      val () = Widget.setHalign kpiSales Align.CENTER
      val () = Widget.setHalign kpiOrders Align.CENTER
      val () = Widget.setHalign kpiInventory Align.CENTER
      val () = Widget.setHalign kpiRevenue Align.CENTER
      val () = Widget.setHalign kpiCustomers Align.CENTER
      val () = Widget.setHalign kpiShipment Align.CENTER

      val imagePanel = CONTENT_PANEL.create {title = "Example of a Panel with an Image", content = NONE, alt = NONE, imagePath = SOME "resources/images/salesChart.png"}
      val () = Grid.attach dashboardGrid (imagePanel, 0, 2, 3, 1)
      
      (* Sales Order Button *)
      val salesOrderBtn = Button.newWithLabel "Sales Order"
      val _ = Widget.setSizeRequest salesOrderBtn (180, 36)
      val buttonRow = LeftAlignedButtonRow.create [salesOrderBtn]

      val () = Box.packStart contentBox (buttonRow, false, false, 0)
      
      (* Connect the button to navigation *)
      val _ = Signal.connect salesOrderBtn (Button.clickedSig, fn _ =>
        let
          val () = print ("Navigating to Sales Order Page\n")
          val () = Stack.setVisibleChildName stack "salesorder"
        in
          ()
        end)
      
      (* Add the grid to the centering box *)
      val () = Container.add centeringBox dashboardGrid
      
      (* Add the centering box to the content area provided by BasePage *) 
      val () = Container.add contentBox centeringBox

    in
      (* Return the tuple (basePage, contentBox) as required by the PAGE signature *)
      (basePage, contentBox)
    end
end
