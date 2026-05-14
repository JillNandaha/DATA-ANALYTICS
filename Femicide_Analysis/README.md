# Femicide in Kenya (2016–2023) — Data Analysis & Visualization

## Overview

This project presents a comprehensive exploratory data analysis (EDA) and visualization study of femicide cases reported in Kenya between 2016 and 2023.

Using media-reported case data, the notebook cleans and standardizes the dataset, derives analytical features, performs exploratory analysis, and generates publication-quality visualizations that highlight patterns in:

* Intimate partner violence (IPV)
* Geographic distribution of cases
* Victim demographics
* Methods of killing
* Justice and accountability outcomes
* Temporal reporting trends

The analysis was built using Python and focuses on uncovering structural trends and accountability gaps in femicide reporting and prosecution in Kenya.

---

# Project Objectives

The main objectives of this analysis are to:

1. Clean and standardize raw femicide case data
2. Explore trends and patterns in reported femicide cases
3. Identify the prevalence of intimate partner violence (IPV)
4. Examine judicial outcomes and accountability gaps
5. Analyze geographic and demographic distributions
6. Produce high-quality visualizations suitable for storytelling and advocacy
7. Create reusable cleaned datasets for future analysis and research

---

# Key Findings

## Dataset Summary

| Metric                  | Value               |
| ----------------------- | ------------------- |
| Total reported cases    | 507                 |
| Time period             | 2016–2023           |
| Counties represented    | Nationwide coverage |
| Unnamed victims         | 20.3%               |
| IPV-related cases       | 74.4%               |
| Average time to verdict | ~4.9 years          |
| Conviction coverage     | Extremely limited   |

## Major Insights

### 1. Intimate Partner Violence Dominates Femicide Cases

Approximately three-quarters of all recorded femicide cases were committed by:

* Husbands
* Boyfriends
* Ex-husbands
* Ex-boyfriends

This strongly suggests that domestic and intimate relationships remain the primary context in which femicide occurs.

### 2. Most Cases Occur at Home

The majority of killings occurred in domestic spaces, reinforcing the role of home environments as high-risk locations for women facing gender-based violence.

### 3. Stabbing Was the Most Common Method

Among categorized methods of killing, stabbing was the leading method recorded in the dataset.

### 4. Significant Justice Gap

Only a small proportion of cases:

* Reached court
* Received verdicts
* Had fully documented judicial outcomes

This highlights major accountability and justice-system limitations.

### 5. Reporting Peaks in Specific Years

The analysis identified significant annual variation in reporting frequency, with some years experiencing substantially higher reported case counts.

---

# Dataset Description

The dataset contains media-reported femicide cases collected from Kenyan news sources.

## Potential Sources

* Daily Nation
* The Standard
* The Star

## Example Fields

| Column                 | Description                             |
| ---------------------- | --------------------------------------- |
| `name_of_victim`       | Victim name                             |
| `age`                  | Victim age                              |
| `county`               | County where incident occurred          |
| `suspect_relationship` | Relationship between suspect and victim |
| `mode_of_killing`      | Recorded method of killing              |
| `murder_scene`         | Location of incident                    |
| `circumstance`         | Triggering event or context             |
| `published_date`       | Publication date of article             |
| `court_date`           | Court appearance date                   |
| `verdict`              | Judicial verdict                        |
| `verdict_date`         | Date of verdict                         |

---

# Data Cleaning & Preprocessing

The notebook performs extensive preprocessing to improve consistency and analytical quality.

## Cleaning Steps

### Standardization

Several categorical variables were normalized to eliminate inconsistent capitalization and spelling variations.

Examples include:

* Suspect relationships
* Modes of killing
* Murder scenes
* Verdict labels
* Femicide type labels

### County Corrections

Location anomalies and city/county mismatches were corrected.

Examples:

| Original | Corrected   |
| -------- | ----------- |
| Eldoret  | Uasin Gishu |
| Naivasha | Nakuru      |
| Nanyuki  | Laikipia    |

### Date Parsing

Multiple date fields were parsed and standardized using `pandas.to_datetime()`.

The notebook also:

* Handles malformed dates
* Converts Excel serial date formats
* Extracts year and month features

### Circumstance Grouping

Over 40+ raw circumstance values were consolidated into broader analytical categories such as:

* Argument/Quarrel
* Jealousy/Infidelity
* Breakup/Separation
* Sexual Coercion
* Substance Abuse

### Derived Features

Additional analytical variables were created, including:

| Feature             | Purpose                               |
| ------------------- | ------------------------------------- |
| `is_ipv`            | Flags intimate partner violence cases |
| `victim_identified` | Identifies unnamed victims            |
| `reached_court`     | Tracks judicial progression           |
| `has_verdict`       | Indicates verdict availability        |
| `years_to_verdict`  | Measures justice delay                |

