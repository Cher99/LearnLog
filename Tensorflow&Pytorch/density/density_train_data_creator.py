#!/usr/bin/env/python
#-*- coding : utf-8 -*-
# coding:utf-8
#Yijiang Chen

import numpy as np
import matplotlib.pyplot as plt
import random
plt.rcParams['font.sans-serif']=['SimHei']
plt.rcParams['axes.unicode_minus'] = False
#matplotlib画图中中文显示会有问题，需要这两行设置默认字体

##generate maps with different density.

num_classes=5
batch= 500 #100 pictures per class. 
points_num_min=0
points_num_max=400
epoch=(points_num_max/num_classes)
deal_batch=1

# image settings
colors1 = '#0C143C'
area = 1 # 点面积 


while(deal_batch <= num_classes):
	if(deal_batch==1):
		i=1
		while(i<=batch):
			num_points=random.randint(0,epoch)
			x1=[]
			y1=[]
			a=1
			while(a<=num_points):
				x=int(np.random.uniform(0,100))
				y=int(np.random.uniform(0,100))
				x1.append(x)
				y1.append(y)
				a=a+1
			plt.axis('off')
			fig1 = plt.gcf()
			f=open(r'./test_label/c1_'+str(i)+'.txt','w')
			f.write(str(num_points))
			f.close()
			fig1.set_size_inches(2.2/3,2.2/3) 
			plt.xlim(right=100,left=0)
			plt.ylim(top=100,bottom=0)

			plt.scatter(x1, y1, s=area,c=colors1, alpha=0.4)
			plt.plot(color='#000000')
			fig1.savefig(r'./test_data/c1_'+str(i)+'.png', format='png', transparent=True, dpi=300, pad_inches = 0)
			fig1.clear()
			i=i+1
		print('class_1 has been saved.')
	if(deal_batch==2):
		i=1
		while(i<=batch):
			num_points=random.randint(0+epoch,epoch+epoch)
			x2=[]
			y2=[]
			a=1
			while(a<=num_points):
				x=int(np.random.uniform(0,100))
				y=int(np.random.uniform(0,100))
				x2.append(x)
				y2.append(y)
				a=a+1
			plt.axis('off')
			f=open(r'./test_label/c2_'+str(i)+'.txt','w')
			f.write(str(num_points))
			f.close()
			fig1 = plt.gcf()
			fig1.set_size_inches(2.2/3,2.2/3) 
			plt.xlim(right=100,left=0)
			plt.ylim(top=100,bottom=0)
			#plt.margins(0,0)

			plt.scatter(x1, y1, s=area,c=colors1, alpha=0.4)
			plt.plot(color='#000000')
			fig1.savefig(r'./test_data/c2_'+str(i)+'.png', format='png', transparent=True, dpi=300, pad_inches = 0)
			fig1.clear()
			i=i+1
		print('class_2 has been saved.')
	if(deal_batch==3):
		i=1
		while(i<=batch):
			num_points=random.randint(0+epoch*2,epoch+epoch*2)
			x3=[]
			y3=[]
			a=1
			while(a<=num_points):
				x=int(np.random.uniform(0,100))
				y=int(np.random.uniform(0,100))
				x3.append(x)
				y3.append(y)
				a=a+1
			plt.axis('off')
			f=open(r'./test_label/c3_'+str(i)+'.txt','w')
			f.write(str(num_points))
			f.close()
			fig3 = plt.gcf()
			fig3.set_size_inches(2.2/3,2.2/3)
			plt.xlim(right=100,left=0)
			plt.ylim(top=100,bottom=0)
			plt.scatter(x3, y3, s=area, c=colors1, alpha=0.4)
			plt.plot(color='#000000')
			fig3.savefig(r'./test_data/c3_'+str(i)+'.png', format='png', transparent=True, dpi=300, pad_inches = 0)
			fig3.clear()
			i=i+1
		print('class_3 has been saved.')
	if(deal_batch==4):
		i=1
		while(i<=batch):
			num_points=random.randint(0+epoch*3,epoch+epoch*3)
			x4=[]
			y4=[]
			a=1
			while(a<=num_points):
				x=int(np.random.uniform(0,100))
				y=int(np.random.uniform(0,100))
				x4.append(x)
				y4.append(y)
				a=a+1
			plt.axis('off')
			f=open(r'./test_label/c4_'+str(i)+'.txt','w')
			f.write(str(num_points))
			f.close()
			fig4 = plt.gcf()
			fig4.set_size_inches(2.2/3,2.2/3) #dpi = 300, output = 700*700 pixels
			plt.gca().xaxis.set_major_locator(plt.NullLocator())
			plt.gca().yaxis.set_major_locator(plt.NullLocator())
			plt.xlim(right=100,left=0)
			plt.ylim(top=100,bottom=0)

			plt.scatter(x4, y4, s=area, c=colors1,alpha=0.4)
			plt.plot(color='#000000')
			fig4.savefig(r'./test_data/c4_'+str(i)+'.png', format='png', transparent=True, dpi=300, pad_inches = 0)
			fig4.clear()
			i=i+1
		print('class_4 has been saved.')
	if(deal_batch==5):
		i=1
		while(i<=batch):
			num_points=random.randint(0+epoch*4,epoch+epoch*4)
			x5=[]
			y5=[]
			a=1
			while(a<=num_points):
				x=int(np.random.uniform(0,100))
				y=int(np.random.uniform(0,100))
				x5.append(x)
				y5.append(y)
				a=a+1
			plt.axis('off')
			f=open(r'./test_label/c5_'+str(i)+'.txt','w')
			f.write(str(num_points))
			f.close()
			fig5 = plt.gcf()
			fig5.set_size_inches(2.2/3,2.2/3)
			plt.gca().xaxis.set_major_locator(plt.NullLocator())
			plt.gca().yaxis.set_major_locator(plt.NullLocator())
			plt.xlim(right=100,left=0)
			plt.ylim(top=100,bottom=0)

			plt.scatter(x5, y5, s=area, c=colors1,alpha=0.4)
			plt.plot(color='#000000')
			fig5.savefig(r'./test_data/c5_'+str(i)+'.png', format='png', transparent=True, dpi=300, pad_inches = 0)
			fig5.clear()
			i=i+1
		print('class_5 has been saved.')
	deal_batch=deal_batch+1
