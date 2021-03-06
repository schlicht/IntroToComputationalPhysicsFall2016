!#####################################
! Name: Problem2
! Purpose: Use Runge Kutta method to solve Lane-Emden equation
! History: Made by schli242 on 11/11/15
!#####################################

      Program Problem2
      Implicit None
      Integer :: N=10000
      Real*8, Dimension(1:2) :: x0= (/DBLE(0.0), DBLE(10.0) /)
! Calls runge kutta for part a at the required n values
      Call rungeKutta(N, x0, DBLE(1), DBLE(1), 10, 'problem2010.dat')
      Call rungeKutta(N, x0, DBLE(1), DBLE(1.5), 11, 'problem2015.dat')
      Call rungeKutta(N, x0, DBLE(1), DBLE(2), 12, 'problem2020.dat')
      Call rungeKutta(N, x0, DBLE(1), DBLE(2.5), 13, 'problem2025.dat')
! Calls runge kutta for part b at the required n values
      Call rungeKutta2(N, x0, DBLE(1), DBLE(3), 14, 'problem2b30.dat')
      Call rungeKutta2(N, x0, DBLE(1), DBLE(1.5), 14, 'problem2b15.dat')
! Writes down solutions
      Write(*,*) "From the output of the files or the graph 'problem2a',", & 
                 " the r values are verified"
      Write(*,*) 'n, 0.5r, M at 0.5r, r, M at r'
      Write(*,*) '1.5, 1.827, 26.727, 3.654, 27.2932'
      Write(*,*) '3, 3.449, 12.934, 6.897. 12.942'
      Write(*,*) 'At half r, nearly all the mass is within the radius'
      Contains
!Executes Runge kutta for part a
! N is the number of steps, x0 is the bounds, m is the exponent, u is the output port, and string is the file name
      Subroutine rungeKutta(N, x0, yinit, m, u, string)
      Character(LEN=15), Intent(in) :: string
      Real*8, Dimension(0:1), Intent(in) :: x0
      Real*8, Intent(in) :: yinit, m
      Integer, Intent(in) :: N, u
! holds the k values
      Real*8, Dimension(1:2, 1:4) :: k
! our dependent variable x, and the two solutions y, and v
      Real*8, Dimension(1:N) :: x, y, v
      Real*8 :: dx
      Integer :: i
      Open(unit=u, file=string)
!Computes the step length
      dx=(x0(1)-x0(0))/N
!Initializes the x vector
      Do i = 1, N
        x(i)= x0(0)+dx*DBLE(i)
      End do
!Stores Initial conditions
      y(1)=yinit
      v(1)=0
!Performs Runge Kutta
      Do i=1, N
        k(1, 1) = dx*v(i)
        k(2, 1) = dx*(-DBLE(2)*v(i)/x(i)-y(i)**m)
        k(1, 2) = dx*(v(i)+0.5*k(2,1))
        k(2, 2) = dx*(-DBLE(2)*(v(i)+0.5*k(2,1))/x(i)-(y(i)+ 0.5*k(1, 1))**m)
        k(1, 3) = dx*(v(i)+0.5*k(2, 2))
        k(2, 3) = dx*(-DBLE(2)*(v(i)+0.5*k(2,2))/x(i)-(y(i)+0.5*k(1,2))**m)
        k(1, 4) = dx*(v(i)+k(2, 3))
        k(2, 4) = dx*(-DBLE(2)*(v(i)+k(2, 3))/x(i)-(y(i)+k(1, 3))**m)
        y(i+1) = y(i)+ DBLE((k(1, 1)+2*k(1, 2)+2*k(1, 3)+k(1, 4))/6)
        v(i+1) = v(i)+ DBLE((k(2, 1)+2*k(2, 2)+2*k(2, 3)+k(2, 4))/6)
      End do
!Writes the output to file
      Do i=1, N
        Write(u,*) x(i), y(i)/yinit, v(i)/yinit
      End do
      End subroutine rungeKutta
!Executes the same algorithm but for part b
      Subroutine rungeKutta2(N, x0, yinit, m, u, string)
      Character(LEN=15), Intent(in) :: string
      Real*8, Dimension(0:1), Intent(in) :: x0
      Real*8, Intent(in) :: yinit, m
      Integer, Intent(in) :: N, u
      Real*8, Dimension(1:2, 1:4) :: k
      Real*8, Dimension(1:N) :: x, y, v
      Real*8 :: dx, mass=0
      Integer :: i
      Open(unit=u, file=string)
      dx=(x0(1)-x0(0))/N
      Do i = 1, N
        x(i)= x0(0)+dx*DBLE(i)
      End do
      y(1)=yinit
      v(1)=0
      Do i=1, N
        k(1, 1) = dx*v(i)
        k(2, 1) = dx*(-DBLE(2)*v(i)/x(i)-y(i)**m)
        k(1, 2) = dx*(v(i)+0.5*k(2,1))
        k(2, 2) = dx*(-DBLE(2)*(v(i)+0.5*k(2,1))/x(i)-(y(i)+ 0.5*k(1, 1))**m)
        k(1, 3) = dx*(v(i)+0.5*k(2, 2))
        k(2, 3) = dx*(-DBLE(2)*(v(i)+0.5*k(2,2))/x(i)-(y(i)+0.5*k(1,2))**m)
        k(1, 4) = dx*(v(i)+k(2, 3))
        k(2, 4) = dx*(-DBLE(2)*(v(i)+k(2, 3))/x(i)-(y(i)+k(1, 3))**m)
        y(i+1) = y(i)+ DBLE((k(1, 1)+2*k(1, 2)+2*k(1, 3)+k(1, 4))/6)
        v(i+1) = v(i)+ DBLE((k(2, 1)+2*k(2, 2)+2*k(2, 3)+k(2, 4))/6)

      End do

      Do i=1, N
!Calculates the mass using the trapazoidal rule
        mass= mass +6.28318531*(y(i+1)**(m+2)+y(i)**(m+2))*dx
        Write(u,*) x(i), y(i)**m, y(i)**(m+DBLE(1)), mass
      End do
      End subroutine rungeKutta2
      End Program Problem2
