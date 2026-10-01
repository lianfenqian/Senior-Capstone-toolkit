# 02_analysis.R
# Purpose: Analyze the cleaned data and reproduce the table and figure.
# Input:  data/processed/sales_clean.csv
# Outputs:
#   results/tables/sales_by_product.csv
#   results/figures/monthly_sales.png

dir.create("results/tables", recursive = TRUE, showWarnings = FALSE)
dir.create("results/figures", recursive = TRUE, showWarnings = FALSE)

dat <- read.csv("data/processed/sales_clean.csv",
                stringsAsFactors = FALSE)
dat$date <- as.Date(dat$date)

# Table: total transactions, units, and sales by product
sales_by_product <- aggregate(
  cbind(transaction_id = rep(1, nrow(dat)),
        quantity = dat$quantity,
        sales = dat$sales),
  by = list(product = dat$product),
  FUN = sum
)

names(sales_by_product)[names(sales_by_product) == "transaction_id"] <- "transactions"
sales_by_product$avg_sale <- sales_by_product$sales / sales_by_product$transactions

sales_by_product <- sales_by_product[order(-sales_by_product$sales), ]
write.csv(sales_by_product,
          "results/tables/sales_by_product.csv",
          row.names = FALSE)

# Figure: monthly sales
dat$month <- format(dat$date, "%Y-%m")
monthly <- aggregate(sales ~ month, data = dat, sum)

png("results/figures/monthly_sales.png", width = 900, height = 600)
barplot(monthly$sales,
        names.arg = monthly$month,
        xlab = "Month",
        ylab = "Total Sales ($)",
        main = "Monthly Sales")
dev.off()

print(sales_by_product)
print(monthly)
