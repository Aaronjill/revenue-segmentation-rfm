>Revenue Segmentation using RFM Model<

Built using SQL + Power BI to segment users based on Recency, Frequency, and Monetary value.

>Features

- RFM Scoring
- Repeat Buyer Detection
- Segmented Revenue Insights
- Interactive Dashboard with Filters & Tooltips

>Tech Stack

- SQL (PostgreSQL syntax)
- Power BI (Data Modeling, DAX, Visuals)

> Folder Structure

├── sql/                     # Clean SQL queries
├── bi/                      # Power BI file (.pbix)
├── data/                    # Source data
├── documentation/           # SQL walkthroughs & analysis notes
├── images/                  # Screenshots used in dashboard/demo
├── sql csv-text-export/     # Any exported tables
├── README.md                # Project overview


---

> Dashboard Preview

![Dashboard Preview](images/dashboard-preview.png)

---
> RFM Segments Explained (via Tooltip)

Segment	                  Description

Champions	                Frequent,recent, and high-spend buyers
Loyal	                    Regular customers who buy often
Need Attention	          Used to buy, recently inactive
Potential	                Recently activated, but haven’t spent much yet
Require Activation	      Dormant users needing reactivation

> Key KPIs

- Total Customers
- Repeat Buyers %
- Segment Distribution
- Avg Monetary Value
- Champion Count

Tooltips and toolkits were also added to help end users understand segment definitions 


> SQL Highlights

- MAX(CASE WHEN order_rank = 1 THEN "InvoiceDate" END) AS first_order_date

> Key Metrics

- Repeat Buyer Rate: 96% 
- Total Customers: 4.3K
- Avg Monetary Value: $2.23K
- Top Segment: Champions – contributes the most revenue

> Use Cases

- Personalized marketing campaigns
- Lifecycle-based customer targeting
- Churn detection and recovery planning
- Revenue forecasting by customer segment

> How to Use

- Clone the repo
- git clone https://github.com/YOUR_USERNAME/revenue-segmentation-rfm.git
- Open Power BI and load the .pbix file
- Modify data source paths if needed
- Explore the dashboard & tweak segments/KPIs as required

>Final Thoughts<

This project is a great example of analytical storytelling, combining technical SQL logic with business insight visualization.
Use it as a portfolio highlight to demonstrate your skills in data modeling, dashboard building, and end-to-end data analysis.




