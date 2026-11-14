# 🛒 Retail Sales Performance Dashboard

![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![DAX](https://img.shields.io/badge/DAX-376d70?style=for-the-badge)
![Power Query](https://img.shields.io/badge/Power%20Query-45958F?style=for-the-badge)
![Time Intelligence](https://img.shields.io/badge/Time%20Intelligence-77D4CE?style=for-the-badge)

> **Sales trends, seasonality and store comparison** for a 45-store retail chain, built in Power BI.

![Dashboard preview](images/dashboard.png)

---

## 📌 Business Problem

Regional managers need one page that answers:

1. **How are we doing overall?** Total sales, average weekly sales, sales per store.
2. **Are we growing?** Year-over-year sales growth against target.
3. **Where is the money coming from?** Which stores and store types (A / B / C) drive revenue.
4. **When do sales peak?** Weekly seasonality and holiday effects, compared year by year.
5. **What's next?** A short-term forecast of weekly sales.

## 📂 Dataset

Based on the [Retail Data Analytics](https://www.kaggle.com/datasets/manjeetsingh/retaildataset) dataset on Kaggle: historical weekly sales for **45 stores**, broken down by department.

| File | Grain | Key columns |
|---|---|---|
| `stores data-set.csv` | 1 row per store | Store, Type (A/B/C), Size |
| `sales data-set.csv` | Store × Dept × Week | Store, Dept, Date, Weekly_Sales, IsHoliday |
| `Features data set.csv` | Store × Week | Temperature, Fuel_Price, MarkDown1–5, CPI, Unemployment, IsHoliday |

> The raw CSVs are not included in this repo. Download them from Kaggle (link above).

## 🔄 Data Preparation (Power Query)

- Imported the three CSVs and promoted headers
- Set data types (whole number, date, decimal, true/false)
- Renamed columns for readability (`Weekly_Sales` → `Weekly Sales`, `Size` → `Store Size`, `Type` → `Store Type`, `Fuel_Price` → `Fuel Price`)

Full M code: [`power-query/`](power-query/)

## 🧩 Data Model

Two fact tables (`sales`, `features`) share a **Store** dimension and a **DAX-generated Date** table, with single-direction many-to-one relationships.

![Data model](images/data-model.png)

## 🧮 Key DAX Measures

| Measure | What it shows |
|---|---|
| `Total Sales` | Sum of weekly sales |
| `Avg Weekly Sales` | Average weekly sales value |
| `Average Sales per Store` | Total sales ÷ number of distinct stores |
| `Sales Last Year` | Same period last year, capped at the last date with sales so partial years compare fairly |
| `YoY Growth` | (Total Sales − Sales Last Year) ÷ Sales Last Year |

```dax
Sales Last Year =
VAR LastSaleDate =
    CALCULATE ( MAX ( 'sales data-set'[Date] ), REMOVEFILTERS () )
RETURN
    CALCULATE (
        [Total Sales],
        DATEADD (
            FILTER ( VALUES ( 'Date'[Date] ), 'Date'[Date] <= LastSaleDate ),
            -1, YEAR
        )
    )
```

All measures: [`dax/measures.dax`](dax/measures.dax)

## 📊 Dashboard Features

| Visual | Purpose |
|---|---|
| **KPI cards** | Total Sales · Avg Weekly Sales · Avg Sales per Store |
| **Gauge: YoY Sales Growth** | Growth vs. a 0–20% target range |
| **Line: Weekly Sales Trend & Forecast** | Weekly trend with a trend line and a 10-week forecast (99% confidence band) |
| **Bar: Top 10 Stores by Total Sales** | Best-performing stores, colored by store type |
| **Line: Monthly Sales by Store Type** | Compares A, B and C formats across the year |
| **Line: Weekly Seasonality by Year** | Overlays years to show recurring peaks (holiday weeks) |
| **Slicers** | Year · Store Type · Store |

## 💡 Key Insights

> ✏️ *Replace these with the numbers from your own dashboard. Recruiters read this section first.*

- **Store type A** contributes the largest share of total sales — `__%` of revenue.
- **Holiday weeks** (late November–December) show the strongest spikes in the seasonality chart.
- **Top 10 stores** account for `__%` of total sales.
- **YoY growth** for the latest year is `__%`.

## 🛠️ Skills Demonstrated

`Data modeling (star schema)` · `Power Query ETL` · `DAX measures` · `Time intelligence (YoY)` · `Forecasting & trend lines` · `Interactive slicers` · `Dashboard design`

## ▶️ How to Open

1. Download [`Retail_Sales_Performance_Dashboard.pbit`](Retail_Sales_Performance_Dashboard.pbit) and the dataset from Kaggle.
2. Open the `.pbit` in **Power BI Desktop**.
3. If you see a file-path error, go to **Transform data**. For each of the 3 queries, open **Source** and point it to where you saved the CSV.
4. Click **Close & Apply**.

---

⬅️ [Back to portfolio](../README.md)
