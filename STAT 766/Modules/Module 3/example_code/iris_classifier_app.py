import panel as pn
import pandas as pd
import numpy as np
from sklearn.datasets import load_iris
from sklearn.linear_model import LogisticRegression
import matplotlib.pyplot as plt
from matplotlib.colors import ListedColormap
import matplotlib.patches as mpatches

# Enable Panel extension and set style
pn.extension(sizing_mode='stretch_width')
plt.style.use('default')

# Load and prepare the Iris dataset
iris = load_iris()
iris_df = pd.DataFrame(iris.data, columns=iris.feature_names)
iris_df['species'] = [iris.target_names[i] for i in iris.target]
iris_df['species_code'] = iris.target

# Handle different versions of scikit-learn where feature_names might be list or array
if hasattr(iris.feature_names, 'tolist'):
    feature_names_list = iris.feature_names.tolist()
else:
    feature_names_list = iris.feature_names

# Train the logistic regression model
X = iris.data
y = iris.target
model = LogisticRegression(max_iter=200, random_state=42)
model.fit(X, y)

# Create widgets for plot configuration
x_axis = pn.widgets.Select(
    name='X Axis', 
    options=feature_names_list, 
    value=feature_names_list[0]
)
y_axis = pn.widgets.Select(
    name='Y Axis', 
    options=feature_names_list, 
    value=feature_names_list[1]
)

# Create input widgets for new prediction
sepal_length = pn.widgets.NumberInput(
    name='Sepal Length (cm)', 
    value=5.0, 
    start=4.0, 
    end=8.0, 
    step=0.1
)
sepal_width = pn.widgets.NumberInput(
    name='Sepal Width (cm)', 
    value=3.0, 
    start=2.0, 
    end=4.5, 
    step=0.1
)
petal_length = pn.widgets.NumberInput(
    name='Petal Length (cm)', 
    value=1.5, 
    start=1.0, 
    end=7.0, 
    step=0.1
)
petal_width = pn.widgets.NumberInput(
    name='Petal Width (cm)', 
    value=0.2, 
    start=0.1, 
    end=2.5, 
    step=0.1
)

# Create a button for prediction
predict_btn = pn.widgets.Button(name='Predict Species', button_type='primary')

# Create output areas
prediction_output = pn.pane.Alert('## Prediction will appear here\nEnter values and click "Predict Species"', alert_type='info')
accuracy_display = pn.pane.Markdown(f"### Model Accuracy: {model.score(X, y):.3f}")

# Initialize user points storage
if 'user_points' not in pn.state.cache:
    pn.state.cache['user_points'] = []

user_points = pn.state.cache['user_points']

def create_iris_plot():
    """Create interactive plot with training data and user points"""
    fig, ax = plt.subplots(figsize=(10, 7))
    
    # Get the current selected columns
    x_col = x_axis.value
    y_col = y_axis.value
    
    # Create colormap for species
    colors = ['red', 'green', 'blue']
    cmap = ListedColormap(colors)
    
    # Plot training data
    scatter = ax.scatter(
        iris_df[x_col], 
        iris_df[y_col], 
        c=iris_df['species_code'], 
        cmap=cmap, 
        s=60, 
        alpha=0.7,
        edgecolors='w',
        linewidth=0.5
    )
    
    # Plot user points if any
    if user_points:
        user_x = [point['x'] for point in user_points]
        user_y = [point['y'] for point in user_points]
        user_colors = ['purple'] * len(user_points)
        
        user_scatter = ax.scatter(
            user_x, user_y, 
            c=user_colors, 
            s=100, 
            marker='X', 
            edgecolors='black',
            linewidth=1.5,
            label='User Inputs'
        )
    
    # Add labels and title
    ax.set_xlabel(x_col, fontsize=12)
    ax.set_ylabel(y_col, fontsize=12)
    ax.set_title('Iris Dataset - Logistic Regression Classifier\n(Training Data + User Predictions)', fontsize=14)
    
    # Create legend for species
    legend_elements = [
        mpatches.Patch(color=colors[i], label=iris.target_names[i]) 
        for i in range(3)
    ]
    if user_points:
        legend_elements.append(
            mpatches.Patch(color='purple', label='User Input Points')
        )
    
    ax.legend(handles=legend_elements, loc='best')
    ax.grid(True, alpha=0.3)
    
    plt.tight_layout()
    return fig

# Create initial plot
initial_fig = create_iris_plot()

# Create the plot pane with the initial figure
plot_pane = pn.pane.Matplotlib(initial_fig, dpi=100, height=500)

def predict_species(event):
    """Predict species based on user input and update the plot"""
    try:
        # Get user input
        user_input = np.array([[
            sepal_length.value,
            sepal_width.value,
            petal_length.value,
            petal_width.value
        ]])
        
        # Make prediction
        prediction = model.predict(user_input)[0]
        probability = model.predict_proba(user_input)[0]
        species_name = iris.target_names[prediction]
        
        # Get the indices for the currently selected columns
        x_idx = feature_names_list.index(x_axis.value)
        y_idx = feature_names_list.index(y_axis.value)
        
        # Store the user point
        user_point = {
            'x': user_input[0, x_idx],
            'y': user_input[0, y_idx],
            'species': 'User Input',
            'full_data': user_input[0].copy(),
            'predicted_species': species_name,
            'probabilities': probability.copy()
        }
        user_points.append(user_point)
        
        # Update prediction output
        prob_text = "<br>".join([f"{iris.target_names[i]}: {prob:.3f}" for i, prob in enumerate(probability)])
        prediction_output.object = f"""
        ## Prediction: **{species_name}**
        ### Probabilities:
        {prob_text}
        """
        prediction_output.alert_type = 'success'
        
        # Force the plot to update
        updated_fig = create_iris_plot()
        plot_pane.object = updated_fig
        
    except Exception as e:
        prediction_output.object = f"## Error: {str(e)}"
        prediction_output.alert_type = 'danger'

# Link button to prediction function
predict_btn.on_click(predict_species)

def update_plot(event):
    """Update plot when axis selection changes"""
    updated_fig = create_iris_plot()
    plot_pane.object = updated_fig

# Link axis widgets to plot update
x_axis.param.watch(update_plot, 'value')
y_axis.param.watch(update_plot, 'value')

# Create explanation text
explanation = pn.pane.Markdown("""
## Iris Species Classifier
This app uses a **logistic regression model** to classify iris flowers into three species:
- **setosa**
- **versicolor** 
- **virginica**

Adjust the plot axes using the dropdowns below. Enter measurements in the input boxes and click 
"Predict Species" to see the classification and add your point to the plot.
""")

# Create layout using a template
app = pn.template.FastListTemplate(
    title='Iris Species Classifier - Logistic Regression',
    sidebar=[
        pn.Accordion(
            ('Plot Configuration', pn.Column(x_axis, y_axis)),
            ('Input Measurements', pn.Column(sepal_length, sepal_width, petal_length, petal_width)),
            active=[0, 1],
            toggle=True
        ),
        predict_btn,
        prediction_output,
        accuracy_display
    ],
    main=[
        explanation,
        plot_pane
    ],
    theme_toggle=False,
    accent='#FF6B6B'
)

# Make the app servable
app.servable()

# Instructions for running:
# Save as iris_classifier_app.py
# Run: panel serve iris_classifier_app.py --show --autoreload