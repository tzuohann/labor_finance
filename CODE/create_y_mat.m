% ---------------------------------------------------------------------------
% create_ys_mat.m: creates the transition matrix to compute
% expectations with respect to (y,sigma_z)
%
% Convention: pi_ys(i,j) is P[ (y,s)_{t+1} = j | (y,s)_t = i] where i is
% the flat index corresponding to i=(y-1)*ny+s
%
% Optimized version
%

function [y_mat] = create_y_mat(ny,y_grid,rho_y,sigma_y)

[My0_id,My1_id]=ndgrid(1:ny,1:ny);

y_mat = zeros(ny,ny);

ubound_y=inf*ones(ny,ny);
lbound_y=-inf*ones(ny,ny);


if ny>1
    ubound_y(:,1:ny-1)=((y_grid(My1_id(:,1:ny-1))+y_grid(My1_id(:,2:ny)))/2-rho_y*y_grid(My0_id(:,1:ny-1)))/sqrt(sigma_y^2*(1-rho_y^2));
    lbound_y(:,2:ny)=((y_grid(My1_id(:,1:ny-1))+y_grid(My1_id(:,2:ny)))/2-rho_y*y_grid(My0_id(:,2:ny)))/sqrt(sigma_y^2*(1-rho_y^2));
end


ubound_y=reshape(ubound_y(:),ny*ny,1);
lbound_y=reshape(lbound_y(:),ny*ny,1);



y_mat(:) = mvncdf([lbound_y],[ubound_y],[0],[1]);



