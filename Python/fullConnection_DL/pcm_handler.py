# -*- coding:utf-8 -*-
import array
import os
from matplotlib import pyplot
import scipy.signal
import numpy


def findMaxN1N2(filepath = '/home/cheney/LearnLog/Python/fullConnection_DL/PCM_data/data1',
	 char = 'c0_', start_file_index = 1, round_time = 28):
	N1 = 0
	N2 = 0
	max_left_fu_file_index = 0
	index_in_S_left_fu = 0
	max_right_fu_file_index = 0 
	index_in_S_right_fu = 0

	for j in range(round_time):

		filename = filepath+'/'+ char +str(start_file_index) + '.pcm'
		file = open(filepath+'/'+ char +str(start_file_index) + '.pcm' ,'rb')
		base = 1 / (1<<15)
		shortArray = array.array('h')
		size = int(os.path.getsize(filename) / shortArray.itemsize)
		count = int(size/2)

		shortArray.fromfile(file , size)
		file.close()
		leftData = shortArray[::2]
		rightData = shortArray[1::2]

		f,t,Sxx = scipy.signal.stft(leftData,48e3, nperseg=4096, noverlap=4000 ,nfft=4096)
		s1 = abs(Sxx)
		s2 = s1[20:30,:]
		s_left_fu = s2[1:20,:] # 9*X
		if len(s_left_fu) != 9:
			print 'in file : '+'/'+char+str(start_file_index)+'\n'
			print "s_left_fu length is not 9 ,it's :%d",len(s_left_fu)
			return -1
		else:
			for m in range(9):
				n1 = len(s_left_fu[m])
				if n1 > N1:
					N1 = n1
					index_in_S_left_fu = m
					max_left_fu_file_index = j


		s_left_zheng = s2[30:,:]
		if len(s_left_zheng) != 0:
			print 'in file : '+'/'+char+str(start_file_index)+'\n'
			print "s_left_zheng length is not 0 ,it's :%d",len(s_left_zheng)
			return -1

		f,t,Sxx = scipy.signal.stft(rightData,48e3, nperseg=4096, noverlap=4000 ,nfft=4096)
		s1 = abs(Sxx)
		s2 = s1[20:30,:]
		s_right_fu = s2[1:20,:]
		if len(s_right_fu) != 9:
			print 'in file : '+'/'+char+str(start_file_index)+'\n'
			print "s_right_fu length is not 9 ,it's :%d",len(s_right_fu)
			return -1
		else:
			for m in range(9):
				n2 = len(s_right_fu[m])
				if n2 > N2:
					N2 = n2
					index_in_S_right_fu = m
					max_right_fu_file_index = j


		s_right_zheng = s2[30:,:]
		if len(s_right_zheng) != 0:
			print 'in file : '+'/'+char+str(start_file_index)+'\n'
			print "s_right_zheng length is not 0 ,it's :%d",len(s_right_zheng)
			return -1
		file.close()
		start_file_index += 1

	max_information_0 = [filepath,char,start_file_index]
	max_information_1 = [N1, N2, index_in_S_left_fu, index_in_S_right_fu, max_left_fu_file_index, max_right_fu_file_index]
	max_information = [max_information_0,max_information_1]

	return max_information


