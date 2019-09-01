#coding:utf-8

import cv2
import numpy as np 

width = 450
height = 350
length = 50

image = np.zeros((width,height),dtype = np.uint8)
print image.shape[0]
print '---------'
print image.shape[1]
print '---------'

for j in range(height):
	for i in range(width):
		if (int(i/length) + int(j/length))%2 :
			image[i,j] = 255
#cv2.imwrite('./checkerBoard.png',image)
cv2.imshow('chess',image)
cv2.waitKey(0)
