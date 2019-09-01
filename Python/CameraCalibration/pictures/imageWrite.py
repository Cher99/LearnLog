import cv2
import numpy as np

mode = 'init'
opened = False

def mode_choose(event , x , y , flags , param):
	global mode
	if event == cv2.EVENT_LBUTTONDOWN:
		mode = 'save'
	else:
		mode = 'pass'

cap = cv2.VideoCapture(1)
if cap.isOpened()==False:
	opened = False
else:
	opened = True

cv2.namedWindow('frame')
i = 1
while opened:
	ret , frame = cap.read()
	gray = cv2.cvtColor(frame , cv2.COLOR_BGR2GRAY)
	cv2.imshow('frame',gray)
	cv2.setMouseCallback('frame' , mode_choose)
	if mode == 'save':
		cv2.imwrite(('./'+str(i)+'.png') , gray)
		print 'the ',i,' image has saved'
		i = i+1
	else:
		pass
	cv2.waitKey(30)
	

	
