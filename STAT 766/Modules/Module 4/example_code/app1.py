import streamlit as st
import pandas as pd
import numpy as np

# Title of the app
st.title('Simple Data Explorer (Like a Shiny App)')

# Create a slider widget (input)
n_rows = st.slider('Number of rows', 5, 100, 20)

# Generate data based on the slider value
data = pd.DataFrame({
    'x': np.arange(n_rows),
    'y': np.random.randn(n_rows)
})

# Display the data
st.write("### Generated Data", data)

# Create a chart based on the data
st.line_chart(data, x='x', y='y')