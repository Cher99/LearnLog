#!/usr/bin/env/python
# -*- coding: UTF-8 -*-

from __future__ import division 
import tensorflow as tf
import matplotlib.pyplot as plt
import numpy as np

from tensorflow.examples.tutorials.mnist import input_data
mnist = input_data.read_data_sets("MNIST_data/" , one_hot = True)

def set_train_data(filepath):
	M = []
	M.append(findMaxN1N2(filepath,'c0_',1,28))
	M.append(findMaxN1N2(filepath,'c1_',1,28))
	M.append(findMaxN1N2(filepath,'c2_',1,28))
	M.append(findMaxN1N2(filepath,'c3_',1,28))
	M.append(findMaxN1N2(filepath,'c4_',1,56))
	M.append(findMaxN1N2(filepath,'c5_',1,28))
	M.append(findMaxN1N2(filepath,'c6_',1,28))
	M.append(findMaxN1N2(filepath,'c7_',1,56))

	N1 = 0
	N2 = 0
	for i in range(8):
		if M[i][1][0] > N1:
			N1 = M[i][2][0]
		if M[i][1][1] > N2:
			N2 = M[i][2][1]

	C0 ,L0= Normalize_data(filepath, 'c0_', 1, 28, N1, N2)
	C1 ,L1= Normalize_data(filepath, 'c1_', 1, 28, N1, N2)
	C2 ,L2= Normalize_data(filepath, 'c2_', 1, 28, N1, N2)
	C3 ,L3= Normalize_data(filepath, 'c3_', 1, 28, N1, N2)	
	C4 ,L4= Normalize_data(filepath, 'c4_', 1, 56, N1, N2)
	C5 ,L5= Normalize_data(filepath, 'c5_', 1, 28, N1, N2)
	C6 ,L6= Normalize_data(filepath, 'c6_', 1, 28, N1, N2)
	C7 ,L7= Normalize_data(filepath, 'c7_', 1, 56, N1, N2)

	train_data = C0+C1+C2+C3+C4+C5+C6+C7
	train_label = L0+L1+L2+L3+L4+L5+L6+L7

	return train_data,train_label,N1,N2


filepath = '/home/cheney/LearnLog/Python/fullConnection_DL/PCM_data/pre_data/raw_train_data'
train_data ,train_label,N1 , N2= set_train_data(filepath)


learning_rate = 0.001
training_iters = 8
batch_size = 128
display_step = 1

n_input = 9*(N1+N2)
n_classes = 5
dropout = 0.85

x = tf.placeholder(tf.float64 , [None,n_input])
y = tf.placeholder(tf.float64 , [None, n_classes])
keep_prob = tf.placeholder(tf.float64)

def conv2d( x, W, b, striders = 1):
	# calculate a = Wx + b
	x = tf.nn.conv2d(x ,W ,strides = [1,striders , striders ,1], padding = 'SAME')
	x = tf.nn.bias_add(x, b)
	return tf.nn.relu(x)

def maxpool2d(x, k=2):
	return tf.nn.max_pool(x,ksize = [1, k, k, 1],strides= [1, k, k, 1],padding = 'SAME')

def conv_net(x, weights , biases , dropout):
	x = tf.reshape(x, shape = [-1, 9, -1, 1])

	conv1 = conv2d(x,weights['wc1'],biases['bc1'])
	conv1 = maxpool2d(conv1 , k = 2)
	conv2 = conv2d(conv1,weights['wc2'],biases['bc2'])
	con2 = maxpool2d(conv2, k = 2)

	fc1 = tf.reshape(conv2, [-1,weights['wd1'].get_shape().as_list()[0]])
	fc1 = tf.add(tf.matmul(fc1 , weights['wd1']) , biases['bd1'])
	fc1 = tf.nn.relu(fc1)

	fc1 = tf.nn.dropout(fc1,dropout)
	out = tf.add(tf.matmul(fc1,weights['out']) , biases['out'])

	return out
'''
	upper_layer is 64 depth now,one image 28*28
	one pixel costs uint 8 = 2 byte = 8 bit
	if your computer handles 32 bit everytime,total nerve cells in one map is 14*14
	if your computer handles 64 bit everytime ,total nervel cells in one image is 7*7
	
	'''
weights ={
	'wc1' : tf.Variable(tf.random_normal([3,3,1,64])),
	'wc2' : tf.Variable(tf.random_normal([3,3,64,128])),
	'wd1' : tf.Variable(tf.random_normal([9*(N1+N2)*128, 1024])),
	'out' : tf.Variable(tf.random_normal([1024,n_classes])),
}
biases = {
	'bc1' : tf.Variable(tf.random_normal([64])),
	'bc2' : tf.Variable(tf.random_normal([128])),
	'bd1' : tf.Variable(tf.random_normal([1024])),
	'out' : tf.Variable(tf.random_normal([n_classes])),
}

pred = conv_net(x,weights,biases,keep_prob) #[512,10]

cost = tf.reduce_mean(tf.nn.softmax_cross_entropy_with_logits(logits=pred , labels = y))
optimizer = tf.train.AdamOptimizer(learning_rate = learning_rate).minimize(cost)
correct_prediction = tf.equal(tf.argmax(pred ,1), tf.argmax(y,1))
accuracy = tf.reduce_mean(tf.cast(correct_prediction,tf.float64))
init = tf.global_variables_initializer()

train_loss = []
train_acc = []
test_acc = []
with tf.Session() as sess:
	sess.run(init)
	step = 1
	while step <= training_iters :
		batch_x = train_data[step : (step+27)]
		batch_y = train_label[step : (step+27)]
		sess.run(optimizer, feed_dict={x:batch_x , y:batch_y,
			keep_prob : dropout})
		if step % display_step == 0 :
			loss_train , acc_train = sess.run([cost,accuracy],
				feed_dict = {x:batch_x,y:batch_y,keep_prob:1.})
			print 'Iter' + str(step) + ', Minibatch Loss= ' + '{:.2f}'.format(loss_train) + ', Trainining Accuracy = ' + \
				'{:.2f}'.format(acc_train)
			'''acc_test = sess.run(accuracy , feed_dict ={x:mnist.test.images,y: mnist.test.labels,keep_prob: 1.})
												print 'Testing Accuracy:' + '{:.2f}'.format(acc_train)
												train_loss.append(loss_train)
												train_acc.append(acc_train)
												test_acc.append(acc_test)'''
		step += 1


'''eval_indices = range(0, training_iters, display_step)
plt.plot(eval_indices , train_loss , 'k-')
plt.title('Softmax Loss per iteration')
plt.xlabel('Iteration')
plt.ylabel('Softmax Loss')
plt.show()

plt.plot(eval_indices, train_acc, 'k-', label='Train Set Accuracy')
plt.plot(eval_indices, test_acc, 'r--', label='Test Set Accuracy')
plt.title('Train and Test Accuracy')
ply.xlabel('Generation')
plt.ylabel('Accuracy')
plt.legend(loc='lower right')
plt.show()'''
