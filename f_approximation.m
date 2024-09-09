function f_hat = f_approximation(entr)
    W     = entr(1);
    W_dot = entr(2); 
    
    kt   = entr(3); %kt 
    Jrw  = entr(4); %J
    b    = entr(5); %B
    c    = entr(6); %kc
    L    = entr(7); %H  
    R    = entr(8); %R    
    ke   = entr(9); %ke


    a1 = -1*Jrw^(-1)*b;
    a2 =  Jrw^(-1)*kt;
    b1 = -L^(-1)*ke;
    b2 = -L^(-1)*R;
    c1  =  L^(-1);
    f  = -1*Jrw^(-1)*c*sign(W);

    F = (a2*b1-a1*b2)*W+(a1+b2)*W_dot-b2*f;
    G = a2*c1;

    f_hat = 1/G*F;
end