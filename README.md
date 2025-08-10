# 🧪 Digital Image Processing Lab – MATLAB

This repository contains MATLAB experiments demonstrating fundamental and intermediate image processing techniques without relying on certain built-in functions, for better understanding of the underlying algorithms.

---

## 📂 Experiments

---

## 🧪 Experiment 1 – Basic Image Processing in MATLAB

### 📌 Overview
This experiment covers basic image operations:
1. Converting a color image to grayscale.
2. Separating RGB color planes.
3. Converting grayscale to binary.

---

### 🔹 1a. RGB to Grayscale Conversion
- **Objective**: Convert a color image into a grayscale image.
- **Description**: Grayscale images represent brightness intensity in a single channel, reducing data complexity while preserving image structure.

---

### 🔹 1b. RGB Color Plane Separation
- **Objective**: Extract individual Red, Green, and Blue components from an RGB image.
- **Description**: Displays each color channel separately, showing how each contributes to the final image.

---

### 🔹 1c. Grayscale to Binary Conversion
- **Objective**: Convert a grayscale image into black-and-white format.
- **Description**: Uses thresholding to classify pixels as either black (0) or white (1).

---

## 🧪 Experiment 2a – Bit Slicing in Grayscale Image (Without Built-in Functions)

### 📌 Overview
This experiment performs **bit-plane slicing** on a grayscale image without using MATLAB's built-in bitwise functions (`bitget`, `bitand`, etc.).

Bit-plane slicing reveals the contribution of each bit in a pixel's binary representation.

---

### 🛠 Process
1. Read a color image (`csp.jpg`).
2. Convert it to grayscale manually using RGB averaging.
3. Extract bits from LSB (bit 1) to MSB (bit 8) using only arithmetic operations.
4. Display each bit-plane in subplots.

---

### 🚀 Features
- No built-in bitwise functions.
- Bit extraction using `mod()` and `floor()` only.
- Displays all 8 bit-planes for analysis.

---

## 🧪 Experiment 2b – Histogram Equalization in MATLAB

### 📌 Overview
This experiment implements **Histogram Equalization** to enhance image contrast by redistributing pixel intensity values.

The method is coded manually without MATLAB's built-in histogram equalization functions.

---

### 🛠 Process
1. Read the input image (`demo.jpg` or any custom image).
2. Convert to grayscale if RGB.
3. Calculate histogram of pixel intensities.
4. Compute the **CDF** (Cumulative Distribution Function).
5. Apply the equalization formula to map old values to new ones.
6. Display the original and equalized images alongside their histograms.

---

### 🚀 Features
- Works for both grayscale and RGB images.
- Manual computation of histogram and CDF.
- Side-by-side visualization of original vs. equalized results.

---

## 📂 File Structure
