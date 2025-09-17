import pandas as pd
from sklearn.datasets import load_iris
import plotly.express as px
import panel as pn

pn.extension("plotly")

iris = load_iris()
df = pd.DataFrame(data=iris["data"], columns=iris["feature_names"])
df["species"] = pd.Categorical.from_codes(iris["target"], iris["target_names"])
df.columns = [c.replace(" (cm)", '') .replace(' ', '_') for c in df.columns]

all_species = list(df["species"].unique())
pn.selector = pn.widgets.MultiSelect(
    name="Species",
    options=all_species,
    value=all_species
)
pn.x_axis = pn.widgets.Select(
    name="X Axis",
    options=list(df.columns[:-1]),  # Redundant slicing?
    value="sepal_length"
)
pn.y_axis = pn.widgets.Select(
    name="Y Axis",
    options=list(df.columns[:-1]),  # Redundant slicing?
    value="sepal_length"
)
