# Lecture 01 - Signal Visualization

## Objective

The purpose of this assignment was to learn how to create, visualize, and interpret simple signals using MATLAB.

The assignment included:

- Creating sine waves
- Comparing different frequencies
- Comparing different amplitudes
- Adding noise to signals
- Saving MATLAB figures
- Using AI responsibly
- Submitting the work using GitHub

---

## Task 1 - Create a Sine Wave

A sine wave was generated with the following parameters:

- Amplitude: 1
- Frequency: 5 Hz
- Duration: 1 second

The signal was plotted in MATLAB with a title, axis labels, and grid.

---

## Task 2 - Frequency Comparison

Three sine waves were generated:

- 2 Hz
- 5 Hz
- 10 Hz

They were displayed using MATLAB subplots.

### Questions

**1. Which signal changes fastest?**

The 10 Hz signal changes fastest.

**2. Which signal has the lowest frequency?**

The 2 Hz signal has the lowest frequency.

**3. How can you see the difference in the plots?**

The difference can be seen by comparing the number of cycles completed during the same time period. The 10 Hz signal completes more cycles than the 5 Hz and 2 Hz signals.

---

## Task 3 - Amplitude Comparison

Three sine waves were generated using the same frequency but different amplitudes:

- 0.5
- 1
- 2

### Questions

**1. Which signal has the largest amplitude?**

The signal with amplitude 2 has the largest amplitude.

**2. Does changing amplitude change frequency?**

No. Changing amplitude only changes the height of the signal. The frequency remains the same.

**3. Give one real-world example where amplitude is important.**

Audio signals are one example. A larger amplitude can represent a louder sound.

---

## Task 4 - Adding Noise

A clean 5 Hz sine wave was generated.

Random noise was then added to create a noisy version of the signal.

Both signals were displayed using subplots.

### Questions

**1. What changed after adding noise?**

The signal became irregular and was no longer a perfectly smooth sine wave.

**2. Can you still recognize the original signal?**

Yes. The general sine wave pattern can still be seen underneath the noise.

**3. Give one real-world source of signal noise.**

Electrical interference from nearby electronic devices can introduce noise into a signal.

---

## Task 5 - Saved Figures

The following figures were saved as PNG files:

- `frequency_comparison.png`
- `amplitude_comparison.png`
- `clean_vs_noisy_signal.png`

---

## AI Usage

**AI Tool Used:**

ChatGPT

**Prompt:**

Help me create and understand MATLAB code for generating and visualizing sine waves with different frequencies, amplitudes, and noise.

**What AI Suggested:**

The AI suggested using MATLAB functions such as:

- `sin()`
- `plot()`
- `subplot()`
- `randn()`
- `saveas()`

It also explained how frequency, amplitude, and noise affect a signal.

**Did the code work immediately?**

Yes, the basic code worked correctly.

**What did you modify?**

I organized the code into separate sections for each task and adjusted the signals according to the assignment requirements.

**How did you verify the result?**

I ran the MATLAB script and checked the generated plots. I compared the number of cycles for different frequencies, checked the signal heights for different amplitudes, and observed the effect of noise on the signal.

---

## Files

This folder contains:

- `Lecture01_signal_visualization.m`
- `frequency_comparison.png`
- `amplitude_comparison.png`
- `clean_vs_noisy_signal.png`
- `README.md`
