# Customer Churn Analysis

> An end-to-end data analytics and machine learning pipeline designed to analyze customer retention patterns and predict churn probability.

---

## 📸 Screenshots

| Executive Summary Dashboard | Model Performance & Insights |
| :---: | :---: |
| ![Dashboard Overview](https://raw.githubusercontent.com/Harinath2112/Customer-Churn-Analysis/main/assets/dashboard.png) | ![Churn Analysis](https://raw.githubusercontent.com/Harinath2112/Customer-Churn-Analysis/main/assets/model_insights.png) |

*(Note: Replace the image paths above with the actual relative paths or URLs of your screenshots once uploaded to your repository.)*

---

## ✨ Features

- **Exploratory Data Analysis (EDA):** In-depth evaluation of demographics, contract types, tenure, and service usage to uncover core churn triggers.
- **Data Preprocessing & Cleaning:** Automated handling of missing values, categorical encoding, feature scaling, and class imbalance management (e.g., SMOTE).
- **Predictive Machine Learning:** Comparative model training using algorithms like Logistic Regression, Random Forest, and XGBoost.
- **Feature Importance & Interpretability:** Identification of high-impact variables driving customer attrition.
- **Actionable Business Recommendations:** Data-driven insights aimed at boosting customer lifetime value and reducing subscriber loss.

---

## 🛠️ Tech Stack

- **Programming Language:** Python 3.8+
- **Data Processing:** pandas, numpy
- **Data Visualization:** matplotlib, seaborn, plotly
- **Machine Learning:** scikit-learn, xgboost, lightgbm
- **Environment & Tools:** Jupyter Notebook, Git, VS Code

---

## 🏗️ Architecture & Workflow

```text
┌────────────────────┐     ┌───────────────────────┐     ┌────────────────────────┐
│  Raw Dataset       │ --> │ Data Preprocessing    │ --> │ Feature Engineering    │
│  (Customer Data)   │     │ (Cleaning & EDA)      │     │ (Encoding & Scaling)   │
└────────────────────┘     └───────────────────────┘     └────────────────────────┘
                                                                     │
                                                                     ▼
┌────────────────────┐     ┌───────────────────────┐     ┌────────────────────────┐
│ Strategic Business │ <-- │ Model Evaluation      │ <-- │ Machine Learning       │
│ Insights           │     │ (Metrics & ROC-AUC)   │     │ (Training & Tuning)    │
└────────────────────┘     └───────────────────────┘     └────────────────────────┘
```

---

## 🚀 Setup & Installation Steps

### Prerequisites
Ensure you have **Python 3.8+** and **Git** installed on your machine.

### 1. Clone the Repository
```bash
git clone [https://github.com/Harinath2112/Customer-Churn-Analysis.git](https://github.com/Harinath2112/Customer-Churn-Analysis.git)
cd Customer-Churn-Analysis
```

### 2. Create and Activate a Virtual Environment
- **On macOS/Linux:**
  ```bash
  python3 -m venv venv
  source venv/bin/activate
  ```
- **On Windows:**
  ```bash
  python -m venv venv
  venv\Scripts\activate
  ```

### 3. Install Dependencies
```bash
pip install -r requirements.txt
```

### 4. Run the Project
Launch Jupyter Notebook to execute the analysis and models:
```bash
jupyter notebook
```

---

## 🔑 Demo Credentials

- **Application Access:** Not Applicable (Public Open-Source / Local Execution)
- **Database / API Keys:** No active authentication required. All operations run on local datasets.

---

## 💡 What I'd Improve

- [ ] **Interactive Web Application:** Deploy a Streamlit or Gradio dashboard for real-time churn prediction on new customer inputs.
- [ ] **MLOps Integration:** Use MLflow or Weights & Biases for automated tracking of model experiments and hyperparameters.
- [ ] **Advanced Deep Learning:** Test Deep Neural Networks (DNNs) to capture non-linear relationships in higher-dimensional data.
- [ ] **Real-Time Data Streams:** Build API endpoints (using FastAPI) to process continuous streaming telemetry data.
``░
