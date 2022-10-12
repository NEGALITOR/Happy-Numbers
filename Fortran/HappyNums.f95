!----------------------------------------------------------------------------------------------------------------------------------
! Compiling
! gfortran HappyNums.f95
! ./a.out
!----------------------------------------------------------------------------------------------------------------------------------

program HappyNums

  IMPLICIT NONE

  type structNum
    integer :: num
    real :: norm
  END type

  integer :: numOne
  integer :: numTwo

  write(*, '(A)', advance="no") "First Argument: "
  read(*,*) numOne
  write(*, '(A)', advance="no") "Second Argument: "
  read(*,*) numTwo

  CALL isHappy(numOne, numTwo)

CONTAINS

  !----------------------------------------------------------------------------------------------------------------------------------
  ! Initializes the normSorted array of size 10
  ! Switches numOne and numTwo if numOne is bigger than numTwoi
  ! Runs a for-loop where it iterates from numOne to numTwo to determine if a value is a Happy Number or not
  ! Creates a structNum given the norm and happy number when it returns true from checkHappy
  ! Fills array with happy numbers till size 10. If size exceeds 10, find lowest norm in array and replace it with searchMin
  ! Sorts and Prints at the end
  !----------------------------------------------------------------------------------------------------------------------------------
  SUBROUTINE isHappy(numOne, numTwo)

    IMPLICIT NONE
  
    type(structNum), dimension(10) :: normSorted
    type(structNum) :: nSt
    integer, intent(out) :: numOne
    integer, intent(out) :: numTwo
    integer :: location
    integer :: i, j, tmp
    real :: rNorm

    j = 1;
    location = 1;

    if (numOne > numTwo) then
      tmp = numOne
      numOne = numTwo
      numTwo = tmp
    END if

    do i = numOne, numTwo
      rNorm = i*i
      
      if (checkHappy(i, rNorm)) then
        nSt = structNum(i, rNorm)
        location = searchMin(normSorted, j) !change this to make it so it compares each other with nSt not whole array

        if (j >= 11 .AND. rNorm > normSorted(location)%norm) then
          normSorted(location) = nSt
        else if (j < 11) then
          normSorted(j) = nSt
          j = j + 1
        END if
      END if
    END do

    CALL sort(normSorted, j)

    if (j == 1) then
      write(*, '(A)') "NOBODYS HAPPY!"
    else
      CALL printNums(normSorted, j)
    END IF

  END SUBROUTINE
  
  !----------------------------------------------------------------------------------------------------------------------------------
  ! Checks whether a value passed through is Happy or Unhappy
  ! Calculates norm of value after determining if happy or not
  ! Returns true if hare and turt are equal do determine happiness
  !----------------------------------------------------------------------------------------------------------------------------------
  FUNCTION checkHappy(number, rNorm) result(result) !From Rosetta code with rNorm integrated

    implicit none
    
    integer, intent (in) :: number
    real, intent (out) :: rNorm
    logical :: result
    integer :: turt
    integer :: hare

    turt = number
    hare = number
    do
      turt = sumDigitsSquared(turt)
      hare = sumDigitsSquared(sumDigitsSquared(hare))

      rNorm = rNorm + (turt*turt)
      if (turt == hare) then
        exit
      end if
    end do
    result = turt == 1

  end function checkHappy
  
  !----------------------------------------------------------------------------------------------------------------------------------
  ! Plays in hand with checkHappy to determine the next and previous value to see if the value reaches 0
  ! Goes through each digit and adds it to rest after being squared and reassigns it back to num
  !----------------------------------------------------------------------------------------------------------------------------------
  FUNCTION sumDigitsSquared(number) result(result) !From Rosetta code
  
    implicit none
    integer, intent (in) :: number
    integer :: result
    integer :: digit
    integer :: rest
    integer :: num

    result = 0
    num = number
    do
      if (num == 0) then
        exit
      end if
      rest = num / 10
      digit = num - 10 * rest
      result = result + digit * digit
      num = rest
    end do

  end function sumDigitsSquared
  
  !----------------------------------------------------------------------------------------------------------------------------------
  ! Insertion sort through norms from greatest to least
  !----------------------------------------------------------------------------------------------------------------------------------
  SUBROUTINE sort(normSorted, sortSize)
  
    IMPLICIT NONE
  
    type(structNum), dimension(10), intent(out) :: normSorted
    type(structNum) :: maxim
    integer, intent(in) :: sortSize
    integer :: i, j, indx

    do i = 1, sortSize-1
      indx = i
      do j = i, sortSize-1
        if (normSorted(j)%norm > normSorted(indx)%norm) then
          indx = j
        END if
      END do

      maxim = normSorted(indx)
      normSorted(indx) = normSorted(i)
      normSorted(i) = maxim
    END do  

  END SUBROUTINE

  !----------------------------------------------------------------------------------------------------------------------------------
  ! Searches through array for the lowest norm and returns the location of the array
  !----------------------------------------------------------------------------------------------------------------------------------
  integer FUNCTION searchMin(normSorted, arrSize)

    IMPLICIT NONE
    
    type(structNum), dimension(10), intent(in) :: normSorted
    type(structNum) :: minSt
    integer, intent(in) :: arrSize
    integer :: i, location  
    real ::  minNorm

    minNorm = 0
    location = 1
    minSt = normSorted(1)

    !write(*,"(i0)") arrSize-1
    do i = 1, arrSize-1
      minNorm = min(minSt%norm, normSorted(i)%norm)
      
      if (minNorm == normSorted(i)%norm) then
        minSt = normSorted(i)
        location = i
      END if
    END do
    searchMin = location

  END FUNCTION
  
  !----------------------------------------------------------------------------------------------------------------------------------
  ! Prints all nums in array
  !----------------------------------------------------------------------------------------------------------------------------------
  SUBROUTINE printNums(normSorted, arrSize)

    IMPLICIT NONE
  
    type(structNum), dimension(10), intent(in) :: normSorted
    integer, intent(in) :: arrSize
    integer :: i

    do i = 1, arrSize-1
      if (normSorted(i)%num /= 0) then
        write(*,'(i0)') normSorted(i)%num
      END if
    END do

  END SUBROUTINE printNums

end program HappyNums