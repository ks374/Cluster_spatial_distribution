%% Experiment 9
clear;clc
base_folder = 'Y:\Chenghang\4_Color_Continue\';
load([base_folder 'Database\DBP.mat']);
outpath = [base_folder 'Database\Experiment_9\'];
%%
indata = DBP.Pos_single_DB;
for i = 1:18
    array_A = DBP.get_position_array(indata,i);
    Dist_mat = DBP.Get_Dist_2_matrix(array_A,array_A);
    Dist = DBP.Get_Dist_2_matrix_closest(array_A,array_A);
end
Clustered_index = Dist < 1.5;
array_B = array_A(Clustered_index,:);
array_C = array_A(~Clustered_index,:);
outfile = [outpath,'Pos_Pos_single.csv'];
writematrix(Dist',outfile,'WriteMode','append');
disp('Done');
%
indata = DBP.Neg_single_DB;
for i = 1:18
    array_A = DBP.get_position_array(indata,i);
    Dist_mat = DBP.Get_Dist_2_matrix(array_A,array_A);
    Dist = DBP.Get_Dist_2_matrix_closest(array_A,array_A);
end
outfile = [outpath,'Neg_Neg_single.csv'];
writematrix(Dist',outfile,'WriteMode','append');
disp('Done');
%
indata = DBP.Pos_single_DB_rand;
for i = 1:18
    array_A = DBP.get_position_array(indata,i);
    Dist_mat = DBP.Get_Dist_2_matrix(array_A,array_A);
    Dist = DBP.Get_Dist_2_matrix_closest(array_A,array_A);
end
outfile = [outpath,'Pos_Pos_single_rand.csv'];
writematrix(Dist',outfile,'WriteMode','append');
disp('Done');
%
indata = DBP.Neg_single_DB_rand;
for i = 1:18
    array_A = DBP.get_position_array(indata,i);
    Dist_mat = DBP.Get_Dist_2_matrix(array_A,array_A);
    Dist = DBP.Get_Dist_2_matrix_closest(array_A,array_A);
end
outfile = [outpath,'Neg_Neg_single_rand.csv'];
writematrix(Dist',outfile,'WriteMode','append');
disp('Done');