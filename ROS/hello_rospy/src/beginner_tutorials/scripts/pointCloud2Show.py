#!/usr/bin/env python
# setled
from sensor_msgs.msg import PointCloud2,PointField,ChannelFloat32
from geometry_msgs.msg import Point32
from std_msgs.msg import Header
from sensor_msgs import point_cloud2
import pcl_ros

import rospy
import time
import csv
import math

def pointCloud2Show():
	rospy.init_node('point_cloud_publisher',anonymous = True)
	pub = rospy.Publisher('/cloud',PointCloud2,queue_size = 50)
	#rospy.init_node('point_cloud_publisher',anonymous = True)
	rate = rospy.Rate(10)
	clouds_old = csv.reader(open('/home/cheney/LearnLog/ROS/hello_rospy/src/beginner_tutorials/scripts/laser.csv','r'))
	clouds = []
	for cloud in clouds_old:
		cloud = map(float,cloud)
		clouds.append(cloud)
	num_points = len(clouds)

	while not rospy.is_shutdown():

		fields = []
		x = PointField()
		x.datatype = 7
		x.name = 'x'
		x.count = 1
		fields.append(x)

		y = PointField()
		y.datatype = 7
		y.name = 'y'
		y.count = 1
		fields.append(y)

		z = PointField()
		z.datatype = 7
		z.name = 'z'
		z.count = 1
		fields.append(z)

		inte = PointField()
		inte.datatype = 7
		inte.name = 'intensity'
		inte.count = 1
		fields.append(inte)

		points = []
		for i in range(num_points):
			alpha = (clouds[i][0]/180.0) * math.pi
			lamda = (clouds[i][1]/180.0) * math.pi
			distance = clouds[i][2]
			intensity = clouds[i][3]
			#not for sure if coordinate is right
			zz = distance * math.sin(lamda)
			yy = distance * math.cos(lamda) * math.cos(alpha)
			xx = distance * math.cos(lamda) * math.cos(alpha)
			points.append([xx,yy,zz,intensity])
			

		header = Header()
		header.stamp = rospy.Time.now()
		header.frame_id = 'sensor_frame'
		cloud2 = point_cloud2.create_cloud(header , fields , points)
		pub.publish(cloud2)
		rate.sleep()
		print 'done'

if __name__ == '__main__':
	try:
		pointCloud2Show()
	except rospy.ROSInterruptException:
		pass


