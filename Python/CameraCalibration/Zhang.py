#coding:utf-8
import cv2
import numpy as np
import glob

criteria = (cv2.TERM_CRITERIA_EPS + cv2.TERM_CRITERIA_MAX_ITER , 30 , 0.001)

w = 8
h = 6

world = np.zeros((w*h,3),np.float32)
world[:,:2] = np.mgrid[0:w,0:h].T.reshape(-1,2)

worldPoints = []
imagePoints = []

images = glob.glob('pictures/*.png')

mode1 = 'init'
mode2 = 'init'
mode3 = 'init'

def mode1_choose(event , x , y , flags , param):
	global mode1
	if event == cv2.EVENT_LBUTTONDOWN:
		mode1 = 'stop'
def mode2_choose(event , x , y , flags , param):
	global mode2
	if event == cv2.EVENT_LBUTTONDOWN:
		mode2 = 'stop'


print images
for fname in images:
	img = cv2.imread(fname)
	gray = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
	ret , corners = cv2.findChessboardCorners(gray,(w,h),None)
 
	if ret == True:
		corners2 = cv2.cornerSubPix(gray,corners ,(11,11),(-1,-1),criteria)
		worldPoints.append(world)
		imagePoints.append(corners2)

		cv2.drawChessboardCorners(img ,(w,h) ,corners2 ,ret)
		cv2.imshow('findCorners',img)
		cv2.waitKey(300)

		ret ,mtx ,dist ,rvecs ,tvecs = cv2.calibrateCamera(worldPoints , imagePoints,
			gray.shape[::-1], None, None)
		print 'Interial Calibration Done ~ '
		h2,w2 = img.shape[:2]
		newCameramtx ,roi = cv2.getOptimalNewCameraMatrix(mtx,dist,(w,h), 0, (w2,h2))
		dst = cv2.undistort(gray ,mtx ,dist ,None ,newCameramtx)
		cv2.namedWindow('undistorting')
		cv2.imshow('undistorting' , dst)
		cv2.waitKey(300)

		total_error = 0
		for i in xrange(len(worldPoints)):
			s2 , ret = cv2.projectPoints(worldPoints[i] ,rvecs[i] ,tvecs[i] ,mtx ,dist)
			error = cv2.norm(imagePoints[i] ,s2 ,cv2.NORM_L2)/len(s2)
			total_error += error
		print 'total error: ',total_error/len(worldPoints)

print 'ALL DONE'

'''
filename_calc = '/home/cheney/LearnLog/Python/CameraCalibration/test.png'
imagecalc = cv2.imread(filename_calc)
h2,w2 = img2.shape[:2]
newCameramtx ,roi = cv2.getOptimalNewCameraMatrix(mtx,dist,(w,h), 0, (w2,h2))
dst = cv2.undistort(imagecalc ,mtx ,dist ,None ,newCameramtx)

cv2.imwrite('calibresult.png' , dst)

total_error = 0
for i in xrange(len(worldPoints)):
	s2 , ret = cv2.projectPoints(worldPoints[i] ,rvecs[i] ,mtc ,dist)
	error = cv2.norm(imagePoints[i] ,s2 ,cv2.NORM_L2)/len(s2)
	total_error += error
print 'total error: ',total_error/len(worldPoints)
'''