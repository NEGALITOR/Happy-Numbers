# Compiling
# python3 HappyNums.py

import math

def main():
  numDict = {}
  
  print("First Argument:", end = " ")
  numOne = int(input())
  print("Second Argument:", end = " ")
  numTwo = int(input())
  
  if numTwo < numOne:
    tmp = numOne
    numOne = numTwo
    numTwo = tmp   
  
  for num in range(numOne, numTwo):
    norm = [num*num]
    
    #Checks if value is happy or not and pops min norm value if dictionary is greater than 10
    if happy(num, norm):
      if len(numDict) > 9 and norm[0] > min(numDict):
       numDict.pop(min(numDict))
       numDict[norm[0]] = num
      else:
       numDict[norm[0]] = num
      
  #sorts and reverses dictionary
  numDict = dict(reversed(sorted(numDict.items())))
  
  if bool(numDict):
    for key, value in numDict.items():
      print(value)
  else:
    print("NOBODYS HAPPY!")

#Checks if happy by comparing to a set
def happy(n, norm): #Taken from Rosetta Code
  past = set()
  
  while n != 1:
    n = sum(int(i)**2 for i in str(n))
    norm[0]+=n*n
    
    if n in past:
        return False
    past.add(n)
  
  
  norm[0] = math.sqrt(norm[0]) 
  return True, norm
  

main();