'compute accuracy from VW validation and predictions file'

import sys, csv, math

test_file = sys.argv[1]
predictions_file = sys.argv[2]

test_reader = csv.reader( open( test_file ), delimiter = " " )
p_reader = csv.reader( open( predictions_file ), delimiter = "\n" )

n = 0
t = 0

for p_line in p_reader:
	test_line = test_reader.next()
	n += 1
	
	p = int( float( p_line[0] ))
	y = int( test_line[0] )
	if y == p:
		t += 1
	else:
		pass
		# print ( "%s / %s\t\t%s / %s" % ( y, p, t, n ))
	
acc = 1.0 * t / n

#print "%s %s" % ( test_file, predictions_file )
print "accuracy: %s" % ( acc )
print
