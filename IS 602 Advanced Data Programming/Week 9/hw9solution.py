import pandas as pd

inFile = open('.\epa-http.txt', 'r')
outFile = open('.\epa-http.fix.txt', 'w')
for line in inFile:
    outFile.write(line.replace('alt=" ', ' ').replace(' -', ' 0'))
inFile.close()
outFile.close()

df = pd.read_csv('.\epa-http.fix.txt', sep='\s+', header=None)

print "Most Requests:" + df[0].value_counts().idxmax()
print "Most Bytes: " + df.groupby(0).sum()[4].idxmax() + " (" + str(df.groupby(0).sum()[4].max()) + ")"
print "Busiest Hour: " + df.groupby(df[1].str[4:6]).sum()[4].idxmax()
print "Popular .gif: " + df[df[2].str.contains("gif") & df[2].str.contains("GET")][2].value_counts().idxmax().split(' ')[1]
print "HTTP codes: " + ', '.join(map(str, df[3].unique().tolist())[1:])
