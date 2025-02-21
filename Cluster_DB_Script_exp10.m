%% Experiment 9
clear;clc
base_folder = 'Y:\Chenghang\4_Color_Continue\';
load([base_folder 'Database\DBP.mat']);
%%
i=16;
indata = DBP.Neg_multi_DB;
indata_2 = DBP.Neg_single_DB;

    array_A = DBP.get_position_array(indata,i);
    array_B = DBP.get_position_array(indata_2,i);
    Dist = DBP.Get_Dist_2_matrix_closest(array_B,array_A);

ratio_1 = sum(Dist<1.5) / numel(Dist);
num_center = size(array_A,1);
%
indata = DBP.Neg_multi_DB_rand;
indata_2 = DBP.Neg_single_DB_rand;

    array_A = DBP.get_position_array(indata,i);
    array_B = DBP.get_position_array(indata_2,i);
    Dist = DBP.Get_Dist_2_matrix_closest(array_B,array_A);

ratio_2 = sum(Dist<1.5) / numel(Dist);
%
indata = DBP.Neg_single_DB;

    array_A = DBP.get_position_array(indata,i);
    num_all = size(array_A,1);
    sel = randperm(num_all,num_center);
    array_B = array_A(sel,:);

    Dist = DBP.Get_Dist_2_matrix_closest(array_A,array_B);

ratio_3 = sum(Dist<1.5) / numel(Dist);
%
indata = DBP.Neg_single_DB_rand;

    array_A = DBP.get_position_array(indata,i);
    num_all = size(array_A,1);
    sel = randperm(num_all,num_center);
    array_B = array_A(sel,:);

    Dist = DBP.Get_Dist_2_matrix_closest(array_A,array_B);

ratio_4 = sum(Dist<1.5) / numel(Dist);
%
ratio = [ratio_1,ratio_2,ratio_3,ratio_4]
normalized = [ratio_1/ratio_2,ratio_3/ratio_4]
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