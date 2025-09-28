import pandas as pd
from sklearn.datasets import load_iris
import plotly.express as px
from dash import Dash, dcc, html, Input, Output

# Load Iris dataset
iris = load_iris()
df = pd.DataFrame(data=iris.data, columns=iris["feature_names"])
df["species"] = iris.target_names[iris.target]


app = Dash(__name__)
app.title = "Iris Dataset Explorer"


app.layout = html.Div([
    html.H1("Iris Dataset Explorer"),

    html.Div([
        html.Div([
            html.Label("X axis"),
            dcc.Dropdown(
                id='x-axis-dropdown',
                options=[
                    {'label': name, 'value': name}
                    for name in iris["feature_names"]
                ],
                value=iris["feature_names"][0]
            ),
            html.Br(),
            dcc.Checklist(
                id='coloring-checklist',
                options=[{'label': 'Coloring by Species', 'value': 'color'}],
                value=[]
            ),
        ], style={'width': '48%', 'display': 'inline-block', 'verticalAlign': 'top'}),

        html.Div([
            html.Label("Y axis"),
            dcc.Dropdown(
                id='y-axis-dropdown',
                options=[{'label': name, 'value': name} for name in iris["feature_names"]],
                value=iris["feature_names"][1]
            ),
            html.Br(),
            html.Label("Marker Size"),
            dcc.Slider(
                id='marker-size-slider',
                min=5,
                max=20,
                step=1,
                marks={5: '5', 10: '10', 15: '15', 20: '20'},
                value=5
            ),
        ], style={'width': '48%', 'display': 'inline-block', 'verticalAlign': 'top'}),
    ]),

    dcc.Graph(id='scatter-plot'),
    dcc.Graph(id='histogram-plot'),
])


# Callback to update plots
@app.callback(
    Output('scatter-plot', 'figure'),
    Output('histogram-plot', 'figure'),
    Input('x-axis-dropdown', 'value'),
    Input('y-axis-dropdown', 'value'),
    Input('coloring-checklist', 'value'),
    Input('marker-size-slider', 'value'),
)
def update_graphs(x_axis, y_axis, coloring_value, marker_size):
    color = 'species' if 'color' in coloring_value else None

    scatter_fig = px.scatter(
        df, x=x_axis, y=y_axis,
        size=[marker_size] * len(df),
        size_max=marker_size,
        color=color,
        title=f"Scatter plot of {x_axis} vs {y_axis}",
        labels={x_axis: x_axis, y_axis: y_axis, "species": "Species"}
    )

    histogram_fig = px.histogram(
        df, x=x_axis, y=y_axis,
        color=color,
        barmode='group',
        title=f"Histogram of {y_axis} grouped by {x_axis}"
    )

    return scatter_fig, histogram_fig


app.run()

# To serve app: `python3 dash_hw4_iris.py`
