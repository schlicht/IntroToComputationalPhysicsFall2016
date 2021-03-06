!#################################
! Name: Problem2
! Purpose: Test Bisector Method
! History : Made by schli242 on 9/23/15
!################################

      Program Problem2
      Implicit None
      Integer :: n
      Integer :: minl
      Real*8, Dimension(1:10000) :: x, xtemp, xtemp2
      Real*8 :: num
      Real*8 :: temp
      Integer :: upbound, downbound, current
      Integer :: j, i, l, m
      Real*8, Dimension(1:3) :: xval
! Iterages over n values
      Do j = 1, 4
        n =10**j
! Creates numbers for the array
        Do m = 1, n
          Call Random_number(num)
          xtemp(m)=10*(num-0.5)
        End do
!      Do m = 1, n
!        xtemp2(m) =xtemp(m)
!      End do
! Sorts the values and puts them into x
        Do i = 1, n
          temp = 5
          Do l = 1, n
           if(xtemp(l)<temp) then
             temp= xtemp(l)
             minl = l
           end if
          End do
          xtemp(minl) = 5
          x(i) = temp
        End do

      Do i = 1, 3
        Call Random_number(num)
        xval(i)= 10*(num - 0.5)
      End do
      Do l = 1, 3
        m = 0
        current = n/2
        upbound = n
        downbound = 0
        do while ((current/=downbound .AND. current/=upbound) .OR. m== 1000)
          if(xval(l) < x(current)) then
            upbound = current
            current = downbound + (current - downbound)/2
          end if
          if(xval(l) > x(current)) then
            downbound = current
            current = current + (upbound - current)/2
          end if
          m =m+1
        end do
        Write(*, *) 'Size of index, value, steps taken, place in index (i value), value below x in index, value above' 
        Write(*, *) n, xval(l), m, current, x(current), x(current+1)
      end do
      end do
      Write(*,*) 'The steps required to find the correct indices is ln(n)'
      End Program
