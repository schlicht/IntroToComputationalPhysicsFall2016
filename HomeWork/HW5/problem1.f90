!####################################
! Name: Problem1
! Purpose: Apply Neville's Algorithm
! History: Made on 10/6/15
!####################################
      Program Problem1
      Implicit None
! Interpolation Points
      Real*8, Dimension(1:9) :: f, xn
! Test points
      Real*8, Dimension(1:200) :: xvalues
      Real*8 :: x
      Integer :: i, p
      open(unit=10, file="problem1data")
! Fill in interpolation point values
      xn=(/-2.0, -1.2, -0.7, -0.4, 0.1, 0.4, 0.7, 1.2, 2.0/)
      Do i = 1, 9
        f(i) = tanh((xn(i))**2)
      End do
! Creates test points
      Do i = 1, 200
        xvalues(i) =4*(DBLE(i)-1)/199-2 
      End do
!Determines between what interpolation points the x is
      Do i =1, 200
        x = xvalues(i)
      IF(x<=-2) then
          p = 1
        Else if (x<=-1.2) then
          p = 2
        Else if (x<= -0.7) then
          p = 3
        Else if (x<= -0.4) then
          p = 4
        Else if (x<= 0) then
          p = 5
        Else if (x<=0.4) then
          p = 6
        Else if (x<=0.7) then
          p = 7
        Else if (x<=1.2) then
          p = 8
        Else
          p = 9
      End if
!Writes values for plotting
        Write(10,*) x, p, Poly(2, p, xn, f, x), Poly(4, p, xn, f, x), Poly(6, p, xn, f, x)
      End do
      Write(*,*) 'The interpolation becomes much better as the order increases, but the higher orders', &
                 ' have greater difficulty at the discont in the derivative (at 0)'
      Contains
!Computes polynomial. n is the order, p is the bin, xn and f are the inter points. x are the test points
      Real*8 Function Poly (n, p, xn, f, x)
        Integer, Intent(in) :: n, p
        Real*8, Dimension (1:9), Intent(in) :: xn, f
        Real*8, Intent(in) :: x
        Integer :: j, k, l
        Real*8, Dimension(1:9) :: pol
! s is the first interp point
        Integer :: s
        s= p+1-n/2
        If (s<=0) then
          s=1
        Else if (s+n-1>9) then
          s=s-mod(s+n-1, 9)
        End if
! Do loop computes the next polynomials and rewrites array over previous values.
        Do j = 1, 9
          pol(j)=f(j)
        End do
        l=1
        Do j=n, 1, -1
          Do k = 1, j
            pol(k)=((x-xn(s+k-1+l))*pol(k)+(xn(s+k-1)-x)*pol(k+1))/(xn(s+k-1+l)-xn(s+k-1))
          End do
          l=l+1
        End do
        Poly = pol(1)
      End Function Poly

      End Program Problem1
