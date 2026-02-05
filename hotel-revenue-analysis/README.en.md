<p align="right">
  <a href="README.md">🇧🇷 Português</a> |
  <a href="README.en.md">🇺🇸 English</a>
</p>

# 🏨 Hotel Revenue & Cancellation Analysis

This project focuses on **Data Analysis and Business Intelligence** applied to the hospitality industry, using **SQL Server** for data modeling and preparation and **Power BI** for visualization and exploratory analysis.

The main goal is to understand patterns related to **bookings**, **cancellations**, **revenue**, **seasonality**, and **customer profiles**, supporting strategic business decisions.  
During the analysis, a critical need emerged to investigate cancellations in greater depth, as the cancellation rate exceeds **20%**.

---

## 🎯 Project Objectives

This project aims to answer questions such as:
- Which periods generate the highest revenue?
- Which periods have the highest cancellation rates?
- How does performance differ between **City Hotel** and **Resort Hotel**?
- Which countries and market segments generate the most bookings?
- Are there clear seasonal patterns throughout the year?

---

## 📐 Key KPIs

The indicators were calculated with a focus on **non-canceled bookings**, when applicable:

- **Net Revenue**
- **Gross Revenue**
- **Cancellation Rate**
- **ADR (Average Daily Rate)**
- **Total Bookings**

These KPIs enable comparative, time-based, and segmented analyses.

---

## 🗂️ Data Source

Historical hotel booking data covering the period **2018–2020**, composed of:
- Annual tables (`2018`, `2019`, `2020`)
- Supporting tables:
  - `meal_cost`
  - `market_segment`

Each row represents **one hotel reservation**.

---

## 🏗️ Data Modeling

### 📌 Adopted Strategy
A **fact table** was created with focus on performance and analytical clarity in Power BI.

### ⭐ Fact Table
**`fact_hotel_reservations`**

This table consolidates all reservations into a single structure, containing:
- Metrics (revenue, guests, nights)
- Business attributes (hotel type, country, market segment)
- Treated and standardized time-related columns

This approach eliminates the need for multiple yearly tables and simplifies historical analysis.

---

## 📅 Temporal Treatment

Although the original data contained:
- Year (numeric text)
- Month (text, in English)
- Day (integer)

A **complete date column (`arrival_date`)** was created to ensure:
- Correct chronological ordering
- Direct usability in line charts
- Full compatibility with Power BI time filters

> ⚠️ Month name conversion was handled using `CASE WHEN` logic, avoiding language and locale issues in SQL Server.

---

## 📊 Power BI Visualizations

Examples of analyses developed in Power BI include:
- 📈 KPI time-series line charts by hotel type
- 🏨 Bar charts by hotel type and year
- 🌍 Top countries by number of bookings
- 🛒 KPI bar charts by market segment
- 🔀 Funnel chart for distribution channels
- 💰 Donut chart for discount analysis

A **year selector** was used, restricted to the available period (2018, 2019, 2020).

---

## 🛠️ Tools Used

- **SQL Server**
  - CTEs
  - JOINs
  - Date functions
  - Fact table creation
- **Power BI**
  - Data modeling
  - DAX for KPIs
  - Interactive visualizations

---
