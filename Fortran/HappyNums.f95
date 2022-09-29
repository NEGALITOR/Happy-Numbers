program HappyNums

  IMPLICIT NONE

  type structNum
    integer :: num
    real :: norm
  END type

  integer :: numOne
  integer :: numTwo
  integer :: i, tmp

  write(*, '(A)', advance="no") "First Argument: "
  read(*,*) numOne
  write(*, '(A)', advance="no") "Second Argument: "
  read(*,*) numTwo

  CALL isHappy(numOne, numTwo)

CONTAINS

  SUBROUTINE isHappy(numOne, numTwo)

    IMPLICIT NONE
  
    type(structNum), dimension(10) :: normSorted
    type(structNum) :: nSt
    integer, intent(out) :: numOne
    integer, intent(out) :: numTwo
    integer :: location
    integer :: i, j, tmp
    real :: rNorm
    real :: meanNorm

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
        !write(*,'(i0)') i
        nSt = structNum(i, rNorm)
        !write(*, '(i0, A, f20.5)') nSt%num , " | ", nSt%norm

        location = searchMin(normSorted, j) !change this to make it so it compares each other with nSt not whole array

        if (j >= 11 .AND. rNorm > normSorted(location)%norm) then
          !write(*, '(A)') "Done"
          normSorted(location) = nSt
          !write(*,'(A)')" "
          !write(*, '(i0, A, f0.5, A)') normSorted(location)%num, " | ", normSorted(location)%norm, " | "
          
          !j = 10
        else if (j < 11) then
          !write(*, '(i0)') j
          !write(*, '(i0, A)', advance = 'no') nSt%num, " | "
          !write(*,"(f20.5)") nSt%norm
          normSorted(j) = nSt
          !write(*, '(i0, A, f0.5)') normSorted(j)%num, " | ", normSorted(j)%norm
          j = j + 1
        END if
      END if
    END do

    CALL sort(normSorted, j)

    if (j == 1) then
      write(*, '(A)') "NOBODYS HAPPY"
    else
      CALL printNums(normSorted, j)
    END IF

  END SUBROUTINE

  FUNCTION checkHappy(number, rNorm) result(result) !From Rosetta code with rNorm integrated

    implicit none
    
    integer, intent (in) :: number
    real, intent (out) :: rNorm
    logical :: result
    integer :: turtoise
    integer :: hare

    turtoise = number
    hare = number
    do
      turtoise = sumDigitsSquared(turtoise)
      !write(*, '(A, i0, A, A, i0, A)', advance = 'no') "Number: ", number, ' | ', 'Turtoise: ', turtoise, ' | '
      hare = sumDigitsSquared(sumDigitsSquared(hare))
      !write(*, '( A, A, i0, A)', advance = 'no') ' | ', 'Hare: ', hare, ' | '
      !write(*,*)" "
      rNorm = rNorm + (turtoise*turtoise)
      if (turtoise == hare) then
        exit
      end if
    end do
    result = turtoise == 1

  end function checkHappy

  FUNCTION sumDigitsSquared(number) result(result) !From Rosetta code
  
    implicit none
    integer, intent (in) :: number
    integer :: result
    integer :: digit
    integer :: rest
    integer :: work

    result = 0
    work = number
    do
      if (work == 0) then
        exit
      end if
      rest = work / 10
      digit = work - 10 * rest
      result = result + digit * digit
      work = rest
    end do

  end function sumDigitsSquared

  SUBROUTINE sort(normSorted, sortSize)
  
    IMPLICIT NONE
  
    type(structNum), dimension(10), intent(out) :: normSorted
    type(structNum) :: maxim
    type(structNum) :: key
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
      !write(*, '(i0, A, i0)') minSt%num, " | ", normSorted(i)%num
      !write(*,'(f0.5, A, f0.5, A, f0.5)') minNorm, " | ", minSt%norm, " | ", normSorted(i)%norm
      
      !write(*,"(i0)") minSt%num
      if (minNorm == normSorted(i)%norm) then
        !write(*,"(A)") "Done"
        minSt = normSorted(i)
        location = i
      END if
    END do
    !write(*,"(A)") ""
    searchMin = location

  END FUNCTION

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