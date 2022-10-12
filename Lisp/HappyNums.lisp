#!/usr/bin/sbcl --script

#|----------------------------------------------------------------------------------------------------------------------------------
# Compiling
# chmod u+x HappyNums.lisp
# ./HappyNums.lisp
----------------------------------------------------------------------------------------------------------------------------------|#

(defstruct structNum
  num
  norm
)

#|----------------------------------------------------------------------------------------------------------------------------------
# Print all nums in array
----------------------------------------------------------------------------------------------------------------------------------|#
(defun printNums(normSorted j)
  (loop for i from 0 to (- j 1) by 1 do
    (print (structNum-num (aref normSorted i)))
  )
)

#|----------------------------------------------------------------------------------------------------------------------------------
# Insertion sort through norms from greatest to least
----------------------------------------------------------------------------------------------------------------------------------|#
(defun numSort(normSorted j)

  (let (indx)
    (loop for i from 0 to (- j 1) by 1 do
      (setf indx i)
      (loop for j from i to (- j 1) by 1 do
        (if (> (structNum-norm (aref normSorted j)) (structNum-norm (aref normSorted indx)))
          (setf indx j)
        )
      )
      (rotatef (aref normSorted i) (aref normSorted indx))
    )
  )
  
)

#|----------------------------------------------------------------------------------------------------------------------------------
# Searches through array for the lowest norm and returns the location of the array
----------------------------------------------------------------------------------------------------------------------------------|#
(defun searchMin(normSorted)

  (let ((count 0) minNorm location minSt)
    (setf minSt (aref normSorted 0))
    
    (loop for i across normSorted do
      
      (setf minNorm (min (structNum-norm minSt) (structNum-norm i)))
      
      (if (= minNorm (structNum-norm i))
        (progn
          (setf minSt i)
          (setf location count)
        )
      )
      (setf count (+ count 1))
    )
    (return-from searchMin location)
  )

  
)

#|----------------------------------------------------------------------------------------------------------------------------------
# Checks whether a value passed through is Happy or Unhappy
# Checks if a value is 1 or 4 every passthrough to determine if happy or unhappy
# Goes through each digit and adds it to the sum after being squared and reassigns it back to num
# Calculates norm of value after determining if happy or not
# Returns true if num == 1 and false if num == 4
----------------------------------------------------------------------------------------------------------------------------------|#
(defun checkHappy(num rNorm)

  (let ((summ 0) digit)
    (loop while (/= num 1) do
        
        
        (if (= num 4)
          (return-from checkHappy)
        )
        
        (loop while (plusp num) do          
          (setf digit (mod num 10))
          (setf summ (+ summ (* digit digit)))
          (setf num (floor num 10))
        )
        
        (setf num summ)
        (setf rNorm (+ rNorm (* num num)))
        (setf summ 0)
        
      
    )
    (setf rNorm (sqrt rNorm))
    (return-from checkHappy rNorm)
  )
)

#|----------------------------------------------------------------------------------------------------------------------------------
# Initializes the normSorted array of size 10
# Switches numOne and numTwo if numOne is bigger than numTwoi
# Runs a for-loop where it iterates from numOne to numTwo to determine if a value is a Happy Number or not
# Creates a structNum given the norm and happy number when it returns true from checkHappy
# Fills array with happy numbers till size 10. If size exceeds 10, find lowest norm in array and replace it with searchMin
# Sorts and Prints at the end
----------------------------------------------------------------------------------------------------------------------------------|#
(defun isHappy(numOne numTwo)
  
  
  (let ((j 0) location rNorm normSorted)
  
    (if (> numOne numTwo)
      (rotatef numOne numTwo)
    )
    
    (setf normSorted (make-array '(10)))
    
    
    (loop for i from numOne to numTwo by 1 do
      (setf rNorm (* i i))
      
      (if (checkHappy i rNorm)
        (progn
          (setf rNorm (checkHappy i rNorm))
          
          (if (< j 10)
            (progn
              (setf (aref normSorted j) (make-structNum :num i :norm rNorm))
              (setf j (+ j 1))
            )
            (progn
              (setf location (searchMin normSorted))              
              (if (and (>= j 10) (> rNorm (structNum-norm (aref normSorted location))))
                (setf (aref normSorted location) (make-structNum :num i :norm rNorm))
              )                                                        
            )
          )
        )
      )
    )
    (numSort normSorted j)
    
    (if (= j 0)
      (print "NOBODYS HAPPY!")
      (printNums normSorted j)
    )
    
  )
)


(progn
  (defvar numOne)
  (defvar numTwo)
  (princ "First Argument: ")
  (terpri)
  (setf numOne (read))
  (princ "Second Argument: ")
  (terpri)
  (setf numTwo (read))
  
  (isHappy numOne numTwo)
  (terpri)
)
