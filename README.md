# Marketing Analytics dbt Project

A production-ready marketing analytics pipeline built with dbt and BigQuery.
Transforms raw customer, order, campaign and subscription data into a 
CAC vs LTV measurement framework for marketing channel optimisation.

---

## Business Problem

A direct-to-consumer subscription business is spending across multiple marketing 
channels with no clear view of which channels deliver profitable long-term customers.
This pipeline shifts measurement from short-term ROAS to a CAC vs LTV framework.

**Core business questions:**
- Which acquisition channels bring in customers who stay and pay?
- What is the true cost of acquiring a subscriber vs the revenue they generate?
- Where should we reallocate budget to maximise subscriber lifetime value?

---

## Pipeline Architecture
Seeds (6 tables)
↓
Staging — clean and rename raw data
↓
Intermediate — join and calculate core metrics
↓
Marts — final tables for Tableau dashboards

---

## Models

**Staging**
| Model | Description |
|---|---|
| `stg_customers` | Customer acquisition and profile data |
| `stg_orders` | Order transactions with net revenue |
| `stg_campaigns` | Campaign metadata and budget |
| `stg_ad_spend` | Daily spend with CPC, CTR and CPA |
| `stg_subscriptions` | Subscription lifecycle and status |
| `stg_products` | Product catalogue and pricing tiers |

**Intermediate**
| Model | Description |
|---|---|
| `int_customer_acquisition` | One row per customer with order and subscription metrics |
| `int_campaign_performance` | One row per campaign with aggregated spend metrics |
| `int_channel_ltv_cac` | One row per channel with CAC, LTV and LTV:CAC ratio |

**Marts**
| Model | Description |
|---|---|
| `mart_channel_performance` | Channel-level table with churn rate, activation rate and revenue per spend |
| `mart_customer_segments` | Customer-level table with value segment and churn risk flags |

---

## Key Metrics

| Metric | Definition |
|---|---|
| CAC | Total ad spend divided by customers acquired per channel |
| Average LTV | Average net revenue per customer per channel |
| LTV:CAC Ratio | LTV divided by CAC — healthy ratio is above 3 |
| Churn Rate | Churned customers divided by total customers |
| Activation Rate | Active subscribers divided by total customers |
| Revenue per Spend | Total revenue divided by total ad spend |

---

## Data Quality

34 tests across all layers:
- Unique and not null checks on all primary keys
- Accepted values on status and segment columns

---

## Tech Stack

- **dbt** — transformation, testing and documentation
- **BigQuery** — cloud data warehouse
- **Tableau** — dashboard and visualisation

---

## Setup

```bash
git clone https://github.com/vikkieessien/marketing_analytics_dbt.git
cd marketing_analytics_dbt
pip install dbt-bigquery
dbt seed
dbt run
dbt test
```

---

## Author

Victoria Essien — Senior Analytics Engineer  
[GitHub](https://github.com/vikkieessien) | [LinkedIn](https://linkedin.com/in/victoriaessien)