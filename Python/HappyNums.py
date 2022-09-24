import math

def main():
  numDict = {}
  
  print("First Argument:", end = " ")
  numOne = int(input())
  print("Second Argument:", end = " ")
  numTwo = int(input())
  
  
  for num in range(numOne, numTwo):
    norm = [0]
    if happy(num, norm):
      numDict[norm[0]] = num
  
  numDict = dict(reversed(sorted(numDict.items())))
  
  if bool(numDict):
    for key, value in numDict.items():
      print(value)
  else:
    print("NOBODYS HAPPY!")

def happy(n, norm): #Taken from Rosetta Code
  past = set()
  
  while n != 1:
    n = sum(int(i)**2 for i in str(n))
    norm[0]+=n
    
    if n in past:
        return False
    past.add(n)
  
  norm[0] = math.sqrt(norm[0]) 
  return True, norm
  

main();