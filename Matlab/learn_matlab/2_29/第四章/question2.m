% Yijiang Chen 2.26
clear all;clc;
seconds_all=10000;
seconds=rem(seconds_all,60);
mins_all=fix(seconds_all/60);
mins=rem(mins_all,60);
hours_all=fix(mins_all/60);
hours=rem(hours_all,60);
disp([num2str(hours),'–° ±',num2str(mins),'∑÷',num2str(seconds),'√Î'])