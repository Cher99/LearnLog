import cv2

opened = False
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
	cv2.waitKey(30)