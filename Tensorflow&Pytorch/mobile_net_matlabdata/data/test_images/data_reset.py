#!/usr/bin/env/python
#-*- coding : utf-8 -*-
# coding:utf-8

import numpy as np
from PIL import Image
import matplotlib as mpl
import matplotlib.pyplot as plt


iter_num = 0
width=320
height=220
form1='.jpg'

train_batch=[]
label_batch=[]

for i in range(25):
	im = Image.open(str(iter_num)+form1).convert('RGB')
	image = np.asarray(im)
	if len(image)>height:
		image=image[:height]
		for j in range(height):
			if len(image[j])>width:
				image[j]=int(image[j][:width])
	image=Image.fromarray(np.uint8(image))
	image.save(str(iter_num)+form1,quality=95)
	iter_num=iter_num+2
	print('data processed.')
A=np.array(plt.imread('0.jpg'))
print(A)