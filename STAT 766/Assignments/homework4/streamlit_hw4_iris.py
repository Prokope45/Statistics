import pandas as pd
from sklearn.datasets import load_iris
import plotly.express as px
import streamlit as st


iris = load_iris()
df = pd.DataFrame(data=iris.data, columns=iris["feature_names"])
df["species"] = iris.target_names[iris.target]

st.header("Iris Dataset Explorer")
col1, col2 = st.columns(2)

with col1:
    x_axis = st.selectbox(label="X axis", options=iris.feature_names, index=0)
    coloring = st.checkbox(label="Coloring by Species")
with col2:
    y_axis = st.selectbox(label="Y axis", options=iris.feature_names, index=1)
    marker_size = st.slider(
        label="Size Multipler",
        min_value=5,
        max_value=20,
        value=5,
    )

scatter_fig = px.scatter(
    df, x=x_axis, y=y_axis,
    size=[marker_size] * len(df),
    size_max=marker_size,
    color="species" if coloring else None,
    title=f"Scatter plot of {x_axis} vs {y_axis}",
    labels={x_axis: x_axis, y_axis: y_axis, "species": "Species"}
)
st.plotly_chart(scatter_fig, use_container_width=True)

histogram_fig = px.histogram(
    df, x=x_axis, y=y_axis,
    color="species" if coloring else None,
    barmode='group',
    title=f"Histogram of {y_axis} grouped by {x_axis}"
)
st.plotly_chart(histogram_fig, use_container_width=True)

# To serve app: `streamlit run streamlit_hw4_iris.py`
