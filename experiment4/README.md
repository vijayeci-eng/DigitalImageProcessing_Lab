# 🧪 Digital Image Processing Lab – MATLAB  
This repository contains MATLAB experiments demonstrating **image compression techniques** implemented manually (without relying entirely on built-in image compression).  

---

## 📂 Experiment

### 🔹 Experiment 4a – JPEG Compression (Simplified Grayscale Version)  
#### 📌 Overview  
This experiment demonstrates the **JPEG compression process** step by step:  
1. Convert input image to grayscale and resize.  
2. Split into 8×8 blocks and apply **Discrete Cosine Transform (DCT)**.  
3. Quantize using the **standard JPEG quantization matrix**.  
4. Apply **Zigzag scanning** and **Run Length Encoding (RLE)**.  
5. Reconstruct the image with inverse steps (Dequantization + IDCT).  
6. Display:  
   - Original Image  
   - Reconstructed Image  
   - Compression ratio comparison (bar chart).  

#### 📊 Key Point  
- The **original size** is measured as uncompressed raw pixel data (8 bits/pixel).  
- The **compressed size** is estimated from the RLE-encoded data.  
- This is **not the same as JPEG file size** stored on disk, since MATLAB reads images into raw matrices first.  

---

### 🔹 Experiment 4b – Arithmetic Compression  
#### 📌 Overview  
This experiment demonstrates **lossless arithmetic coding** applied to image pixel data:  
1. Convert the image to grayscale and resize.  
2. Compute histogram and probability distribution of pixel intensities.  
3. Use **Arithmetic Encoder** (`arithenco`) for compression.  
4. Decode with **Arithmetic Decoder** (`arithdeco`).  
5. Display:  
   - Original Image  
   - Reconstructed Image (lossless, same as original)  
   - Compression ratio comparison (bar chart).  

#### 📊 Key Point  
- The **original size** shown is the uncompressed raw image size (`rows × cols × 8 bits`).  
- This value may **differ from the file size on disk** (e.g., a 43 KB JPEG may appear as 16 KB raw size in MATLAB).  
- Reason: MATLAB loads images into **uncompressed pixel arrays**, so the experiment measures compression from that baseline.  

---

## ⚙️ Requirements  
- MATLAB R2021a or later (Image Processing Toolbox recommended).  
- Input image file (e.g., `cap.jpg`).  

---

## 📷 Example Output  

- **Experiment 4a – JPEG Compression**  
  - Original Image  
  - Reconstructed Image (with visible quality loss)  
  - Compression ratio chart  

- **Experiment 4b – Arithmetic Compression**  
  - Original Image  
  - Reconstructed Image (lossless, identical)  
  - Compression ratio chart  

---

## 📌 Notes  
- **Experiment 4a** (JPEG) is **lossy compression** – quality is reduced.  
- **Experiment 4b** (Arithmetic Coding) is **lossless compression** – reconstructed image is identical.  
- Compression ratios depend on the image content (smooth images compress better than noisy ones).  

---

✍️ **Done By:** A. Vijay Teja  
📅 **Date:** 24-08-2025  

---
