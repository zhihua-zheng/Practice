fname = input('Enter file name: ')
if len(fname) < 1 : fname = "mbox-short.txt"

try:
    fhand = open(fname)
except:
    print ('File cannot be opened:', fname)
    exit()

counts = dict()
print ('Counting...')

for line in fhand :
    if not line.startswith('From ') :
        continue
    words = line.split()
    time = words[5]
    hours = time.split(':')
    hour = hours[0]
    counts[hour] = counts.get(hour, 0) + 1

print ('sorted by hour')
print (sorted(counts.items(), reverse = True))

print ('sorted by counts') 
lis = sorted([(v, k) for k, v in counts.items()], reverse = True)
for v, k in lis :
    print (k, v)
