%% Experiment 9
clear;clc
base_folder = 'E:\File\Work\2024\eLife manuscript\Data\V7_Contain_all_raw\';
load([base_folder 'DBP.mat']);
outpath = 'E:\File\Work\2024\eLife manuscript\Data\Experiment_10_Figure3_normalized\Average_Number\';
%%
%clc
i=18;


ratio = zeros(1,4);
indata = DBP.Pos_multi_DB;
indata_2 = DBP.Pos_single_DB;

    array_A = DBP.get_position_array(indata,i);
    array_B = DBP.get_position_array(indata_2,i);
    Dist = DBP.Get_Dist_2_matrix_closest(array_B,array_A);
    
    Dist_2 = DBP.Get_Dist_2_matrix_closest(array_A,array_B);
    numel_clustered = sum(Dist_2 < 1.5);

ratio(1) = sum(Dist<1.5) / size(array_A,1);
ratio(2) = sum(Dist<1.5) / numel_clustered ;
%ratio_1 = sum(Dist<1.5) / size(array_A,1); %get the number of close sAZ divided by all multi
num_center = size(array_A,1);
%
%indata = DBP.Neg_multi_DB_rand;
%indata_2 = DBP.Neg_single_DB_rand;

%    array_A = DBP.get_position_array(indata,i);
%    array_B = DBP.get_position_array(indata_2,i);
%    Dist = DBP.Get_Dist_2_matrix_closest(array_B,array_A);

%ratio_2 = sum(Dist<1.5) / numel(Dist);
%
indata = DBP.Pos_single_DB;

    array_A = DBP.get_position_array(indata,i);
    num_all = size(array_A,1);
    sel = randperm(num_all,num_center);
    array_B = array_A(sel,:);

    Dist = DBP.Get_Dist_2_matrix_closest(array_A,array_B);
    Dist_2 = DBP.Get_Dist_2_matrix_closest(array_B,array_A);
    numel_clustered = sum(Dist_2 < 1.5);

ratio(3) = sum(Dist<1.5) / numel(sel);
ratio(4) = sum(Dist<1.5) / numel_clustered ;
disp(ratio);
%
%indata = DBP.Neg_single_DB_rand;

%    array_A = DBP.get_position_array(indata,i);
%    num_all = size(array_A,1);
%    sel = randperm(num_all,num_center);
%    array_B = array_A(sel,:);

%    Dist = DBP.Get_Dist_2_matrix_closest(array_A,array_B);

%ratio_4 = sum(Dist<1.5) / numel(Dist);
%
%ratio = [ratio_1,ratio_2,ratio_3,ratio_4]
%normalized = [ratio_1/ratio_2,ratio_3/ratio_4]
%%
i=18;
indata = DBP.Pos_multi_DB;
indata_2 = DBP.Pos_single_DB;

    array_A = DBP.get_position_array(indata,i);
    array_B = DBP.get_position_array(indata_2,i);
    Dist = DBP.Get_Dist_2_matrix_closest(array_B,array_A);

ratio_1 = sum(Dist<1.5) / numel(Dist);
num_center = size(array_A,1);
%
indata = DBP.Pos_multi_DB_rand;
indata_2 = DBP.Pos_single_DB_rand;

    array_A = DBP.get_position_array(indata,i);
    array_B = DBP.get_position_array(indata_2,i);
    Dist = DBP.Get_Dist_2_matrix_closest(array_B,array_A);

ratio_2 = sum(Dist<1.5) / numel(Dist);
%
indata = DBP.Pos_single_DB;

    array_A = DBP.get_position_array(indata,i);
    num_all = size(array_A,1);
    sel = randperm(num_all,num_center);
    array_B = array_A(sel,:);

    Dist = DBP.Get_Dist_2_matrix_closest(array_A,array_B);

ratio_3 = sum(Dist<1.5) / numel(Dist);
%
indata = DBP.Pos_single_DB_rand;

    array_A = DBP.get_position_array(indata,i);
    num_all = size(array_A,1);
    sel = randperm(num_all,num_center);
    array_B = array_A(sel,:);

    Dist = DBP.Get_Dist_2_matrix_closest(array_A,array_B);

ratio_4 = sum(Dist<1.5) / numel(Dist);
%
ratio = [ratio_1,ratio_2,ratio_3,ratio_4]
normalized = [ratio_1/ratio_2,ratio_3/ratio_4]