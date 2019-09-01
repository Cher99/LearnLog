# -*- coding:utf-8 -*-

import array
import os
from matplotlib import pyplot
import scipy.signal

filename = '/home/cheney/LearnLog/Python/fullConnection_DL/PCM_data/data1/c0_210.pcm'
file = open(filename , 'rb')
base = 1 / (1<<15)

shortArray = array.array('h')
size = int(os.path.getsize(filename) / shortArray.itemsize)
count = int(size/2)

shortArray.fromfile(file , size)
file.close()
leftData = shortArray[::2]
rightData = shortArray[1::2]

# to show pcm data in frequency zone.
def showPCM(leftData,rightData,start = 0,end = 5000):
	fig = pyplot.figure(1)

	pyplot.subplot(211)
	pyplot.title('pcm left data [{0}-{1} max[{2}]]'.format(start, end, count))
	pyplot.plot(range(start,end),leftData[start:end])

	pyplot.subplot(212)
	pyplot.title('pcm right data [{0}-{1} max[{2}]]'.format(start, end, count))
	pyplot.plot(range(start,end),rightData[start:end])

	pyplot.show()




#showPCM(leftData,rightData,0,count)

# x,window,noverlap,nfft,fs

N = 4096
window = N
noverlap = 4000
nfft = N
fs = 48e3

f,t,Sxx = scipy.signal.stft(leftData,fs, nperseg = window, noverlap=noverlap ,nfft=nfft)
s1=abs(Sxx)
s2=s1[1761:1817,:];
s1_fu=s2[1:20,:];
s1_zheng=s2[30:,:];
s1_total=[s1_fu,s1_zheng];




print '    ----------------s1_total[0]-length------- : '
print len(s1_total[0])
print '    s1_total[0] is : '
print s1_total[0]
print '+++++++++++++++++++++++++++++++++++'
print ' '
print 's1_total[0][0] length'
print len(s1_total[0][0])
print 's1_total[0][1] length'
print len(s1_total[0][1])
print ' '
print '+++++++++++++++++++++++++++++++++++'
print '    -----------------s1_total[1]-length------ : '
print len(s1_total[1])
print '    s1_total[1] is : '
print s1_total[1]



print 'depth : = ' 
print type(s1_total[0][0][0])


file.close()