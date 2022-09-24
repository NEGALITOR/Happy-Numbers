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
    #print("Num: " + str(num))
    norm = [num*num]
    
    #print("Norm Initial: " + str(norm[0]))
    if happy(num, norm):
      if len(numDict) > 9 and norm[0] > min(numDict):
       numDict.pop(min(numDict))
       numDict[norm[0]] = num
      else:
       numDict[norm[0]] = num
      
  
  numDict = dict(reversed(sorted(numDict.items())))
  #print(numDict)
  
  if bool(numDict):
    for key, value in numDict.items():
      print(value)
  else:
    print("NOBODYS HAPPY!")

def happy(n, norm): #Taken from Rosetta Code
  past = set()
  
  while n != 1:
    n = sum(int(i)**2 for i in str(n))
    #print(n)
    norm[0]+=n*n
    
    if n in past:
        return False
    past.add(n)
  
  
  norm[0] = math.sqrt(norm[0]) 
  #print("Final Norm: " + str(norm[0]))
  return True, norm
  

main();