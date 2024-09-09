function u_eq = idealController(entr)
%UNTITLED18 Summary of this function goes here
ddot_y_d = entr(1);
lambda   = entr(2);
dot_e    = entr(3);
alpha    = entr(4);
s        = entr(5);
beta     = entr(6);
epsilon  = entr(7);

kt      = entr(8); 
Jrw     = entr(9);
b       = entr(10);
c       = entr(11);
L       = entr(12);
R       = entr(13);
ke      = entr(14);

w       = entr(15);
w_dot   = entr(16);
 
a1 = -Jrw^(-1)*b;
a2 = Jrw^(-1)*kt;
b1 = -L^(-1)*ke;
b2 = -L^(-1)*R;
c1 = L^(-1);
f  = -Jrw^(-1)*c*sign(w);

F_x = (a2*b1-a1*b2)*w+(a1+b2)*w_dot-b2*f;
G_x = a2*c1;
u_eq = (-F_x + ddot_y_d + lambda * dot_e + alpha * s + beta * tanh(s / epsilon)) / G_x;
end