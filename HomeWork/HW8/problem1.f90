!########################################
! Purpose: Problem 1
! Purpsoe: Perform runge-kutta
! History: Made by schli242 on 11/5/16
!########################################

      Program Problem1
      Implicit None
      Character(LEN=20) :: str = 'problem1a.dat'

      Integer :: N=1000
      Open(unit=9, file='prob1b.dat')
!Runge Kutta method on decay
      Call rungeKutta(N, [DBLE(0), DBLE(10)], 10, str)
!Runge Kutta on Linear Pendulum
      Call rungeKutta2(400, [DBLE(0), DBLE(12.56637061)], 11, 'prob1b00400.dat')
      Call rungeKutta2(800, [DBLE(0), DBLE(12.56637061)], 12, 'prob1b00800.dat')
      Call rungeKutta2(1600, [DBLE(0), DBLE(12.56637061)], 13, 'prob1b01600.dat')
      Call rungeKutta2(3200, [DBLE(0), DBLE(12.56637061)], 14, 'prob1b03200.dat')
      Call rungeKutta2(6400, [DBLE(0), DBLE(12.56637061)], 15, 'prob1b06400.dat')
      Call rungeKutta2(12800, [DBLE(0), DBLE(12.56637061)], 16, 'prob1b12800.dat')
      Write(*,*) 'The errors decrease with a slope of 4 as expected'
!Runge Kutta on nonlinear pendulum
      Call rungeKutta3(6400, [DBLE(0), DBLE(12.56637061)], DBLE(1.0), 17, 'prob1c10000.dat')
      Call rungeKutta3(6400, [DBLE(0), DBLE(12.56637061)], DBLE(1.5), 7, 'prob1c15000.dat')
      Call rungeKutta3(6400, [DBLE(0), DBLE(12.56637061)], DBLE(3.14159/2), 19, 'prob1c31415.dat')
      Write(*,*) 'As x0 increase, a lag from linear solution increases'
      Write(*,*) 'velocity values become larger compared to x values'
      Contains
!Steps, boundaries, port, file name
      Subroutine rungeKutta (N, x0, u, string)
      Character(LEN=20), Intent(in) :: string
      Real*8, Dimension(0:1), Intent(in) :: x0
      Integer, Intent(in) :: N, u
!k values
      Real*8 :: k1, k2, k3, k4, dt
!dependent and independent variable vectors
      Real*8, Dimension(1:N) :: x, y
      Integer :: i
      Open(unit=u, file=string)
!determines dt
      dt=(x0(1)-x0(0))/N
!files x vector 
      Do i = 1, N
        x(i)= x0(0)+dt*i
      End do
!initial y value
      y(1)=10
!Runge Kutta Method
      Do i=1, N
        k1 = -dt*(y(i))
        k2 = -dt*(y(i)+0.5*k1)
        k3 = -dt*(y(i)+0.5*k2)
        k4 = -dt*(y(i)+k3)
        y(i+1) = y(i)+ DBLE((k1+2*k2+2*k3+k4)/6)
      End do
 !Writes values and error to file     
      Do i=1, N
        Write(u,*) x(i), y(i)
      End Do
      End subroutine rungeKutta
!Runge Kutta for linear pendulum
      Subroutine rungeKutta2 (N, x0, u, string)
      Character(LEN=15), Intent(in) :: string
      Real*8, Dimension(0:1), Intent(in) :: x0
      Integer, Intent(in) :: N, u
!k values and error values
      Real*8 :: k1, k2, k3, k4, dx, merror, mverror, maxerror=-100, maxverror=-100
!vectors which hold time, displacement, and velocity
      Real*8, Dimension(1:N) :: x, y, vy
      Integer :: i
      Open(unit=u, file=string)
!dx value is determined
      dx=(x0(1)-x0(0))/N
!x values determined
      Do i = 1, N
        x(i)= x0(0)+dx*DBLE(i)
!initial values
      End do
      y(1)=0.01
      vy(1)=0
!Executes Runge Kutta
      Do i=1, N
        k1 = -y(i)
        k2 = -(y(i)+0.5*dx*vy(i))
        k3 = -(y(i)+0.5*dx*vy(i)+0.25*k1*(dx)**2)
        k4 = -(y(i)+vy(i)*dx+0.5*k2*(dx)**2)
        vy(i+1)=vy(i)+dx/DBLE(6)*(k1+2*k2+2*k3+k4)
        y(i+1) = y(i)+ vy(i)*dx+((dx)**2)*DBLE((k1+k2+k3)/6)
      End do
!Determines max error
      maxerror=-100
      maxverror=-100
      Do i=1, N
        Write(u,*) x(i), 100*y(i), 100*vy(i)
        merror=log(abs(y(i)-0.01*cos(x(i-1)))*10**(2))
        mverror=log(abs(vy(i)+0.01*sin(x(i-1)))*10**(2))
        if(merror>maxerror) then
          maxerror= merror
        end if
        if(mverror>maxverror) then
          maxverror =mverror
        end if
      End Do
!Outputs error to file
      Write(9,*) log(dx), maxerror, maxverror

      End subroutine rungeKutta2
!Same routine as before except for the nonlinear pendulum
      Subroutine rungeKutta3 (N, x0, yinit, u, string)
      Character(LEN=15), Intent(in) :: string
      Real*8, Dimension(0:1), Intent(in) :: x0
      Real*8, Intent(in) :: yinit
      Integer, Intent(in) :: N, u
      Real*8 :: k1, k2, k3, k4, dx, merror, maxerror=-100
      Real*8, Dimension(1:N) :: x, y, vy
      Integer :: i
      Open(unit=u, file=string)
      dx=(x0(1)-x0(0))/N
      Do i = 1, N
        x(i)= x0(0)+dx*DBLE(i)
      End do
      y(1)=yinit
      vy(1)=0
      Do i=1, N
        k1 = -sin(y(i))
        k2 = -sin(y(i)+0.5*dx*vy(i))
        k3 = -sin(y(i)+0.5*dx*vy(i)+0.25*k1*(dx)**2)
        k4 = -sin(y(i)+vy(i)*dx+0.5*k2*(dx)**2)
        vy(i+1)=vy(i)+dx/DBLE(6)*(k1+2*k2+2*k3+k4)
        y(i+1) = y(i)+ vy(i)*dx+((dx)**2)*DBLE((k1+k2+k3)/6)
      End do

      Do i=1, N
        Write(u,*) x(i), y(i)/yinit, vy(i)
      End do
      End subroutine rungeKutta3
      End Program Problem1
