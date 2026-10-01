# Mini Reproducible Sales Project

## 1. Project purpose

This project demonstrates a simple reproducible data-management workflow:

**raw data → cleaning → processed data → analysis → table + figure**

The data are synthetic and represent sales transactions from January–March 2026.

## 2. Project structure

```text
mini_reproducible_project/
├── data/
│   ├── raw/
│   │   └── sales_raw.csv
│   └── processed/
│       └── sales_clean.csv
├── scripts/
│   ├── 01_cleaning.R
│   └── 02_analysis.R
├── results/
│   ├── tables/
│   │   └── sales_by_product.csv
│   └── figures/
│       └── monthly_sales.png
└── README.md
```

## 3. Data-management decisions

The raw data intentionally contain common problems:

- mixed date formats
- inconsistent capitalization
- leading/trailing spaces
- a duplicate transaction ID
- a missing quantity
- an impossible negative price

The cleaning script:

1. standardizes variable names;
2. standardizes text values;
3. parses dates;
4. converts numeric variables;
5. removes duplicate transaction IDs;
6. converts impossible prices to missing;
7. removes records missing required analysis fields;
8. creates `sales = quantity × unit_price`;
9. writes the processed dataset.

The raw data are **never overwritten**.

## 4. How to reproduce the results

### Requirements

- R (base R is sufficient)
- Git

### Step 1: Clone the repository

```bash
git clone <YOUR-REPOSITORY-URL>
cd mini_reproducible_project
```

### Step 2: Run the cleaning script

From the project root:

```bash
Rscript scripts/01_cleaning.R
```

This creates:

```text
data/processed/sales_clean.csv
```

### Step 3: Run the analysis script

```bash
Rscript scripts/02_analysis.R
```

This creates:

```text
results/tables/sales_by_product.csv
results/figures/monthly_sales.png
```

### Step 4: Inspect the results

The analysis produces:

- a table summarizing transactions, units, total sales, and average sale by product;
- a bar chart of monthly sales.

## 5. Reproducibility principle

A different person should be able to start with the repository, run the scripts in order, and regenerate the results without manually editing the data.

## 6. Important practice

Do not edit:

```text
data/raw/sales_raw.csv
```

after collection. If a problem is found, document the correction in the cleaning script so that the transformation can be reproduced.

## 7. Git history

A suggested history is:

```bash
git init
git add data/raw/sales_raw.csv README.md
git commit -m "Add raw data and project documentation"

git add scripts/01_cleaning.R
git commit -m "Add data cleaning workflow"

Rscript scripts/01_cleaning.R
git add data/processed/sales_clean.csv
git commit -m "Create processed dataset"

git add scripts/02_analysis.R
git commit -m "Add analysis workflow"

Rscript scripts/02_analysis.R
git add results/
git commit -m "Generate reproducible table and figure"
```

Check the history with:

```bash
git log --oneline --decorate --graph
```

A clean history should show the project developing step by step rather than one large unexplained commit.
