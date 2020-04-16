%function of 9.1
function [B]=Get_Directivity_Distribution(N,theta,d_lamda)
    B=abs(sin(pi*N*d_lamda*cos(theta*pi/180))./sin(pi*d_lamda*cos(theta*pi/180)));
end