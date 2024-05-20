close all
clear
clc
addpath(genpath('Feat'));
addpath(genpath('Funcs'));
addpath(genpath('tool'));
addpath filter


[imagename1 imagepath1]=uigetfile('E:\备份\00 医学数据集\医学 源图像\*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the first input image');
gray_image=imread(strcat(imagepath1,imagename1)); 

[imagename2 imagepath2]=uigetfile('E:\备份\00 医学数据集\医学 源图像\*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the first input image');
color_image=imread(strcat(imagepath2,imagename2)); 



Fusion_image=YUV_fusion(gray_image,color_image,0.07,0.02);

figure
imshow(Fusion_image)
 