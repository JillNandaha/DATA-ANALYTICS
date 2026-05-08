# Customer Churn Prediction

## Project Overview
This project predicts customer churn for a telecom company using machine learning classification models.

The goal is to identify customers who are likely to cancel their subscription so the business can take proactive retention actions.

## Business Problem
Customer churn leads to revenue loss. By predicting churn early, telecom companies can target high-risk customers with personalized retention strategies.

## Dataset
The dataset used is the Telco Customer Churn dataset from Kaggle.

## Tools Used
- Python
- Pandas
- NumPy
- Matplotlib
- Seaborn
- Scikit-learn
- Imbalanced-learn
- XGBoost
- SHAP
- Google Colab

## Project Workflow
1. Exploratory Data Analysis
2. Data preprocessing
3. Class imbalance handling using SMOTE
4. Model training and comparison
5. Model evaluation using Recall, F1-score, and ROC-AUC
6. Hyperparameter tuning
7. Decision threshold optimization
8. SHAP explainability
9. Business recommendations

## Models Compared
- Logistic Regression
- Random Forest
- Support Vector Machine
- XGBoost

## Evaluation Metrics
Accuracy alone was not prioritized because the dataset is imbalanced.

The main metrics used were:
- Recall
- F1-score
- ROC-AUC

## Key Findings
- Month-to-month contract customers had higher churn risk.
- Short-tenure customers were more likely to churn.
- Higher monthly charges were associated with churn.
- Customers without tech support or online security showed higher churn risk.

## Business Recommendations
- Offer long-term contract incentives to month-to-month customers.
- Improve onboarding for new customers.
- Provide targeted discounts to high-risk, high-value customers.
- Bundle tech support and security services.
- Encourage automatic payment methods.

## Conclusion
The final tuned model can help identify high-risk customers and support data-driven retention campaigns.
