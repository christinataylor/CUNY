#pseudocode



#try:
#	x=5/0
#	fh = open("testfile", "r")
#	print "File exists"
#
#except ZeroDivisionError:
#	print"Divide by zero found"
#
#except IOError:
#	print "file not found"
#
#except: 
#	print "there was a problem"



#   buying       v-high, high, med, low	      vhigh, high, med, low
#   maint        v-high, high, med, low       vhigh, high, med, low
#  doors        2, 3, 4, 5-more				  2, 3, 4, 5more
#  persons      2, 4, more       			  2, 4, more             
#  lug_boot     small, med, big               small, med, big
# safety       low, med, high                 low, med, high

#import os

#fo = open("foo.txt", "r")

#content = fo.read(16) #number of bits

#print "Name of file ", fo.name

#print "Mode ", fo.mode

#print "is closed :", fo.closed


#fo.write("\nThis is from my program.\n")

#fo.close()
#print "is closed :", fo.closed

#second argument can be r, w, or a. read, writ, or append.


#os.rename("foo.txt", "bar.txt")

#os.rename("bar.txt", "foo.txt")

#os.remove("foo.txt") # why isn't this working.

#os.mkdir("newdir")


datacheck = True

for row in carfax:
	if not row[6] in ["acc", "unacc"]:
		datacheck = False
		break

