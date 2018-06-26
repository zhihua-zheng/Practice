# Use the file name mbox-short.txt as the file name
fname = raw_input('Enter the file name: ')
try:
    fhand = open(fname)
except:
    print'File cannot be opened:', fname
    exit()

count = 0
all = 0
for line in fhand:
    if not line.startswith('X-DSPAM-Confidence:') :
        continue
    count = count + 1
    ipos = line.find(':')
    number = line[ipos+1:]
    number = float(number)
    all = all + number

ave = all/count
print "Average spam confidence:", ave
