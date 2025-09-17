from dash import Dash, dcc, html, Input, Output
import plotly.express as px
import pandas as pd
import numpy as np

# Create the app
app = Dash(__name__)

# Define the app layout
app.layout = html.Div([
    html.H1('Simple Data Explorer (Dash)'),
    dcc.Slider(
        id='n-rows-slider',
        min=5, max=100, value=20,
        marks={i: str(i) for i in [5, 25, 50, 75, 100]}
    ),
    dcc.Graph(id='data-plot')
])

# Define the callback (the reactive part)
@app.callback(
    Output('data-plot', 'figure'),
    Input('n-rows-slider', 'value')
)
def update_graph(n_rows):
    # Generate data based on the slider value
    k = int(np.round(n_rows))
    data = pd.DataFrame({
        'x': np.arange(k),
        'y': np.random.rand(int(np.round(n_rows)))
    })
    # Create the figure
    fig = px.line(data, x='x', y='y', title=f'Plot of {k} random points')
    return fig

if __name__ == '__main__':
    app.run(debug=True)