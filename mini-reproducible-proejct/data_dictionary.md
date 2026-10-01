# Data Dictionary

| Variable | Type | Description |
|---|---|---|
| transaction_id | character | Unique transaction identifier |
| date | Date | Transaction date |
| region | character | Sales region |
| product | character | Product category |
| quantity | numeric | Number of units sold |
| unit_price | numeric | Price per unit |
| sales | numeric | Derived total sales = quantity × unit_price |

The `sales` variable is created during cleaning and is not present in the raw file.
