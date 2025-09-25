import pandas as pd
import numpy as np
from sklearn.datasets import load_iris
import plotly.express as px
import panel as pn
import streamlit as st

pn.extension("plotly")

iris = load_iris()
df = pd.DataFrame(data=iris.data, columns=iris["feature_names"])
df["species"] = iris.target_names[iris.target]

st.header("Iris data set explorer")
st.dataframe(df.head())

x_axis = st.sidebar.selectbox(label="X axis", options=iris.feature_names, index=0)
y_axis = st.sidebar.selectbox(label="Y axis", options=iris.feature_names, index=1)

coloring = st.sidebar.button(label="Coloring")
size_multiplier = st.sidebar.slider(
    label="Size Multipler",
    min_value=2,
    max_value=8,
    value=1
)
size_variable = st.sidebar.selectbox(
    label="Size Variable",
    options=iris.feature_names,
    index=2
)

if coloring:
    fig = px.scatter(
        df, x=x_axis, y=y_axis,
        size=size_variable, color="species",
        title=f"Scatter plot of {x_axis} vs {y_axis}",
        labels={x_axis: x_axis, y_axis: y_axis, "species": "Species"}
    )
else:
    fig = px.scatter(
        df, x=x_axis, y=y_axis,
        size=size_variable, color="species",
        title=f"Scatter plot of {x_axis} vs {y_axis}",
        labels={x_axis: x_axis, y_axis: y_axis}
    )

fig.update_traces(marker=dict(size=size_multiplier * df[size_variable]))
st.plotly_chart(fig)
