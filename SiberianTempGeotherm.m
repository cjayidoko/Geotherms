%Script to model the geotherm of Siberia craton. This computes the temp.
%assuming a two-layer conductive geotherm.
%The temperature formular is obtained
%by solving for a 1-D steady state heat equation.
%C Idoko, 2016.
A1 = 0.67e-6;%regional crustal heat production (model from Marshal and Junpart (2005));
k = 2.7;%conductivity of crust in W/m^3;
Q = 3.5e-2;%Surface heat flow  average in Siberian craton (DUCHKOV 1991, Rudnick 1999)
A2 = 0.03e-6;%mantle heat production;
Q2 = 1e-2;%Mantle heat flow  average in Siberian craton (DUCHKOV 1991, Rudnick 1999)
z1 = 40000;%Depth to the second layer;
k2 = 1.8;%mantle thermal conductivity;
z = 0:1:40000;%Depth from surface(sea level) to MOHO;
x = 40001:1:150000;% z from 40km to 150km;
n2 = length(x);
nz = length(z);
T2 = zeros(1,n2);%prdefines T2 to calculate for the second layer;
T = zeros(1,nz);%Preassigns value for Temperature to be calculated;
%Loop to compute the temperature of crust and mantle separately;
for i = 1:length(z)
    T1= -((A1/(2*k))*(z(i).^2))+(Q/k)*z(i)+5;%Temp of crust;
    T(1,i) = T1;
    for j = 1:length(x)
    T3 = -((A2/(2*k2))*(x(j)).^2)+(Q2/k2).*x(j)+(A2/(k2))*z1*(x(j))...
        +325-((Q2*z1)/k2)-((A2*(z1*z1))/(2*k2));%Temp of mantle;
    T2(1,j) = T3;
    end
end
T = [T,T2];%Combines the two layer temperatures
z = 0:1:150000;%redefines z
%Visualization;
figure(10)
plot(T,z/1000),hold on
set(gca,'Ydir','reverse')
%OPTIONAL: to add the variation of Curie-Temp modle with pressure/depth in this model;
plot(Tc(1:150001),z/1000);%plots Curie temperature variation with pressure/depth;
set(gca,'Ydir','reverse')
xlabel('Temperature(deg-C)','FontSize',28,'FontWeight','bold'),ylabel('Depth(km)','FontSize',28,'FontWeight','bold')
title('Plot of z vs T','FontSize',28,'FontWeight','bold')
