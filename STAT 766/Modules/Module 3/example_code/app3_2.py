import panel as pn
import pandas as pd
from sklearn.datasets import load_iris
import matplotlib.pyplot as plt

pn.extension()

# Load data
iris = load_iris()
iris_df = pd.DataFrame(iris.data, columns=iris.feature_names)
iris_df['species'] = [iris.target_names[i] for i in iris.target]

# Create widgets
x_selector = pn.widgets.Select(name='X Axis', options=iris.feature_names, value=iris.feature_names[0])
y_selector = pn.widgets.Select(name='Y Axis', options=iris.feature_names, value=iris.feature_names[1])
species_filter = pn.widgets.MultiSelect(name='Species', options=list(iris.target_names), value=list(iris.target_names))

# Use the @pn.depends decorator to make this function reactive
# It automatically watches the widgets specified in the decorator
@pn.depends(x_selector.param.value, y_selector.param.value, species_filter.param.value)
def create_plot_decorated(x_col, y_col, selected_species):
    plot_df = iris_df[iris_df['species'].isin(selected_species)]
    
    fig, ax = plt.subplots(figsize=(8, 6))
    scatter = ax.scatter(plot_df[x_col], plot_df[y_col], c=plot_df['species'].astype('category').cat.codes, cmap='plasma')
    ax.set_xlabel(x_col)
    ax.set_ylabel(y_col)
    ax.set_title(f'{y_col} vs. {x_col} (Declarative)')
    
    legend1 = ax.legend(handles=scatter.legend_elements()[0], labels=selected_species, title="Species")
    ax.add_artist(legend1)
    
    return fig

# Layout the app. Notice we can reference the function directly now.
app_decorative = pn.template.FastListTemplate(
    title='Iris Explorer - Declarative Style',
    sidebar=[x_selector, y_selector, species_filter],
    main=[pn.pane.Markdown("# Using `@pn.depends`"), create_plot_decorated],
    accent="#008000",
)

app_decorative.servable()