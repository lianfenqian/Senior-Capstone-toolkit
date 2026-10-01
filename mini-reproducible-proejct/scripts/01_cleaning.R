# 01_cleaning.R
# Purpose: Clean the raw sales data and create a documented processed dataset.
# Input:  data/raw/sales_raw.csv
# Output: data/processed/sales_clean.csv

raw <- read.csv("data/raw/sales_raw.csv",
                stringsAsFactors = FALSE,
                na.strings = c("", "NA"))

# 1. Standardize variable names
names(raw) <- tolower(names(raw))

# 2. Standardize text fields
raw$region <- trimws(toupper(raw$region))
raw$product <- trimws(tolower(raw$product))
raw$product <- tools::toTitleCase(raw$product)

# 3. Parse dates (raw data contains two common formats)
date1<-as.Date(raw$date, format="%Y-%m-%d")
date2<-as.Date(raw$date, format="%m/%d/%Y")
raw$date<-ifelse(!i.na(date1),date1, date2)
raw$date<-as.Date(raw$date, origin="1970-01-01")

# 4. Convert numeric fields explicitly
raw$quantity <- as.numeric(raw$quantity)
raw$unit_price <- as.numeric(raw$unit_price)

# 5. Remove duplicate transaction IDs
raw <- raw[!duplicated(raw$transaction_id), ]

# 6. Treat impossible values as missing
raw$unit_price[raw$unit_price <= 0] <- NA

# 7. Remove records with missing values required for sales calculation
clean <- raw[complete.cases(raw[, c("transaction_id", "date", "region",
                                    "product", "quantity", "unit_price")]), ]

# 8. Create a derived variable
clean$sales <- clean$quantity * clean$unit_price

# 9. Save processed data
write.csv(clean, "data/processed/sales_clean.csv", row.names = FALSE)

cat("Raw records:", nrow(read.csv("data/raw/sales_raw.csv")), "\n")
cat("Processed records:", nrow(clean), "\n")
cat("Rows removed:", nrow(read.csv("data/raw/sales_raw.csv")) - nrow(clean), "\n")

