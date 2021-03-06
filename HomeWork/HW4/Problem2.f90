!###################################
! Name: Problem2
! Purpose:
! History: Made by schli242 on 10/1/15
!###################################

      Program Problem2
      Implicit None
! The analytical solution to the integral
      Real*8 :: fan = 1274.5833333333
! Writes the approximation and its error
      Write(*,*) trap(101), abs((trap(101)-fan)/fan)
      Write(*,*) trap(501), abs((trap(501)-fan)/fan)
      Write(*,*) trap(2501), abs((trap(2501)-fan)/fan)
      Write(*,*) simpson(101), abs((simpson(101)-fan)/fan)
      Write(*,*) simpson(501), abs((simpson(501)-fan)/fan)
      Write(*,*) simpson(2501), abs((simpson(2501)-fan)/fan)
      Write(*,*) "The trapazoidal approximation is converging more quickly"
      Write(*,*) "The optimal N for both seem to be near 2500"
      Contains
! Computes the trapazoid approx for the integral of the function
! N is the number of points to sample
      Real*8 Function trap (N)
      Implicit None
      Integer, Intent(in) :: N
! x is the current position to sum over
      Real*8 :: x
! Holds the f values for summing
      Real*8, Dimension(1:N) :: f
      Integer :: i
! Writes the f values
      Do i=1, N
        x=5*(DBLE(i)-1)/(DBLE(N)-1)
        f(i) = 2*x**4+x**3-7*x**2+14*x-3
      End do
!Adds the end points to the answer
      trap =(f(1)+f(N))/2
! Sums over all f values
      Do i=2, N-1
       trap = trap + f(i)
      End do
! Scales by multiplying by the size of the interval
      trap = trap*5/(N-1)
      End function

! Applies Simpson's rule
      Real*8 Function simpson (N)
      Implicit None
! Number of points sampled
      Integer, Intent(in) :: N
      Real*8 :: x
      Real*8, Dimension(1:N) :: f
      Integer :: i
! Computes the f values at the points
      Do i = 1, N
        x=DBLE(5)*(DBLE(i)-1)/(DBLE(N)-1)
        f(i)=2*x**4+x**3-7*x**2+14*x-3
      End do
! Adds the endpoints
      simpson = f(1) -3*f(N)
!Sums over the f values and adds to the final solution
      Do i=1, N/2
        simpson =simpson+ DBLE(2)*f(2*i)+DBLE(4)*f(2*i+1)
      End do
! Scales to account for distance between points
      simpson = DBLE(5)*simpson/DBLE(3*(N-1))
      End function simpson
      End Program Problem2
