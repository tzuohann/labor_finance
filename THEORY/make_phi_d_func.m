function phi_d_fun = make_phi_d_func(phi_e_func,prod_func_type,R,r,delta)
    if prod_func_type == 1
        phi_d_fun     = @(w,Aalpha) phi_e_func(Aalpha) + w ;
    elseif prod_func_type == 2
        phi_d_fun     = @(w,Aalpha) phi_e_func(Aalpha) + w/(1+Aalpha) ;
    elseif prod_func_type == 3
        phi_d_fun     = @(w,Aalpha) phi_e_func(Aalpha) + w/((1+Aalpha)*R) ;
    elseif prod_func_type == 4
        phi_d_fun     = @(w,Aalpha) phi_e_func(Aalpha) + w ;
    elseif prod_func_type == 5
        phi_d_fun     = @(w,Aalpha) phi_e_func(Aalpha) + w/Aalpha;
    elseif prod_func_type == 6
        phi_d_fun     = @(w,Aalpha) phi_e_func(Aalpha) + w/(1+Aalpha).^delta;
    elseif prod_func_type == 7
        phi_d_fun     = @(w,Aalpha) phi_e_func(Aalpha) + w/(R*Aalpha);
    elseif prod_func_type == 8
        phi_d_fun     = @(w,Aalpha) phi_e_func(Aalpha) + w/(R*Aalpha^delta);
    else
        error('ProdFunc Error')
    end
end