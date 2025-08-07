# 🧪 Experiment 1 – Basic Image Processing in MATLAB

This experiment focuses on fundamental operations in image processing using MATLAB. It includes converting a color image to grayscale, separating RGB color planes, and converting a grayscale image into a binary (black and white) format.

---

## 📄 Descriptions

### 🔹 1a. RGB to Grayscale Conversion
- **Objective**: Convert a color image into a grayscale image.
- **Description**: Grayscale images are single-channel images where each pixel represents brightness intensity. This transformation reduces the complexity of color data while preserving structural content of the image. MATLAB computes grayscale values using a weighted sum of the RGB components.

---

### 🔹 1b. RGB Color Plane Separation
- **Objective**: Extract individual Red, Green, and Blue components from an RGB image.
- **Description**: An RGB image is composed of three color channels. Separating these planes allows visualization of how each color contributes to the full image. Each plane is displayed as a grayscale image indicating intensity of that color component.

---

### 🔹 1c. Grayscale to Black and White (Binary) Conversion
- **Objective**: Convert a grayscale image to a binary (black and white) image.
- **Description**: Binary images contain only two pixel values—0 (black) and 1 (white). This conversion is commonly used in thresholding and object segmentation. Pixels above a specified threshold become white; those below become black. MATLAB supports both manual and automatic thresholding methods.

---

# DigitalImageProcessing_Lab
# 🧪 Bit Slicing in Grayscale Image using MATLAB (Without Built-in Bit Functions)

## 📌 Project Overview

This MATLAB project performs **bit-plane slicing** on a grayscale version of a color image **without using any built-in bit manipulation functions** (like `bitget`, `bitand`, etc.).

Bit-plane slicing is a fundamental technique in **Digital Image Processing (DIP)** used to analyze the contribution of each bit in the pixel's binary representation.

---

## 🧠 What This Code Does

1. Reads a color image (`cap.jpg`).
2. Converts the color image to grayscale using manual averaging.
3. Extracts each bit (from LSB to MSB) **manually** using arithmetic operations.
4. Displays all 8 bit-planes using subplots.

---

## 💻 Code Features

- 🚫 No use of MATLAB's built-in bit functions (`bitget`, `bitshift`, etc.)
- 🧮 Bit values are extracted using `mod()` and `floor()` operations only.
- 🖼️ Grayscale conversion is performed using RGB average.
- 🔢 Bit planes are displayed from **LSB (Bit Plane 1)** to **MSB (Bit Plane 8)** for better understanding.

---

## 📂 File Structure


