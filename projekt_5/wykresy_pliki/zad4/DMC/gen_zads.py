

import sys

it = int(sys.argv[1])
eit = int(sys.argv[2])


beg = float(sys.argv[3])
end = float(sys.argv[4])

off = int(sys.argv[5])

for i in range(off,it):
	print str(i)+"  "+str(beg)

for i in range(it,eit+1):
	print str(i)+"  "+str(end)
