/*
  * Compiling
  * go run HappyNums.go
*/

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


/*
  * Initializes the normSorted array of size 10
  * Switches numOne and numTwo if numOne is bigger than numTwoi
  * Runs a for-loop where it iterates from numOne to numTwo to determine if a value is a Happy Number or not
  * Creates a structNum given the norm and happy number when it returns true from checkHappy
  * Fills array with happy numbers till size 10. If size exceeds 10, find lowest norm in array and replace it with searchMin
  * Sorts and Prints at the end
*/
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


/*
  * Checks whether a value passed through is Happy or Unhappy
  * Checks if a value is 1 or 4 every passthrough to determine if happy or unhappy
  * Goes through each digit and adds it to the sum after being squared and reassigns it back to num
  * Calculates norm of value after determining if happy or not
  * Returns true if num == 1 and false if num == 4
*/
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

//Searches through array for the lowest norm and returns the location of the array
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

//Insertion sort through norms from greatest to least
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

//Prints Nums
func printNums(normSorted[10] structNum) {
  for i := 0; i < len(normSorted); i++ {
    if normSorted[i].num != 0 {
      fmt.Println(normSorted[i].num)
    }
  }
}


