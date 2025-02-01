%% Experiment 9
clear;clc
base_folder = 'E:\File\Work\2024\eLife manuscript\';
load([base_folder 'Data\V7_Contain_all_raw\DBP.mat']);
outpath = [base_folder 'Experiment_9\'];
name_list_Pos = ["WTP2A_Pos","WTP2B_Pos","WTP2C_Pos","WTP4A_Pos","WTP4B_Pos","WTP4C_Pos",...
    "WTP8A_Pos","WTP8B_Pos","WTP8C_Pos","B2P2A_Pos","B2P2B_Pos","B2P2C_Pos",...
    "B2P4A_Pos","B2P4B_Pos","B2P4C_Pos","B2P8A_Pos","B2P8B_Pos","B2P8C_Pos",...
    ];
name_list_Neg = ["WTP2A_Neg","WTP2B_Neg","WTP2C_Neg","WTP4A_Neg","WTP4B_Neg","WTP4C_Neg",...
    "WTP8A_Neg","WTP8B_Neg","WTP8C_Neg","B2P2A_Neg","B2P2B_Neg","B2P2C_Neg",...
    "B2P4A_Neg","B2P4B_Neg","B2P4C_Neg","B2P8A_Neg","B2P8B_Neg","B2P8C_Neg",...
    ];
%%
indata = DBP.Pos_single_DB;
outfile = [outpath,'Pos_Pos_single.csv'];
exp9_head_writer(outfile);
for i = 1:18
    array_A = DBP.get_position_array(indata,i);
    Dist_mat = DBP.Get_Dist_2_matrix(array_A,array_A);
    Dist = DBP.Get_Dist_2_matrix_closest(array_A,array_A);
    exp9_writer(outfile,name_list_Pos(i),Dist);
end

disp('Done');
%
indata = DBP.Neg_single_DB;
outfile = [outpath,'Neg_Neg_single.csv'];
exp9_head_writer(outfile);
for i = 1:18
    array_A = DBP.get_position_array(indata,i);
    Dist_mat = DBP.Get_Dist_2_matrix(array_A,array_A);
    Dist = DBP.Get_Dist_2_matrix_closest(array_A,array_A);
    exp9_writer(outfile,name_list_Neg(i),Dist);
end
disp('Done');
%
indata = DBP.Pos_single_DB_rand;
outfile = [outpath,'Pos_Pos_single_rand.csv'];
exp9_head_writer(outfile);
for i = 1:18
    array_A = DBP.get_position_array(indata,i);
    Dist_mat = DBP.Get_Dist_2_matrix(array_A,array_A);
    Dist = DBP.Get_Dist_2_matrix_closest(array_A,array_A);
    exp9_writer(outfile,name_list_Pos(i),Dist);
end
disp('Done');
%
indata = DBP.Neg_single_DB_rand;
outfile = [outpath,'Neg_Neg_single_rand.csv'];
exp9_head_writer(outfile);
for i = 1:18
    array_A = DBP.get_position_array(indata,i);
    Dist_mat = DBP.Get_Dist_2_matrix(array_A,array_A);
    Dist = DBP.Get_Dist_2_matrix_closest(array_A,array_A);
    exp9_writer(outfile,name_list_Neg(i),Dist);
end
disp('Done');
%%
%Get the ratio of clustered vs. isolated sAZ and mAZ synapses
indata_A = DBP.Pos_single_DB;
indata_B = DBP.Pos_multi_DB;
outfile = [outpath,'Pos_Pos.csv'];
exp9_head_writer(outfile);
for i = 1:18
    array_A = DBP.get_position_array(indata_A,i);
    array_B = DBP.get_position_array(indata_B,i);
    Dist = DBP.Get_Dist_2_matrix_closest(array_B,array_A);
    Ratio_multi = (sum(Dist < 1.5) / numel(Dist));
    Dist = DBP.Get_Dist_2_matrix_closest(array_A,array_A);
    Ratio_singl = (sum(Dist < 1.5) / numel(Dist));
    exp9_writer(outfile,name_list_Pos(i),'multi',Ratio_multi);
    exp9_writer(outfile,name_list_Pos(i),'singl',Ratio_singl);
end

indata_A = DBP.Neg_single_DB;
indata_B = DBP.Neg_multi_DB;
outfile = [outpath,'Neg_Neg.csv'];
exp9_head_writer(outfile);
for i = 1:18
    array_A = DBP.get_position_array(indata_A,i);
    array_B = DBP.get_position_array(indata_B,i);
    Dist = DBP.Get_Dist_2_matrix_closest(array_B,array_A);
    Ratio_multi = (sum(Dist < 1.5) / numel(Dist));
    Dist = DBP.Get_Dist_2_matrix_closest(array_A,array_A);
    Ratio_singl = (sum(Dist < 1.5) / numel(Dist));
    exp9_writer(outfile,name_list_Neg(i),'multi',Ratio_multi);
    exp9_writer(outfile,name_list_Neg(i),'singl',Ratio_singl);
end

indata_A = DBP.Pos_single_DB_rand;
indata_B = DBP.Pos_multi_DB_rand;
outfile = [outpath,'Pos_Pos_rand.csv'];
exp9_head_writer(outfile);
for i = 1:18
    array_A = DBP.get_position_array(indata_A,i);
    array_B = DBP.get_position_array(indata_B,i);
    Dist = DBP.Get_Dist_2_matrix_closest(array_B,array_A);
    Ratio_multi = (sum(Dist < 1.5) / numel(Dist));
    Dist = DBP.Get_Dist_2_matrix_closest(array_A,array_A);
    Ratio_singl = (sum(Dist < 1.5) / numel(Dist));
    exp9_writer(outfile,name_list_Pos(i),'multi',Ratio_multi);
    exp9_writer(outfile,name_list_Pos(i),'singl',Ratio_singl);
end

indata_A = DBP.Neg_single_DB_rand;
indata_B = DBP.Neg_multi_DB_rand;
outfile = [outpath,'Neg_Neg_rand.csv'];
exp9_head_writer(outfile);
for i = 1:18
    array_A = DBP.get_position_array(indata_A,i);
    array_B = DBP.get_position_array(indata_B,i);
    Dist = DBP.Get_Dist_2_matrix_closest(array_B,array_A);
    Ratio_multi = (sum(Dist < 1.5) / numel(Dist));
    Dist = DBP.Get_Dist_2_matrix_closest(array_A,array_A);
    Ratio_singl = (sum(Dist < 1.5) / numel(Dist));
    exp9_writer(outfile,name_list_Neg(i),'multi',Ratio_multi);
    exp9_writer(outfile,name_list_Neg(i),'singl',Ratio_singl);
end
%%
%Get the ratio of clustered vs. isolated sAZ and mAZ synapses. Normalized. 
indata_A = DBP.Pos_single_DB;
indata_B = DBP.Pos_multi_DB;
outfile = [outpath,'Pos_Pos.csv'];
exp9_head_writer(outfile);
for i = 1:18
    array_A = DBP.get_position_array(indata_A,i);
    array_B = DBP.get_position_array(indata_B,i);
    size_A = size(array_A,1);
    size_B = size(array_B,1);
    array_A = array_A(randperm(size_A, size_B),:);
    Dist = DBP.Get_Dist_2_matrix_closest(array_B,array_A);
    Ratio_multi = (sum(Dist < 1.5) / numel(Dist));
    Dist = DBP.Get_Dist_2_matrix_closest(array_A,array_A);
    Ratio_singl = (sum(Dist < 1.5) / numel(Dist));
    exp9_writer(outfile,name_list_Pos(i),'multi',Ratio_multi);
    exp9_writer(outfile,name_list_Pos(i),'singl',Ratio_singl);
end

indata_A = DBP.Neg_single_DB;
indata_B = DBP.Neg_multi_DB;
outfile = [outpath,'Neg_Neg.csv'];
exp9_head_writer(outfile);
for i = 1:18
    array_A = DBP.get_position_array(indata_A,i);
    array_B = DBP.get_position_array(indata_B,i);
    size_A = size(array_A,1);
    size_B = size(array_B,1);
    array_A = array_A(randperm(size_A, size_B),:);
    Dist = DBP.Get_Dist_2_matrix_closest(array_B,array_A);
    Ratio_multi = (sum(Dist < 1.5) / numel(Dist));
    Dist = DBP.Get_Dist_2_matrix_closest(array_A,array_A);
    Ratio_singl = (sum(Dist < 1.5) / numel(Dist));
    exp9_writer(outfile,name_list_Neg(i),'multi',Ratio_multi);
    exp9_writer(outfile,name_list_Neg(i),'singl',Ratio_singl);
end

indata_A = DBP.Pos_single_DB_rand;
indata_B = DBP.Pos_multi_DB_rand;
outfile = [outpath,'Pos_Pos_rand.csv'];
exp9_head_writer(outfile);
for i = 1:18
    array_A = DBP.get_position_array(indata_A,i);
    array_B = DBP.get_position_array(indata_B,i);
    size_A = size(array_A,1);
    size_B = size(array_B,1);
    array_A = array_A(randperm(size_A, size_B),:);
    Dist = DBP.Get_Dist_2_matrix_closest(array_B,array_A);
    Ratio_multi = (sum(Dist < 1.5) / numel(Dist));
    Dist = DBP.Get_Dist_2_matrix_closest(array_A,array_A);
    Ratio_singl = (sum(Dist < 1.5) / numel(Dist));
    exp9_writer(outfile,name_list_Pos(i),'multi',Ratio_multi);
    exp9_writer(outfile,name_list_Pos(i),'singl',Ratio_singl);
end

indata_A = DBP.Neg_single_DB_rand;
indata_B = DBP.Neg_multi_DB_rand;
outfile = [outpath,'Neg_Neg_rand.csv'];
exp9_head_writer(outfile);
for i = 1:18
    array_A = DBP.get_position_array(indata_A,i);
    array_B = DBP.get_position_array(indata_B,i);
    size_A = size(array_A,1);
    size_B = size(array_B,1);
    array_A = array_A(randperm(size_A, size_B),:);
    Dist = DBP.Get_Dist_2_matrix_closest(array_B,array_A);
    Ratio_multi = (sum(Dist < 1.5) / numel(Dist));
    Dist = DBP.Get_Dist_2_matrix_closest(array_A,array_A);
    Ratio_singl = (sum(Dist < 1.5) / numel(Dist));
    exp9_writer(outfile,name_list_Neg(i),'multi',Ratio_multi);
    exp9_writer(outfile,name_list_Neg(i),'singl',Ratio_singl);
end

%%
function exp9_head_writer(outfile)
    line = ["Name","No_sample","Genotype","Age","CTB","Sample","Type","Distance"];
    writematrix(line,outfile,'WriteMode','append');
end
function exp9_writer(outfile,name,Type,df)
    name = char(name);
    No_sample = string([name(1:4),name(6:9)]);
    Genotype = string(name(1:2));
    Age = string(name(3:4));
    CTB = string(name(7:9));
    Sample = string(name(5));
    name = string(name);
    line = [name,No_sample,Genotype,Age,CTB,Sample,string(Type),string(df)];
    writematrix(line,outfile,'WriteMode','append');
end