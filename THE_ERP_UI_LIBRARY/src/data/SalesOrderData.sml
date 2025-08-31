(* SalesOrderData.sml: Sample data for immutable sales orders table *)

structure SalesOrderData = struct
  val headers = ["Order ID", "Customer", "Date", "Status", "Total (GBP)"]
  val rows = [
    ["SO-001", "Alice Smith", "2025-04-28", "Pending", "120.00"],
    ["SO-002", "Bob Jones", "2025-04-27", "Shipped", "89.99"],
    ["SO-003", "Charlie Lee", "2025-04-25", "Delivered", "250.50"]
  ]
end
