%% Experiment 9
clear;clc
base_folder = 'D:\Research\Projects\Project_17_4_color_continue\F_Einstein\';
load([base_folder 'Database\DBP.mat']);
outpath = ['D:\Research\Projects\Project_17_4_color_continue\Data\Experiment_9\'];
%%
indata = DBP.Pos_single_DB;
for i = 1:18
    array_A = DBP.get_position_array(indata,i);
    Dist_mat = DBP.Get_Dist_2_matrix(array_A,array_A);
    Dist = DBP.Get_Dist_2_matrix_closest(array_A,array_A);
end
outfile = [outpath,'Pos_Pos_single.csv'];
dlmwrite(outfile,Dist','-append','delimiter',',');
disp('Done');
%%
indata = DBP.Neg_single_DB;
for i = 1:18
    array_A = DBP.get_position_array(indata,i);
    Dist_mat = DBP.Get_Dist_2_matrix(array_A,array_A);
    Dist = DBP.Get_Dist_2_matrix_closest(array_A,array_A);
end
outfile = [outpath,'Neg_Neg_single.csv'];
dlmwrite(outfile,Dist',"-append");
disp('Done');
%%
indata = DBP.Pos_single_DB_rand;
for i = 1:18
    array_A = DBP.get_position_array(indata,i);
    Dist_mat = DBP.Get_Dist_2_matrix(array_A,array_A);
    Dist = DBP.Get_Dist_2_matrix_closest(array_A,array_A);
end
outfile = [outpath,'Pos_Pos_single_rand.csv'];
dlmwrite(outfile,Dist',"-append");
disp('Done');
%%
indata = DBP.Neg_single_DB_rand;
for i = 1:18
    array_A = DBP.get_position_array(indata,i);
    Dist_mat = DBP.Get_Dist_2_matrix(array_A,array_A);
    Dist = DBP.Get_Dist_2_matrix_closest(array_A,array_A);
end
outfile = [outpath,'Neg_Neg_single_rand.csv'];
dlmwrite(outfile,Dist',"-append");
disp('Done');