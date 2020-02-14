import sys
sys.path.remove('/home/cheney/LearnLog/ROS/hello_rospy/devel/lib/python2.7/dist-packages')
sys.path.remove('/opt/ros/kinetic/lib/python2.7/dist-packages')

import cv2
import numpy as np

pic = cv2.imread("background.jpg")
pic2=pic[40:260,40:260]
cv2.imwrite("background2.jpg",pic2)