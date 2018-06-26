fname = raw_input('Enter file name: ')
try:
    fhand = open(fname)
except:
    print 'File cannot be opened:', fname
    exit()

lst = list()
for line in fhand:
    words = line.split()
    for word in words:
        if word not in lst:
            lst.append(word)

lst.sort()
print lst
