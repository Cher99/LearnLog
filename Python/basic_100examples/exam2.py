profile = 0
bonus =0

profile = int(raw_input('Please input your gain:\n'))
if profile <= 100000 :
	bonus = profile * 0.1
elif (profile > 100000)and(profile <= 200000):
	bonus = 10000 + (profile - 100000) *0.075
elif (profile > 200000)and(profile <= 400000):
	bonus = 10000 + 7500 + (profile -200000)*0.05
print 'bonus :',bonus
