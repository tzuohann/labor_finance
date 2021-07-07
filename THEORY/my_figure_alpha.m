%==========================================================================
%==========================================================================
%==========================================================================

close all
i_sigma = 1;
i_FC = 1;
i_b = 1;
[params,tech] = param(i_sigma,i_FC,i_b);

first_FC   = 1;
last_FC    = 1;
length_FC  = last_FC - first_FC + 1;

for i_FC = first_FC:last_FC
      
      BaseName = 'File_b_dot2_riskneutral';
      FileName = [BaseName,'_FC_',num2str(i_FC)];
      %BaseName            = 'File_b_zero_';
      load(FileName)
      
      %Common features of the figures
      
      lines           = {'k-','k--'};    
      color           = {'b','r'};       
      models          = {'sp','ws'};     

      figure(i_FC)
      my_figure_1
      
      figure(last_FC+i_FC) 
      my_figure_2
      
end

while 1 == 1
      figure(first_FC)
      figure(last_FC+1)
      pause(2)
      for i1 = first_FC:last_FC
            figure(i1)
            figure(i1 + last_FC)
            pause(.5)
      end
end
