📂 Experiments
🧪 Experiment 3a – Shannon-Fano Coding for Grayscale Images

📌 Overview
Shannon-Fano coding is an entropy-based lossless compression method for grayscale images.

🔹 3a.1 Symbol Sorting

Objective: Sort image pixel values by frequency.

Description: Prepares data for recursive code assignment.

🔹 3a.2 Code Assignment

Objective: Divide symbols into two groups and assign binary codes.

Description: Ensures prefix-free coding for compression.

🔹 3a.3 Encoding and Compression

Objective: Replace pixels with Shannon-Fano codes to compress the image.

Description: Produces a compressed binary stream representing the image.

🔹 3a.4 Decoding

Objective: Reconstruct the original image from compressed data.

Description: Uses the Shannon-Fano code table to retrieve original pixel values.

🧪 Experiment 3b – Huffman Coding for Grayscale Images

📌 Overview
Huffman coding is a widely used entropy-based lossless compression technique for grayscale images.

🔹 3b.1 Frequency Calculation

Objective: Count occurrences of each pixel value in the image.

Description: Builds a probability table for the image pixels to prepare for code assignment.

🔹 3b.2 Huffman Tree Construction

Objective: Build the Huffman tree based on pixel frequencies.

Description: Combines nodes using a priority-based approach until a single root node is obtained.

🔹 3b.3 Encoding and Compression

Objective: Generate variable-length Huffman codes and compress the image.

Description: Each pixel is replaced with its corresponding Huffman code to reduce the overall data size.

🔹 3b.4 Decoding

Objective: Reconstruct the original image from compressed data.

Description: Traverses the Huffman tree to retrieve pixel values.

⚡ Notes

Both algorithms work on grayscale images (0–255 levels).

Compression effectiveness depends on the image’s pixel value distribution.

Designed for educational purposes, demonstrating the fundamentals of lossless image compression.
