package main

import (
  "fmt"
  "math"
)
type structNum struct{
  num int
  norm float64
}

func main() {

  var numOne int
  var numTwo int
  fmt.Print("First Argument: ")
  fmt.Scanln(&numOne)
  fmt.Print("Second Argument: ")
  fmt.Scanln(&numTwo)
  
  isHappy(numOne, numTwo);
}

func isHappy(numOne int, numTwo int) {

  var normSorted[10] structNum
  var rNorm float64
  var tmp int
  var j int = 0
  var location int = 0

  if numOne > numTwo {
    tmp = numOne;
    numOne = numTwo;
    numTwo = tmp;
  }
  
  for i := numOne; i <= numTwo; i++ {
    rNorm = float64(i*i)
    
    if checkHappy(i, &rNorm) {
      //fmt.Printf("%d | %f\n", i, rNorm)
      nSt := structNum{num: i, norm: rNorm}
      
      if j < 10 {
        normSorted[j] = nSt
        j++
      } else {
        location = searchMin(normSorted)
        
        if j >= 10 && rNorm > normSorted[location].norm {
          normSorted[location] = nSt
        }
      }
    }
  }
  
  normSorted = sort(normSorted)
  
  if (normSorted[0].num == 0 && normSorted[0].norm == 0) {
    fmt.Println("NOBODYS HAPPY!")
  } else {
    printNums(normSorted)
  }
  
  
}

func checkHappy(num int, rNorm *float64) bool {
  var digit int
  var sum int
  
  for num != 1 {
  
    if num == 4 {
      return false
    }
    
    for num != 0 {
      digit = num % 10
      sum += (digit*digit)
      num /= 10
    }
    
    num = sum
    *rNorm += float64(num*num)
    sum = 0
  }
  *rNorm = math.Sqrt(*rNorm)
  return true
  
}

func searchMin(normSorted[10] structNum) int {

  var minSt structNum = normSorted[0]
  var minNorm float64 = 0
  var location = 0
  
  for i := 0; i < len(normSorted); i++ {
    minNorm = math.Min(minSt.norm, normSorted[i].norm)
    
    if minNorm == normSorted[i].norm {
      minSt = normSorted[i]
      location = i
    }
  }
  return location
}

func sort(normSorted[10] structNum) [10]structNum {
  var maxim structNum
  
  for i := 0; i < len(normSorted); i++ {
    var indx int = i
    
    for j := i; j < len(normSorted); j++ {
      if normSorted[j].norm > normSorted[indx].norm {
        indx = j
      }
    }
    maxim = normSorted[indx]
    normSorted[indx] = normSorted[i]
    normSorted[i] = maxim
  }
  return normSorted
}

func printNums(normSorted[10] structNum) {
  for i := 0; i < len(normSorted); i++ {
    if normSorted[i].num != 0 {
      fmt.Println(normSorted[i].num)
    }
  }
}