def Normalize_data(filepath = '/home/cheney/LearnLog/Python/fullConnection_DL/PCM_data/data1', char = 'c0_' ,
 start_file_index = 1,round_time = 28, N1 = 0 , N2 = 0):
	S = []
	L = []
	for j in range(round_time):
		# execute one pcm file.

		filename = filepath+'/'+char+str(start_file_index)+'.pcm'
		file = open(filename,'rb')
		base = 1 / (1<<15)
		shortArray = array.array('h')
		size = int(os.path.getsize(filename) / shortArray.itemsize)
		count = int(size/2)

		shortArray.fromfile(file , size)
		file.close()
		leftData = shortArray[::2]
		rightData = shortArray[1::2]

		f,t,Sxx = scipy.signal.stft(leftData,48e3, nperseg=4096, noverlap=4000 ,nfft=4096)
		s1 = abs(Sxx)
		s2 = s1[20:30,:]
		s_left_fu = s2[1:20,:] # 9*X
		if len(s_left_fu) != 9:
			print 'in file : '+'/'+char+str(start_file_index)+'\n'
			print "s_left_fu length is not 9 ,it's :%d",len(s_left_fu)
			return -1
		else:
			HELPM1 = []
			for m in range(9):
				n1 = len(s_left_fu[m])
				print 'm =',m
				print 'n1 = ',n1
				if n1 <= N1:
					helpM1 = s_left_fu[m].tolist()
					helpM1.extend(numpy.zeros((N1 - n1)))
					print 'helpM1 length is :',len(helpM1)
					HELPM1.append(helpM1)
					#print '                        s_left_fu'
					#print s_left_fu    9 * (N1+N2)
				if n1 > N1:
					print 'in file : '+'/'+char+str(start_file_index)+'\n'
					print 'When extend s_left_fu , lenth_Now > N1'
					return -1
			print 'len(HELPME1) = ',len(HELPM1)


		s_left_zheng = s2[30:,:]
		if len(s_left_zheng) != 0:
			print 'in file : '+'/'+char+str(start_file_index)+'\n'
			print "s_left_zheng length is not 0 ,it's :%d",len(s_left_zheng)
			return -1

		f,t,Sxx = scipy.signal.stft(rightData,48e3, nperseg=4096, noverlap=4000 ,nfft=4096)
		s1 = abs(Sxx)
		s2 = s1[20:30,:]
		s_right_fu = s2[1:20,:]
		if len(s_right_fu) != 9:
			print 'in file : '+'/'+char+str(start_file_index)+'\n'
			print "s_right_fu length is not 9 ,it's :%d",len(s_left_fu)
			return -1
		else:
			HELPM2 = []
			for m in range(9):
				n2 = len(s_right_fu[m])
				print 'm =',m
				print 'n1 = ',n2
				if n2  <= N2:
					helpM2 = s_right_fu[m].tolist()
					helpM2.extend(numpy.zeros((N2 - n2)))
					print 'helpM2 length is :',len(helpM2)
					HELPM2.append(helpM2)
					#print '                        s_right_fu'
					#print s_right_fu
				if n2 > N2:
					print 'in file : '+'/'+char+str(start_file_index)+'\n'
					print 'When extend s_right_fu , length_Now > N2'
					return -1

			print 'len(HELPM2) = ',len(HELPM2) # HELPM = 9*(N1+N2) , 2-D


		s_right_zheng = s2[30:,:]
		if len(s_right_zheng) != 0:
			print 'in file : '+'/'+char+str(start_file_index)+'\n'
			print "s_right_zheng length is not 0 ,it's :%d",len(s_right_zheng)
			return -1

		HELPM1 = numpy.array(HELPM1)
		HELPM1 = HELPM1.flatten()
		HELPM1 = HELPM1.tolist()


		HELPM2 = numpy.array(HELPM2)
		HELPM2 = HELPM2.flatten()
		HELPM2 = HELPM2.tolist()

		s_fu = HELPM1 + HELPM2 # 1 * [9*(N1+N2)]

		S.append(s_fu)

		print '--------file : '+'filepath/'+char+str(start_file_index)+' extended : DONE'
		file.close()
		start_file_index += 1

		if char == 'c0_':
			L.append([1.,0.,0.,0.,0.])
		elif char == 'c1_':
			L.append([1.,0.,0.,0.,0.])
		elif char == 'c2_':
			L.append([0.,1.,0.,0.,0.])
		elif char == 'c3_':
			L.append([0.,1.,0.,0.,0.])
		elif char == 'c4_':
			L.append([0.,0.,1.,0.,0.])
		elif char == 'c5_':
			L.append([0.,0.,0.,1.,0.])
		elif char == 'c6_':
			L.append([0.,0.,0.,1.,0.])
		elif char == 'c7_':
			L.append([0.,0.,0.,0.,1.])

	print 'file : '+'filepath/'+char+' extended : DONE'

	return S , L# 28 * (9 * (N1+N2))  : 2-D
				# 28 * [0,0,0,0,0]\

