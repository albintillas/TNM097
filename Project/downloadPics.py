import pickle
import numpy as np
import os
from PIL import Image

# CIFAR-10-mapp efter extraktion
cifar_folder = "cifar-10-batches-py"
output_folder = "pics"

# Skapa mapp om den inte finns
os.makedirs(output_folder, exist_ok=True)

# Funktion för att ladda en batch-fil
def load_batch(file):
    with open(file, "rb") as fo:
        dict = pickle.load(fo, encoding="bytes")
    return dict[b"data"], dict[b"labels"]

# CIFAR-10 klassindex: 'airplane' = 0
airplane_class = 0

batch_files = [f"data_batch_{i}" for i in range(1, 6)]
image_count = 0

for batch in batch_files:
    data, labels = load_batch(os.path.join(cifar_folder, batch))
    
    for i in range(len(data)):
        if labels[i] == airplane_class:  # Endast 'airplane' bilder
            img_array = data[i].reshape(3, 32, 32).transpose(1, 2, 0)
            img = Image.fromarray(img_array)

            img_path = os.path.join(output_folder, f"airplane_{image_count}.png")
            img.save(img_path)
            image_count += 1

print(f"✅ {image_count} bilder av 'airplanes' sparade i '{output_folder}'!")
