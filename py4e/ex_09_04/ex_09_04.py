fname = raw_input("Enter file name:")
if len(fname) < 1 : fname = "mbox-short.txt"

try:
    fhand = open(fname)
except:
    print 'File cannot be opened:', fname
    exit()

counts = dict()
print 'Counting...'
for line in fhand :
    if not line.startswith('From '):
        continue
    words = line.split()
    sender = words[1]
    counts[sender] = counts.get(sender, 0) + 1

bigCount = None
bigSender = None
for sender, count in counts.items() :
    if bigCount is None or count > bigCount :
        bigSender = sender
        bigCount = count

print bigSender, bigCount
