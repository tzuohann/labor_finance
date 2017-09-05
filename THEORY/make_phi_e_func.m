function phi_e_func = make_phi_e_func(prod_func_type,r,R,delta)

    if prod_func_type == 1
        phi_e_func    = @(Aalpha) r*Aalpha - R;
    elseif prod_func_type == 2
        phi_e_func    = @(Aalpha) r*Aalpha/(1+Aalpha) - R;
    elseif prod_func_type == 3
        phi_e_func    = @(Aalpha) r*Aalpha/((1+Aalpha)*R);
    elseif prod_func_type == 4
        phi_e_func    = @(Aalpha) r*Aalpha - R;
    elseif prod_func_type == 5
        phi_e_func    = @(Aalpha) (Aalpha*r - R)./Aalpha;
    elseif prod_func_type == 6
        phi_e_func      = @(Aalpha) (Aalpha*r - (1+Aalpha)*R)./(1+Aalpha)^delta ;
    elseif prod_func_type == 7
        phi_e_func      = @(Aalpha) (Aalpha*r/R - 1)/Aalpha;
    elseif prod_func_type == 8
        phi_e_func      = @(Aalpha) r/R*Aalpha^(1-delta);
    else
        error('ProdFunc Error')
    end
end
