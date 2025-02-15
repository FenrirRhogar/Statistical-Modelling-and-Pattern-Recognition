clear all;
close all;
clc

n = linspace(-10, 10 , 100);
 
 s1 =1;
 s2 =2;
 
 for i = 1:length(n)
     if n(i)<0
         y(i)=0;
     else
         y(i)= raylpdf(n(i),s1);
     end
 end
 
  for i = 1:length(n)
     if n(i)<0
         y1(i)=0;
     else
         y1(i)= raylpdf(n(i),s2);
     end
 end

 x1 = (2/3)*sqrt(6*log(2));
 plot(n,y);
 hold on;
 plot(n,y1);
 hold on;
 y1 = [0 0.7]; % specifies the range of y values that the line will cover
 plot([x1 x1], y1) % plots the line
 
 
 

 
 
 