!#################################
! Name: Problem 2c
! Purpose: Execute Spline Method
! History: Made by schli242 on 10/28/15
!#################################


      Program Problem2c
      Implicit None
      Integer :: i, N=500
      Real*8 :: x
!Plots uniformly over the interval
      Do i=0, N-1
        x= DBLE(2)*DBLE(i)/DBLE(N)-DBLE(1)
        Call spline(x)
      End do
      Contains
!Same spline method except the f values have changed along with the u values
      Subroutine spline(x) 
      Real*8, Intent(in) :: x
      Integer, Parameter :: N =10
      Real*8 :: p, u
      Real*8, Dimension(0:N, 0:N) :: A
      Real*8, Dimension(0:N) :: b, D, f
      Real*8, Dimension(0:N-1):: g, h
      Real*8, Dimension(0:N-1) :: a1, b1, c1, d1
      Integer :: i, j
!      Open(unit=10, file="prob2bbandD.dat")
      Open(unit=11, file="prob2c.dat")
      f = (/2.5, 1.6375, 1.3405, 0.78851, -0.066509, -0.50000, -0.082508, 0.66051, 0.90851, 0.61349, 0.50000/)
      Do i=0, N
        Do j=0, N
          A(i, j) = 0
        End do
      End do
      A(0,0) =2
      A(0, 1) = 1
      A(N, N-1) = 1
      A(N, N)= 2
      Do i=1, N-1
        A(i, i) =4
        A(i, i+1) =1
        A(i, i-1)= 1
     End do


     b(0)= 3*(f(1)-f(0))
     b(1)= 3*(f(2)-f(0))
     b(N-1)= 3*(f(N)-f(N-2))
     b(N)= 3*(f(N)-f(N-1))
     If(N>3) then
       Do i=2, N-2
        b(i)=3*(f(i+1)-f(i-1))
       End do
     End if
      g(N-1) = -A(N,N-1)/A(N,N)
      h(N-1)=b(N)/A(N,N)
      Do i=N-1, 1, -1
        g(i-1) = -A(i,i-1)/(A(i,i)+A(i, i+1)*g(i))
        h(i-1) = (b(i)-A(i, i+1)*h(i))/(A(i,i)+A(i, i+1)*g(i))
      End do 
      D(0) = (b(0)-A(0,1)*h(0))/(A(0,0)+A(0,1)*g(0))
      Do i=0, N-1
        D(i+1)= g(i)*D(i)+h(i)
      End do

      Do i= 0, N-1
        a1(i)=f(i)
        b1(i)=D(i)
        c1(i)=3*(f(i+1)-f(i))-2*D(i)-D(i+1)
        d1(i)=2*(f(i)-f(i+1))+D(i)+D(i+1)
      End do
      
      i = int(x)
      u= (x-i)*5
      p=a1(i)+b1(i)*u+c1(i)*u**2+d1(i)*u**3
      Write(11,*) x, p

      End Subroutine spline
      End Program Problem2c
