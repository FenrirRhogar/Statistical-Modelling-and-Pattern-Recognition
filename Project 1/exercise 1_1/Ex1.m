clear all;
close all;
clc
%1
m1 = [3; 3]
m2 = [6; 6]

s1 = [1.2 -0.4; -0.4 1.2];
s2 = [1.2 0.4; 0.4 1.2];
p1= [0.1 0.25 0.5 0.75 0.9];
p2=1-p1;

% Compute the decision boundary coefficients
x = linspace(-10, 10 , 100);
y = linspace(-10,10,100);
[X,Y]=meshgrid(x,y);

B1 = x-m1;
B2 = x-m2;
S1 = inv(s1);
S2 = inv(s2);


%f= B2'*S2*B2-B1'*S1*B1 -2*log(p2(i)/p1(i)) decision boundary

%2


Z1 = mvnpdf([X(:) Y(:)], m1', s1);
Z1 = reshape(Z1, size(X));

Z2 = mvnpdf([X(:) Y(:)], m2', s2);
Z2 = reshape(Z2, size(X));
figure(1);
surf(X,Y,Z1,'FaceColor','blue');
xlabel("x");
ylabel("y");
zlabel("z");
hold on;
surf(X,Y,Z2,'FaceColor','red');
hold on
xlabel("x");
ylabel("y");
zlabel("z");
title("3D Plot without Decision Boundary");

%3
figure(2);
for i = 1:5

f= B2'*S2*B2-B1'*S1*B1 -2*log(p2(i)/p1(i));

subplot(2, 3, i);
surf(X,Y,Z1,'FaceColor','blue');
xlabel("x");
ylabel("y");
zlabel("z");
hold on;
surf(X,Y,Z2,'FaceColor','red');
hold on
surf(X,Y,f,'FaceColor','green','FaceAlpha',0.5);
xlabel("x");
ylabel("y");
zlabel("z");
title("3D Plot with Decision Boundary P1=" + p1(i) );
end


figure(3);
contour(X,Y,Z1, 'LineColor', 'blue', 'LineWidth', 2);
grid on     
hold on;
contour(X,Y,Z2, 'LineColor', 'red', 'LineWidth', 2);
grid on  
xlabel("x");
ylabel("y");
title("2D Plot without Decision Boundary");

figure(4);
for i=1:5;
    subplot(2, 3, i);
    f= B2'*S2*B2-B1'*S1*B1 -2*log(p2(i)/p1(i));
    contour(X,Y,Z1, 'LineColor', 'blue', 'LineWidth', 2);
    grid on     
    hold on;
    contour(X,Y,Z2, 'LineColor', 'red', 'LineWidth', 2);
    grid on  
    contour(X,Y,f, 'LineColor', 'green', 'LineWidth', 2);
    xlabel("x");
    ylabel("y");
    title("2D Plot without Decision Boundary P1=" + p1(i));
end

%4.1


s = [1.2 0.4; 0.4 1.2];

% Compute the decision boundary coefficients
x = linspace(-10, 10 , 100);
y = linspace(-10,10,100);
[X,Y]=meshgrid(x,y);

B1 = x-m1;
B2 = x-m2;
S = inv(s);
%f= B2'*S*B2-B1'*S*B1 -2*log(p2(i)/p1(i)) decision boundary

%4.2

Z1 = mvnpdf([X(:) Y(:)], m1', s);
Z1 = reshape(Z1, size(X));

Z2 = mvnpdf([X(:) Y(:)], m2', s);
Z2 = reshape(Z2, size(X));

figure(5);
surf(X,Y,Z1,'FaceColor','blue');
xlabel("x");
ylabel("y");
zlabel("z");
hold on;
surf(X,Y,Z2,'FaceColor','red');
hold on
xlabel("x");
ylabel("y");
zlabel("z");
title("3D Plot without Decision Boundary");

%4.3
figure(6);
for i = 1:5

    f= B2'*S*B2-B1'*S*B1 -2*log(p2(i)/p1(i));
    subplot(2, 3, i);
    surf(X,Y,Z1,'FaceColor','blue');
    xlabel("x");
    ylabel("y");
    zlabel("z");
    hold on;
    surf(X,Y,Z2,'FaceColor','red');
    hold on
    surf(X,Y,f,'FaceColor','green','FaceAlpha',0.5);
    xlabel("x");
    ylabel("y");
    zlabel("z");
    title("3D Plot with Decision Boundary P1=" + p1(i) );
end


figure(7);
contour(X,Y,Z1, 'LineColor', 'blue', 'LineWidth', 2);
grid on     
hold on;
contour(X,Y,Z2, 'LineColor', 'red', 'LineWidth', 2);
grid on  
xlabel("x");
ylabel("y");
title("2D Plot without Decision Boundary");

figure(8);
for i=1:5;
    subplot(2, 3, i);
    f= B2'*S*B2-B1'*S*B1 -2*log(p2(i)/p1(i));
    contour(X,Y,Z1, 'LineColor', 'blue', 'LineWidth', 2);
    grid on     
    hold on;
    contour(X,Y,Z2, 'LineColor', 'red', 'LineWidth', 2);
    grid on  
    contour(X,Y,f, 'LineColor', 'green', 'LineWidth', 2);
    xlabel("x");
    ylabel("y");
    title("2D Plot without Decision Boundary P1=" + p1(i));
end





