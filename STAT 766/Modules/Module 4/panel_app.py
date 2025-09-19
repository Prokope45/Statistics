import pandas as pd
import numpy as np
from sklearn.datasets import load_iris
import plotly.express as px
import panel as pn

pn.extension("plotly")

iris = load_iris()
df = pd.DataFrame(data=iris.data, columns=iris["feature_names"])
# df["species"] = pd.Categorical.from_codes(iris["target"], iris["target_names"])
df["species"] = iris.target_names[iris.target]
# df.columns = [c.replace(" (cm)", '') .replace(' ', '_') for c in df.columns]

x_axis = pn.x_axis = pn.widgets.Select(
    name="X Axis",
    options=iris.feature_names,
    value="sepal_length"
)
y_axis = pn.y_axis = pn.widgets.Select(
    name="Y Axis",
    options=iris.feature_names,
    value="sepal_length"
)
coloring = pn.widgets.Checkbox(name="Coloring", value=False)
size_multiplier = pn.widgets.IntSlider(
    name="Size Multiplier",
    start=2,
    end=8,
    step=1,
    value=1
)

size_variable = pn.widgets.Select(
    name="Size Variable",
    options=iris.feature_names,
    value=df.columns[1]
)
DAT = pn.widgets.DataFrame(df, width=800, height=300)


@pn.depends(x_axis, y_axis, size_variable, coloring, size_multiplier)
def scatterplot(x, y, size_var, color, size_multi):
    print(size_var)
    if color:
        fig = px.scatter(
            df, x=x, y=y,
            size=size_var, color="species",
            title=f"Scatter plot of {x} vs {y}",
            labels={x: x, y: y, "species": "Species"}
        )
    else:
        fig = px.scatter(
            df,
            x=x,
            y=y,
            size=size_var,
            title=f"Scatter plot of {x} vs {y}",
            labels={x: x, y: y}
        )
    fig.update_traces(marker=dict(size=size_multi * df[size_var]))
    return fig


layout = pn.Column(
    pn.pane.Markdown("# Iris data set explorer"),
    DAT,
    pn.Row(x_axis, y_axis, size_variable),
    pn.Spacer(height=20),
    pn.Row(coloring, pn.Spacer(width=40), size_multiplier),
    scatterplot
)

layout = pn.Row(
    pn.Column(
        x_axis,
        y_axis,
        size_variable,
        pn.Spacer(height=20),
        coloring,
        pn.Spacer(height=40),
        size_multiplier
    ), pn.Column(
        pn.pane.Markdown("# Iris data set explorer"),
        DAT,
        pn.Row(pn.Spacer(width=40), size_multiplier),
        scatterplot
    )
)

layout.servable()

# panel serve app.py --show --autoreload