def Deal_testdata(filename, N1, N2):
	file = open(filename,'rb')
	base = 1 / (1<<15)
	shortArray = array.array('h')
	size = int(os.path.getsize(filename) / shortArray.itemsize)
	count = int(size/2)

	shortArray.fromfile(file , size)
	file.close()
	leftData = shortArray[::2]
	rightData = shortArray[1::2]

	f,t,Sxx = scipy.signal.stft(leftData,48e3, nperseg=4096, noverlap=4000 ,nfft=4096)
	s1 = abs(Sxx)
	s2 = s1[20:30,:]
	s_left_fu = s2[1:20,:] # 9*X
	if len(s_left_fu) != 9:
		print 'in file : '+'/'+char+str(start_file_index)+'\n'
		print "s_left_fu length is not 9 ,it's :%d",len(s_left_fu)
		return -1
	else:
		HELPM1 = []
		for m in range(9):
			n1 = len(s_left_fu[m])
			if n1 <= N1:
				helpM1 = s_left_fu[m].tolist()
				helpM1.extend(numpy.zeros((N1 - n1)))
				HELPM1.append(helpM1)
				#print '                        s_left_fu'
				#print s_left_fu    9 * (N1+N2)
			if n1 > N1:
				helpM1 = s_left_fu[m][:N1].tolist()
				HELPM1.append(helpM1)

	s_left_zheng = s2[30:,:]
	if len(s_left_zheng) != 0:
		print 'in file : '+'/'+char+str(start_file_index)+'\n'
		print "s_left_zheng length is not 0 ,it's :%d",len(s_left_zheng)
		return -1

	f,t,Sxx = scipy.signal.stft(rightData,48e3, nperseg=4096, noverlap=4000 ,nfft=4096)
	s1 = abs(Sxx)
	s2 = s1[20:30,:]
	s_right_fu = s2[1:20,:]
	if len(s_right_fu) != 9:
		print 'in file : '+'/'+char+str(start_file_index)+'\n'
		print "s_right_fu length is not 9 ,it's :%d",len(s_left_fu)
		return -1
	else:
		HELPM2 = []
		for m in range(9):
			n2 = len(s_right_fu[m])
			if n2  <= N2:
				helpM2 = s_right_fu[m].tolist()
				helpM2.extend(numpy.zeros((N2 - n2)))
				HELPM2.append(helpM2)
					#print '                        s_right_fu'
					#print s_right_fu
			if n2 > N2:
				helpM2 = s_right_fu[m][:N2].tolist()
				HELPM2.append(helpM2)


			print 'len(HELPM2) = ',len(HELPM2) # HELPM = 9*(N1+N2) , 2-D


		s_right_zheng = s2[30:,:]
		if len(s_right_zheng) != 0:
			print 'in file : '+'/'+char+str(start_file_index)+'\n'
			print "s_right_zheng length is not 0 ,it's :%d",len(s_right_zheng)
			return -1

		HELPM1 = numpy.array(HELPM1)
		HELPM1 = HELPM1.flatten()
		HELPM1 = HELPM1.tolist()

		HELPM2 = numpy.array(HELPM2)
		HELPM2 = HELPM2.flatten()
		HELPM2 = HELPM2.tolist()

		s_fu = HELPM1 + HELPM2 # 1 * [9*(N1+N2)]
		return s_fu



'''
M = findMaxN1N2('/home/cheney/LearnLog/Python/fullConnection_DL/PCM_data/pre_data/raw_train_data','c0_',1,28)
print 'N1 = %d' ,M[1][0]
print 'N2 = %d' ,M[1][1]
S, L = Normalize_data('/home/cheney/LearnLog/Python/fullConnection_DL/PCM_data/pre_data/raw_train_data' , 'c0_' , 1 , 28 , M[1][0] , M[1][1])
print 'size of S is :',len(S) ,'*',len(S[0])
print 'size of L is :',len(L) ,'*',len(L[0])
'''