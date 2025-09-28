import pandas as pd
from sklearn.datasets import load_iris
import plotly.express as px
import panel as pn

pn.extension('plotly')

# Load Iris dataset
iris = load_iris()
df = pd.DataFrame(data=iris.data, columns=iris["feature_names"])
df["species"] = iris.target_names[iris.target]

# Widgets
x_axis_select = pn.widgets.Select(
    name="X axis",
    options=iris["feature_names"],
    value=iris["feature_names"][0]
)
y_axis_select = pn.widgets.Select(
    name="Y axis",
    options=iris["feature_names"],
    value=iris["feature_names"][1]
)
color_checkbox = pn.widgets.Checkbox(name="Coloring by Species", value=False)
size_slider = pn.widgets.IntSlider(
    name="Size Multiplier",
    start=5, end=20, step=1, value=5,
    bar_color='lightblue'
)


# Reactive plotting function
@pn.depends(
    x_axis_select.param.value,
    y_axis_select.param.value,
    color_checkbox.param.value,
    size_slider.param.value
)
def update_plots(x_axis, y_axis, color, marker_size):
    color_val = "species" if color else None

    scatter_fig = px.scatter(
        df, x=x_axis, y=y_axis,
        color=color_val,
        size=[marker_size] * len(df),
        size_max=marker_size,
        title=f"Scatter plot of {x_axis} vs {y_axis}",
        labels={x_axis: x_axis, y_axis: y_axis, "species": "Species"}
    )

    histogram_fig = px.histogram(
        df, x=x_axis, y=y_axis,
        color=color_val,
        barmode='group',
        title=f"Histogram of {y_axis} grouped by {x_axis}"
    )

    return pn.Column(
        pn.pane.Plotly(scatter_fig, config={'responsive': True}),
        pn.pane.Plotly(histogram_fig, config={'responsive': True})
    )


# Layout
layout = pn.Column(
    "# Iris Dataset Explorer",
    pn.Row(
        pn.Column(x_axis_select, color_checkbox),
        pn.Column(y_axis_select, size_slider)
    ),
    update_plots
)

layout.servable()

# To serve app: `panel serve panel_hw4_iris.py  --show --autoreload`
