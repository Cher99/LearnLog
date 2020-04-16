clear all;clc;
M=input('请输入明文（16位十六进制数）：','s');
K=input('请输入密钥（16位十六进制数）：','s');
C=DES(M,K);
disp(['密文为：',C])