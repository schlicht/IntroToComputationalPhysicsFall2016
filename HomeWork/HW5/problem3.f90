﻿!########################################
! Name: Problem3
! Purpose : Use Recursion Method on Tri-diagonal Matrices
! History: Made by schli242 on 10/11/15
!########################################

      Program Problem3
      Implicit None
      Integer, Parameter :: size =100
      Real*8, Dimension(1:size, 1:size) :: A
      Real*8, Dimension(1:size) :: b, x
      Real*8, Dimension(1:size-1):: g, h
      Real*8 :: c, be
      Integer :: i
      Open(unit=10, file="bandx.dat")
      Open(unit=11, file="gandh.dat")
      A(1,1) =1.5
      A(1, 2) = 0.5
      A(size, size-1) = 0.5
      A(size, size)= 1.5
      Do i=2, size-1
        A(i, i) =1.5
        A(i, i+1) =0.5
        A(i+1, i)= 0.5
     End do
     Do i =1, size
       if(i<=(33)) then
         b(i)=0.5
       Else if (i>2*size/3) then
         b(i) = 0.5
       Else
         b(i)=0
      End if
     End do
      c=0.5
      be=1.5
      g(size-1) = -c/be
      h(size-1)=b(size)/be
      Do i=size-2, 1, -1
        g(i) = -c/(be+c*g(i+1))
        h(i) = (b(i+1)-c*h(i+1))/(be+c*g(i+1))
      End do 
      x(1) = (b(1)-c*h(i))/(be+c*g(i))
      Do i=2, size
        x(i)= g(i-1)*x(i-1)+h(i-1)
      End do
      Do i=1, size-1
        Write(10,*) i, x(i), b(i)
        Write(11,*)  i, g(i), h(i)
      End do
        Write(10, *) i, x(size), b(size)
      End Program Problem3
