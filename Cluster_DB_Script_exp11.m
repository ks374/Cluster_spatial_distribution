
%% Experiment 11
clear;clc
base_folder = 'Y:\Chenghang\4_Color_Continue\';
load([base_folder 'Database\DBP.mat']);
outfile_pos = 'Y:\Chenghang\4_Color_Continue\Database\Experiment_11\Raw_pos.csv';
outfile_neg = 'Y:\Chenghang\4_Color_Continue\Database\Experiment_11\Raw_neg.csv';
exp11_head_writer(outfile_pos);
exp11_head_writer(outfile_neg);
%
name_list_Pos = ["WTP2A_Pos","WTP2B_Pos","WTP2C_Pos","WTP4A_Pos","WTP4B_Pos","WTP4C_Pos",...
    "WTP8A_Pos","WTP8B_Pos","WTP8C_Pos","B2P2A_Pos","B2P2B_Pos","B2P2C_Pos",...
    "B2P4A_Pos","B2P4B_Pos","B2P4C_Pos","B2P8A_Pos","B2P8B_Pos","B2P8C_Pos",...
    ];
name_list_Neg = ["WTP2A_Neg","WTP2B_Neg","WTP2C_Neg","WTP4A_Neg","WTP4B_Neg","WTP4C_Neg",...
    "WTP8A_Neg","WTP8B_Neg","WTP8C_Neg","B2P2A_Neg","B2P2B_Neg","B2P2C_Neg",...
    "B2P4A_Neg","B2P4B_Neg","B2P4C_Neg","B2P8A_Neg","B2P8B_Neg","B2P8C_Neg",...
    ];
%%
%Without random picker. 
for i=1:18
    disp(i);
    name = char(name_list_Pos(i));
    indata = DBP.Pos_multi_DB;
    indata_2 = DBP.Pos_single_DB;
    array_A = DBP.get_position_array(indata,i);
    array_B = DBP.get_position_array(indata_2,i);
    Dist = DBP.Get_Dist_2_matrix_closest(array_A,array_B);

    exp11_writer(outfile_pos,name,Dist);

    name = char(name_list_Neg(i));
    indata = DBP.Neg_multi_DB;
    indata_2 = DBP.Neg_single_DB;
    array_A = DBP.get_position_array(indata,i);
    array_B = DBP.get_position_array(indata_2,i);
    Dist = DBP.Get_Dist_2_matrix_closest(array_A,array_B);

    exp11_writer(outfile_neg,name,Dist);
end
%%
%With random picker (normalize): 
for i=1:18
    disp(i);
    name = char(name_list_Neg(i));
    indata = DBP.Neg_multi_DB;
    indata_2 = DBP.Neg_single_DB;
    array_A = DBP.get_position_array(indata,i);
    array_B = DBP.get_position_array(indata_2,i);
    num_neg = size(array_B,1);
    Dist = DBP.Get_Dist_2_matrix_closest(array_A,array_B);

    exp11_writer(outfile_neg,name,Dist);
    
    
    name = char(name_list_Pos(i));
    indata = DBP.Pos_multi_DB;
    indata_2 = DBP.Pos_single_DB;
    array_A = DBP.get_position_array(indata,i);
    array_B = DBP.get_position_array(indata_2,i);
    num_pos = size(array_B,1);
    if num_pos > num_neg
        sel = randperm(num_pos,num_neg);
    else
        sel = randi(num_pos,num_neg,1);
    end
    array_B = array_B(sel,:);
    Dist = DBP.Get_Dist_2_matrix_closest(array_A,array_B);

    exp11_writer(outfile_pos,name,Dist); 
end
%%
%Normalized, random synapse property assignment. 
%
for i=1:18
    disp(i);
    name = char(name_list_Neg(i));
    indata = DBP.Neg_multi_DB;
    indata_2 = DBP.Neg_single_DB;
    array_A = DBP.get_position_array(indata,i);
    array_B = DBP.get_position_array(indata_2,i);
    num_neg = size(array_B,1);
    [array_A_2,array_B_2] = exp11_property_shuffle(array_A,array_B);
    Dist = DBP.Get_Dist_2_matrix_closest(array_A_2,array_B_2);

    exp11_writer(outfile_neg,name,Dist);
    
    
    name = char(name_list_Pos(i));
    indata = DBP.Pos_multi_DB;
    indata_2 = DBP.Pos_single_DB;
    array_A = DBP.get_position_array(indata,i);
    array_B = DBP.get_position_array(indata_2,i);
    num_pos = size(array_B,1);
    if num_pos > num_neg
        sel = randperm(num_pos,num_neg);
    else
        sel = randi(num_pos,num_neg,1);
    end
    array_B = array_B(sel,:);
    [array_A_2,array_B_2] = exp11_property_shuffle(array_A,array_B);
    Dist = DBP.Get_Dist_2_matrix_closest(array_A_2,array_B_2);

    exp11_writer(outfile_pos,name,Dist); 
end
%%
%Data writer: 
function exp11_head_writer(outfile)
    line = ["Name","No_sample","Genotype","Age","CTB","Sample","Index","Distance"];
    writematrix(line,outfile,'WriteMode','append');
end
function exp11_writer(outfile,name,df)
    size_df = numel(df);
    No_sample = string([name(1:4),name(6:9)]);
    Genotype = string(name(1:2));
    Age = string(name(3:4));
    CTB = string(name(6:9));
    Sample = string(name(5));
    name = string(name);
    for i = 1:size_df
        line = [name,No_sample,Genotype,Age,CTB,Sample,string(i),string(df(i))];
        writematrix(line,outfile,'WriteMode','append');
    end
end
function [array_A_2,array_B_2] = exp11_property_shuffle(array_A,array_B)
    array_all = [array_A;array_B];
    array_all(randperm(size(array_all,1)),:);
    array_A_2 = array_all(1:size(array_A,1),:);
    array_B_2 = array_all(size(array_A,1):end,:);
end