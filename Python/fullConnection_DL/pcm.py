# -*- coding:utf-8 -*-
import array
import os
from matplotlib import pyplot
import scipy.signal

class pcm(object):
	def __init__(self , filepath, train_data,train_label, N1 , N2):
		self.filepath = '/home/cheney/LearnLog/Python/fullConnection_DL/PCM_data/data1'
		self.train_data = []
		self.train_label = []
		self.N1 = 0
		self.N2 = 0

	def findMaxN1N2(self, filepath = '/home/cheney/LearnLog/Python/fullConnection_DL/PCM_data/data1',
	 char = 'c0_', start_file_index = 1, round_time = 28):
		N1 = 0
		N2 = 0
		max_left_fu_file_index = 0
		index_in_S_left_fu = 0
		max_right_fu_file_index = 0 
		index_in_S_right_fu = 0

		for j in range(round_time):

			fr = open(filepath+'/'+ char +str(start_file_index) + '.pcm' ,'rb')
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
			fr.close()
			start_file_index += 1

		max_information_0 = [filepath,char,start_file_index]
		max_information_1 = [N1, N2, index_in_S_left_fu, index_in_S_right_fu, max_left_fu_file_index, max_right_fu_file_index]
		max_information = [max_information_0,max_information_1]

		return max_information


	def Normalize_data(self ,filepath = '/home/cheney/LearnLog/Python/fullConnection_DL/PCM_data/data1', char = 'c0_' ,
	 start_file_index = 1,round_time = 28, N1 = 0 , N2 = 0):
		S = []
		L = []
		for j in round_time:
			# execute one pcm file.

			fr = open(filepath+'/'+char+str(start_file_index)+'.pcm','rb')
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
					if n1 < N1:
						s_left_fu.extend(numpy.zeros((N1 - n1)))
					if n1 > N1:
						print 'in file : '+'/'+char+str(start_file_index)+'\n'
						print 'When extend s_left_fu , lenth_Now > N1'
						return -1


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
				for m in range(9):
					n2 = len(s_right_fu[m])
					if n2 < N2:
						s_right_fu.extend(numpy.zeros((N2 - n2)))
					if n2 > N2:
						print 'in file : '+'/'+char+str(start_file_index)+'\n'
						print 'When extend s_right_fu , lenth_Now > N2'
						return -1


			s_right_zheng = s2[30:,:]
			if len(s_right_zheng) != 0:
				print 'in file : '+'/'+char+str(start_file_index)+'\n'
				print "s_right_zheng length is not 0 ,it's :%d",len(s_right_zheng)
				return -1
			s_left_fu = s_left_fu.flatten()
			s_right_fu = s_right_fu.flatten()
			s_fu = s_left_fu.extend(s_right_fu) # 1 * [9*(N1+N2)]
			S.append(s_fu)
			s_zheng = s_left_zheng.extend(s_right_zheng)

			print '--------file : '+'filepath/'+char+str(start_file_index)+' extended : DONE'
			fr.close()
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
		print 'size of ' + 'c0_S : '+ len(S) + '*' +len(S[0])

		return S , L# 28 * (9 * (N1+N2))  : 2-D
				# 28 * [0,0,0,0,0]\



M = findMaxN1N2('/home/cheney/LearnLog/Python/fullConnection_DL/PCM_data/pre_data/raw_train_data','c0_',1,28)
print  'N1 = ' + M[1][0] + ', N2 = ' + M[1][1]
S, L = Normalize_data('/home/cheney/LearnLog/Python/fullConnection_DL/PCM_data/pre_data/raw_train_data' , 'c0_' , 1 , 28 , M[1][0] , M[1][1])




'''
	def set_train(self):

		M = []
		M.append(findMaxN1N2('/home/cheney/LearnLog/Python/fullConnection_DL/PCM_data/pre_data/raw_train_data',
			'c0_',1,28))
		M.append(findMaxN1N2('/home/cheney/LearnLog/Python/fullConnection_DL/PCM_data/pre_data/raw_train_data',
			'c1_',1,28))
		M.append(findMaxN1N2('/home/cheney/LearnLog/Python/fullConnection_DL/PCM_data/pre_data/raw_train_data',
			'c2_',1,28))
		M.append(findMaxN1N2('/home/cheney/LearnLog/Python/fullConnection_DL/PCM_data/pre_data/raw_train_data',
			'c3_',1,28))
		M.append(findMaxN1N2('/home/cheney/LearnLog/Python/fullConnection_DL/PCM_data/pre_data/raw_train_data',
			'c4_',1,56))
		M.append(findMaxN1N2('/home/cheney/LearnLog/Python/fullConnection_DL/PCM_data/pre_data/raw_train_data',
			'c5_',1,28))
		M.append(findMaxN1N2('/home/cheney/LearnLog/Python/fullConnection_DL/PCM_data/pre_data/raw_train_data',
			'c6_',1,28))
		M.append(findMaxN1N2('/home/cheney/LearnLog/Python/fullConnection_DL/PCM_data/pre_data/raw_train_data',
			'c7_',1,56))

		max_n1 = 0
		max_n2 = 0
		for i in range(8):
			if M[i][1][0] > max_n1:
				max_n1 = M[i][2][0]
			if M[i][1][1] > max_n2:
				max_n2 = M[i][2][1]
		self.N1 = max_n1
		self.N2 = max_n2

		C0 , L0 = Normalize_data('/home/cheney/LearnLog/Python/fullConnection_DL/PCM_data/pre_data/raw_train_data',
			'c0_', 1, 28, max_n1, max_n2)
		C1 ,L1= Normalize_data('/home/cheney/LearnLog/Python/fullConnection_DL/PCM_data/pre_data/raw_train_data',
			'c1_', 1, 28, max_n1, max_n2)
		C2 ,L2= Normalize_data('/home/cheney/LearnLog/Python/fullConnection_DL/PCM_data/pre_data/raw_train_data',
			'c2_', 1, 28, max_n1, max_n2)
		C3 ,L3= Normalize_data('/home/cheney/LearnLog/Python/fullConnection_DL/PCM_data/pre_data/raw_train_data',
			'c3_', 1, 28, max_n1, max_n2)	
		C4 ,L4= Normalize_data('/home/cheney/LearnLog/Python/fullConnection_DL/PCM_data/pre_data/raw_train_data',
			'c4_', 1, 56, max_n1, max_n2)
		C5 ,L5= Normalize_data('/home/cheney/LearnLog/Python/fullConnection_DL/PCM_data/pre_data/raw_train_data',
			'c5_', 1, 28, max_n1, max_n2)
		C6 ,L6= Normalize_data('/home/cheney/LearnLog/Python/fullConnection_DL/PCM_data/pre_data/raw_train_data',
			'c6_', 1, 28, max_n1, max_n2)
		C7 ,L7= Normalize_data('/home/cheney/LearnLog/Python/fullConnection_DL/PCM_data/pre_data/raw_train_data',
			'c7_', 1, 56, max_n1, max_n2)	

		# each_train_data costs: 56 * {9 * (N1+N2)} 2d

		self.train_data = C0+C1+C2+C3+C4+C5+C6+C7 # (56*8) * (9*(N1+N2))

		self.train_label = L0+L1+L2+L3+L4+L5+L6+L7
		#NOW DATA is the same as   mnist.images , mnist.label
	
'''