---

# Exploratory Data Analysis (EDA)

The notebook includes extensive exploratory analysis covering:

## Victim Demographics

* Age distribution
* Age groups
* Identified vs unnamed victims

## Geographic Analysis

* County-level distribution
* Top counties with highest case counts
* Regional concentration patterns

## Violence Characteristics

* Mode of killing
* Murder scene analysis
* Triggering circumstances
* IPV vs non-IPV breakdown

## Justice System Analysis

* Cases reaching court
* Verdict availability
* Guilty vs not guilty outcomes
* Time-to-verdict analysis

## Temporal Trends

* Annual trends
* Monthly reporting heatmaps
* Reporting spikes and patterns

---

# Visualizations Generated

The notebook generates six major visualization outputs.

## 1. Femicide Overview Dashboard

A large multi-panel dashboard summarizing:

* Total victims
* IPV prevalence
* Conviction rates
* County distributions
* Methods of killing
* Victim age groups
* Triggering circumstances

Output:

```text
fig1_dashboard.png
```

---

## 2. Justice & Accountability Deep Dive

Focuses on:

* Judicial progression funnel
* Verdict distributions
* Conviction gaps
* Accountability challenges

Output:

```text
fig2_justice.png
```

---

## 3. Intimate Partner Violence (IPV) Analysis

Explores:

* IPV trends over time
* Relationship categories
* Comparative IPV vs non-IPV distributions

Output:

```text
fig3_ipv.png
```

---

## 4. Geographic Distribution Analysis

Visualizes:

* County-level case distributions
* Geographic hotspots
* Regional concentration patterns

Output:

```text
fig4_geography.png
```

---

## 5. Victim Profile Analysis

Examines:

* Victim age distribution
* Identification rates
* Femicide type characteristics

Output:

```text
fig5_victim_profile.png
```

---

## 6. Monthly Reporting Heatmap

Displays:

* Monthly reporting activity
* Year-over-year patterns
* Temporal intensity trends

Output:

```text
fig6_heatmap.png
```

---

# Technologies Used

## Core Libraries

* pandas
* numpy
* matplotlib
* seaborn (optional if added later)
* datetime

## Environment

The notebook was developed in:

* Google Colab
* Jupyter Notebook


# How to Run the Project

## 1. Clone the Repository

```bash
git clone https://github.com/yourusername/femicide-analysis.git
cd femicide-analysis
```

## 2. Install Dependencies

```bash
pip install pandas numpy matplotlib
```

## 3. Launch Jupyter Notebook

```bash
jupyter notebook
```

Then open:

```text
Femicide_Analysis.ipynb
```

---

# Reproducibility

The notebook is designed to:

* Run sequentially from top to bottom
* Generate cleaned datasets automatically
* Save all visualization outputs locally
* Support future extensions and deeper statistical analysis

---

# Ethical Considerations

This project analyzes femicide data involving real victims and sensitive gender-based violence cases.

Key ethical principles followed:

* Respectful handling of victim information
* Focus on structural patterns rather than sensationalism
* Acknowledgment of underreporting limitations
* Recognition that media-reported cases do not capture the full prevalence of femicide

This analysis should be interpreted as a data-driven advocacy and awareness effort rather than a complete national record.

---

# Limitations

## Media Reporting Bias

The dataset only includes cases covered by media organizations.

This introduces:

* Geographic reporting bias
* Underreporting
* Missing judicial records
* Incomplete victim profiles

## Missing Data

Some records contain missing:

* Ages
* Verdicts
* Court outcomes
* Circumstantial information

## Non-Standardized Source Material

Media articles vary significantly in detail and structure, requiring extensive normalization.

---

# Future Improvements

Potential future enhancements include:

* Interactive dashboards (Plotly / Tableau)
* Geospatial mapping
* NLP analysis of article narratives
* Machine learning classification
* Trend forecasting
* Integration with judicial datasets
* Automated data pipelines
* Public policy monitoring tools

---

# Research & Advocacy Value

This project can support:

* Gender-based violence research
* Policy advocacy
* Data journalism
* Academic analysis
* Human rights reporting
* Criminal justice reform discussions

---

# Acknowledgements

Special acknowledgment to:

* Kenyan media organizations documenting gender-based violence cases
* Researchers and activists working on femicide awareness
* Open-source Python community tools enabling reproducible analysis

---

# License

This project is released under the MIT License.

You are free to:

* Use
* Modify
* Share
* Adapt

with proper attribution.

---

# Contact

If you would like to collaborate, contribute, or discuss the analysis:

* Open an issue
* Submit a pull request
* Connect via GitHub

---

# Final Note

Behind every row in this dataset is a human life.

The purpose of this project is not only analytical but also social: to highlight patterns of violence, accountability gaps, and the urgent need for stronger prevention, protection, and justice systems.
