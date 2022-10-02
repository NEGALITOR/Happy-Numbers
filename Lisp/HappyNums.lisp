(defstruct structNum
  num
  norm
)

(defun main()
  (defvar numOne)
  (defvar numTwo)
  (princ "First Argument: ")
  (terpri)
  (setf numOne (read))
  (princ "Second Argument: ")
  (terpri)
  (setf numTwo (read))
  
  (isHappy numOne numTwo)
)

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
              ;;;(print location)
              
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

(defun checkHappy(num rNorm)

  (let ((summ 0) digit)
    (loop while (/= num 1) do
        
        
        (if (= num 4)
          (return-from checkHappy)
        )
        
        ;;;(format t "Num : ~d" num)
        ;;;(terpri)  
        
        (loop while (plusp num) do
          ;;;(format t "Num : ~d" num)
          ;;;(terpri) 
          
          (setf digit (mod num 10))
          (setf summ (+ summ (* digit digit)))
          (setf num (floor num 10))
        )
        
        (setf num summ)
        (setf rNorm (+ rNorm (* num num)))
        (setf summ 0)
        
      
    )
    (setf rNorm (sqrt rNorm))
    ;;;(print rNorm)
    (return-from checkHappy rNorm)
  )
)

(defun searchMin(normSorted)

  (let ((count 0) minNorm location minSt)
    (setf minSt (aref normSorted 0))
    
    (loop for i across normSorted do
      ;;;(print (structNum-norm i))
      
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

(defun printNums(normSorted j)
  (loop for i from 0 to (- j 1) by 1 do
    (print (structNum-num (aref normSorted i)))
  )
)

(main)