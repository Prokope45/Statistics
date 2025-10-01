import pandas as pd
from sklearn.datasets import load_iris
import plotly.express as px
import panel as pn

# Load Iris dataset
iris = load_iris()
df = pd.DataFrame(data=iris.data, columns=iris["feature_names"])
df["species"] = iris.target_names[iris.target]


def clean_name(name: str):
    return name.replace(" (cm)", '') .replace(' ', '_')


df.columns = [clean_name(c) for c in df.columns]

# Widgets
x_axis_select = pn.widgets.Select(
    name="X-axis",
    options=iris.feature_names,
    value=iris.feature_names[0]
)
y_axis_select = pn.widgets.Select(
    name="Y-axis",
    options=iris.feature_names,
    value=iris.feature_names[1]
)
color_checkbox = pn.widgets.Checkbox(name="Coloring by Species", value=False)
size_slider = pn.widgets.IntSlider(
    name="Marker Size",
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
def scatter_plot(x_axis, y_axis, color, marker_size):
    color_val = "species" if color else None
    scatter_fig = px.scatter(
        df,
        x=clean_name(x_axis),
        y=clean_name(y_axis),
        color=color_val,
        size=[marker_size] * len(df),
        size_max=marker_size,
        title=f'Iris Dataset: {x_axis} vs {y_axis}',
        labels={x_axis: x_axis, y_axis: y_axis, "species": "Species"}
    )

    return scatter_fig


# Reactive plotting function
@pn.depends(
    x_axis_select.param.value,
    y_axis_select.param.value,
    color_checkbox.param.value,
    size_slider.param.value
)
def histogram(x_axis, y_axis, color, size):
    color_val = "species" if color else None

    histogram_fig = px.histogram(
        df,
        x=clean_name(x_axis),
        y=clean_name(y_axis),
        color=color_val,
        barmode='group',
        title=f"Histogram of {y_axis} grouped by {x_axis}"
    )

    return histogram_fig


# Layout
dashboard = pn.Column(
    pn.pane.Markdown("Iris Dataset Explorer"),
    pn.Row(x_axis_select, color_checkbox),
    pn.Row(y_axis_select, size_slider),
    pn.param.ParamFunction(scatter_plot),
    pn.param.ParamFunction(histogram)
)


# To serve app: `panel serve panel_hw4_iris.py  --show --autoreload`
if __name__ == "__main__":
    pn.extension('plotly')
    dashboard.servable()
