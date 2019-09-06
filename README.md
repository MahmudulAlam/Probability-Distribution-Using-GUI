# Visualize Probability Distribution Using Graphical User Interface
![probdistgui](https://user-images.githubusercontent.com/37298971/37386587-4f8e9566-2783-11e8-9024-19fa1d9e5ccf.png)

Calculate and visualize the probability distribution of univariate or bivariate data directly from Excel file. Numerical techniques have been implemented in MATLAB and incorporated with MATLAB graphical user interface (GUI) for user-friendly manipulation.

## Guideline to RUN

1. Execute ProbDistGUI.m file and a GUI window will appear 
2. Load any of the files from ```Data\``` folder 
3. For univariate data, only Plot and Hist buttons work
4. Surf and Contourf buttons are for bivariate data
5. To calculate the probability click on Probability button and another smaller window will appear to take the ranges of integration to calculate the probability

## Buttons Description

Here are the explanations of buttons in a nutshell.
1. Plot: It plots the probability density function for univariate data but for bivariate data it only plots the data value. 
2. Hist: It plots the histogram of the data for both univariate and bivariate data. 
3. Surf: It plots the 3D surface plot of the probability density function of bivariate data.
4. Contourf: It plots the contour plot of bivariate data. 

## How It Works

#### Adaptive Trapezoidal Rule 
Adaptive trapezoidal rule is a numerical approach to calculate the definite integral. To calculate the probability of the normal distribution, the area of under the normal curve, requires calculating the value of following single and double definite integral. 

Probability distribution for univariate data: 
<p align="center">
  <img src="https://user-images.githubusercontent.com/37298971/64421081-91365280-d0c2-11e9-8f13-52e9e1067396.png" width="300">
</p>

Probability distribution function for bivariate data and the double integral of the function: 
<p align="center">
  <img src="https://user-images.githubusercontent.com/37298971/64421085-94314300-d0c2-11e9-9c72-89e4748d0a57.png" width="650">
</p>

<p align="center">
  <img src="https://user-images.githubusercontent.com/37298971/64421088-96939d00-d0c2-11e9-8d99-1a5cb7ffd0c7.png" width="180">
</p>

## More Details! 
For more detail information, please go through the [report](https://drive.google.com/file/d/1rli2l7VV4bsyf52DDUjkC_tEVDW9KMOx/view).
