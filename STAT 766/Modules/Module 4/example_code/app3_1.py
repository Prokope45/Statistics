import panel as pn
import pandas as pd
from sklearn.datasets import load_iris
import matplotlib.pyplot as plt

# Enable Panel's extension for matplotlib
pn.extension()

# Load the Iris dataset
iris = load_iris()
iris_df = pd.DataFrame(iris.data, columns=iris.feature_names)
iris_df['species'] = [iris.target_names[i] for i in iris.target]

# Create widgets for user input
x_selector = pn.widgets.Select(
    name='X Axis', 
    options=iris.feature_names, 
    value=iris.feature_names[0] # Default value
)
y_selector = pn.widgets.Select(
    name='Y Axis', 
    options=iris.feature_names, 
    value=iris.feature_names[1] # Default value
)
species_filter = pn.widgets.MultiSelect(
    name='Species', 
    options=list(iris.target_names), 
    value=list(iris.target_names) # Default: all selected
)

# Define the function that creates the plot
# This function will be called automatically when widgets change
def create_plot(x_col, y_col, selected_species):
    # Filter data based on selected species
    plot_df = iris_df[iris_df['species'].isin(selected_species)]
    
    # Create the figure
    fig, ax = plt.subplots(figsize=(8, 6))
    scatter = ax.scatter(plot_df[x_col], plot_df[y_col], c=plot_df['species'].astype('category').cat.codes, cmap='viridis')
    ax.set_xlabel(x_col)
    ax.set_ylabel(y_col)
    ax.set_title(f'{y_col} vs. {x_col}')
    
    # Add a legend
    legend1 = ax.legend(handles=scatter.legend_elements()[0], labels=selected_species, title="Species")
    ax.add_artist(legend1)
    
    return fig

# Bind the function to the widgets
# Now, interactive_plot will automatically update its arguments from the widgets
interactive_plot = pn.bind(create_plot, x_selector, y_selector, species_filter)

# Create a description text
description = pn.pane.Markdown("""
# Iris Dataset Explorer
Explore the relationship between different features of the Iris flower dataset.
Select variables for the X and Y axes and filter by species.
""")

# Layout the dashboard using a Template for a nicer look
# The 'interactive_plot' object is a reactive component that will re-render when inputs change.
app = pn.template.FastListTemplate(
    title='Iris Data Explorer with Panel',
    sidebar=[x_selector, y_selector, species_filter],
    main=[description, interactive_plot],
    accent="#A01346",
)

# Serve the app
app.servable()