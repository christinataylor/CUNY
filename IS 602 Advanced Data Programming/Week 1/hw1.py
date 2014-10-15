#1. fill in this function
#   it takes a list for input and return a sorted version
#   do this with a loop, don't use the built in list functions
def sortwithloops(L):
    while True:
        count = 0
        for n in range(0, len(L)-1):
            if L[n] > L[n+1]:
                L[n], L[n+1] = L[n+1], L[n]
            else:
                count = count + 1

        if count == len(L) - 1:
            break

    return L #return a value

	
#2. fill in this function
#   it takes a list for input and return a sorted version
#   do this with the built in list functions, don't us a loop
def sortwithoutloops(L): 
    return sorted(L) #return a value

#3. fill in this function
#   it takes a list for input and a value to search for
#	it returns true if the value is in the list, otherwise false
#   do this with a loop, don't use the built in list functions
def searchwithloops(L, v):
    for n in L:
        if n == v:
            truthvalue = True
            break
        else:
            truthvalue = False
    return truthvalue  #return a value

#4. fill in this function
#   it takes a list for input and a value to search for
#	it returns true if the value is in the list, otherwise false
#   do this with the built in list functions, don't use a loop
def searchwithoutloops(L, v):
    return v in L

if __name__ == "__main__":	
    L = [5,3,6,3,13,5,6]

    print sortwithloops(L) # [3, 3, 5, 5, 6, 6, 13]
    print sortwithoutloops(L) # [3, 3, 5, 5, 6, 6, 13]
    print searchwithloops(L, 5) #true
    print searchwithloops(L, 11) #false
    print searchwithoutloops(L, 5) #true
    print searchwithoutloops(L, 11) #false
