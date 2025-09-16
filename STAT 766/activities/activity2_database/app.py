import streamlit as st
import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
from sklearn.datasets import load_iris

st.title("Summary statistics from iris dataset")

data = load_iris()
df = pd.DataFrame(data.data, columns=data.feature_names)
df['target'] = data.target

st.write(df)

selected = st.selectbox("Select two x variables", options=data.feature_names)
new_df = df[[selected, 'target']]
st.write(new_df.describe())
plt.figure(figsize=(10,6))
sns.pairplot(new_df, hue='target')
st.pyplot(plt.gcf())
