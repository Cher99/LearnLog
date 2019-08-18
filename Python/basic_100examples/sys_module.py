# some notes about sys module in py

print 'Choose the function you want to test:'
print '	1: sys.argv '
print ' 2: sys.path '
print ' 3: sys.exit '
print ' 4: sys.modules '
print ' 5: sys.getdefaultencoding / sys.setdefaultencodoing / sys.getfilesystemencoding'
print ' 6: sys.stdin / sys.stdout / sys.stder '
print ' 7: sys.platform '
print 'Type q for quit.'

import sys
while i != int('q'):
	i = int(raw_input('your choice :\n'))
	if i == 1:
		print 'sys.argv实现从程序外部向程序传递参数，sys.argv变量是一个包含了命令行参\n'
		print '数的字符串列表，利用命令行向程序提供参数，其中脚本名称为列表第一个参数\n'
		print ' The command line arguments are :'
		for j in sys.argv:
			print j
	if i == 2:
		print 'sys.path变量存储PYTHONPATH路径‘
		print 'The PYTHONPATH is:'.sys.path,'\n'
	if i == 3:
		print 'More notes about exception in Python : ../exceptionPY.txt'
		print 'sys.exit(0) means normal'
		print 'sys.exit(value) means abnormal and generate SystemExit == value'
		try:
			sys.exit(90)
		except SystemExit as value:
			print value
			sys.exit(0)
	if i == 4:
		print 'MODULES HAVE IMPORTED : sys.modules.keys() = \n'
		print sys.modules.keys()
		print "MODULES'S PATH:"
		print sys.modules.values()
	if i == 5:
		print 'to get system encoding information:'
		print sys.setdefaultencoding()
	if i == 6:
		name = sys.stdin.readline()[:-1]		
		print name
	if i == 7:
		print 'Are you kidding ???'
		print sys.platform()
