""" Simple Tensorflow Test Script """
# import tensorflow
import tensorflow as tf

print("TensorFlow version:", tf.__version__)
# checks if a GPU is available
print(tf.config.list_physical_devices("GPU"))

# Download the MNIST dataset
mnist = tf.keras.datasets.mnist
# Split the dataset into train and test sets
(x_train, y_train), (x_test, y_test) = mnist.load_data()
x_train, x_test = x_train / 255.0, x_test / 255.0
# Build the model
model = tf.keras.models.Sequential(
    [
        tf.keras.layers.Flatten(input_shape=(28, 28)),
        tf.keras.layers.Dense(128, activation="relu"),
        tf.keras.layers.Dropout(0.2),
        tf.keras.layers.Dense(10),
    ]
)
# print current model's prediction as softmax probabilities
predictions = model(x_train[:1]).numpy()
print(f"Prediction before training: {tf.nn.softmax(predictions).numpy()}")
# Define the loss function
loss_fn = tf.keras.losses.SparseCategoricalCrossentropy(from_logits=True)
# Compile the model
model.compile(optimizer="adam", loss=loss_fn, metrics=["accuracy"])
# Train the model
model.fit(x_train, y_train, epochs=5)
# Evaluate the model
model.evaluate(x_test, y_test, verbose=2)
# print current model's prediction as softmax probabilities
probability_model = tf.keras.Sequential([model, tf.keras.layers.Softmax()])
print(f"Prediction after training: {probability_model(x_test[:1]).numpy()}")
