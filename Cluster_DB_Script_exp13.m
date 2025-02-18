
%% Experiment 13
%Obtain clustered mAZ synapses and get its distance to CTB-specific
%clsutered or isolated mAZ synapses. 
clear;clc
base_folder = 'E:\File\Work\2024\eLife manuscript\';
load([base_folder 'Data\V7_Contain_all_raw\DBP.mat']);

outpath = 'E:\File\Work\2024\eLife manuscript\Experiment_13_figure4_revisit\';
outfile = [outpath 'Exp13_all.csv'];
exp13_head_writer(outfile);

name_list_Pos = ["WTP2A_Pos","WTP2B_Pos","WTP2C_Pos","WTP4A_Pos","WTP4B_Pos","WTP4C_Pos",...
    "WTP8A_Pos","WTP8B_Pos","WTP8C_Pos","B2P2A_Pos","B2P2B_Pos","B2P2C_Pos",...
    "B2P4A_Pos","B2P4B_Pos","B2P4C_Pos","B2P8A_Pos","B2P8B_Pos","B2P8C_Pos",...
    ];
name_list_Neg = ["WTP2A_Neg","WTP2B_Neg","WTP2C_Neg","WTP4A_Neg","WTP4B_Neg","WTP4C_Neg",...
    "WTP8A_Neg","WTP8B_Neg","WTP8C_Neg","B2P2A_Neg","B2P2B_Neg","B2P2C_Neg",...
    "B2P4A_Neg","B2P4B_Neg","B2P4C_Neg","B2P8A_Neg","B2P8B_Neg","B2P8C_Neg",...
    ];

%%
for i = 1:18
    disp(i);
    name = char(name_list_Pos(i));
    indata = DBP.Pos_multi_DB;
    indata_surround = DBP.Pos_single_DB;
    indata_2 = DBP.Pos_multi_DB;
    indata_2_surround = DBP.Pos_single_DB;
    array_A = DBP.get_position_array(indata,i);
    array_A_surround = DBP.get_position_array(indata_surround,i);
    array_B = DBP.get_position_array(indata_2,i);
    array_B_surround = DBP.get_position_array(indata_2_surround,i);
    
    array_A_clustered_id = get_clu_array(DBP,array_A,array_A_surround);
    array_B_clustered_id = get_clu_array(DBP,array_B,array_B_surround);
    
    array_A_clustered = array_A(array_A_clustered_id,:);
    array_B_clustered = array_B(array_B_clustered_id,:);
    array_A_isolated = array_A(~array_A_clustered_id,:);
    array_B_isolated = array_B(~array_B_clustered_id,:);
    
    Dist_clu = DBP.Get_Dist_2_matrix_closest(array_B_clustered,array_A_clustered);
    Dist_iso = DBP.Get_Dist_2_matrix_closest(array_B_isolated,array_A_clustered);
    
    exp13_writer(outfile,name,"Pos_Pos","clu",Dist_clu);
    exp13_writer(outfile,name,"Pos_Pos","iso",Dist_iso);
end
%
for i = 1:18
    disp(i);
    name = char(name_list_Pos(i));
    indata = DBP.Pos_multi_DB;
    indata_surround = DBP.Pos_single_DB;
    indata_2 = DBP.Neg_multi_DB;
    indata_2_surround = DBP.Neg_single_DB;
    array_A = DBP.get_position_array(indata,i);
    array_A_surround = DBP.get_position_array(indata_surround,i);
    array_B = DBP.get_position_array(indata_2,i);
    array_B_surround = DBP.get_position_array(indata_2_surround,i);
    
    array_A_clustered_id = get_clu_array(DBP,array_A,array_A_surround);
    array_B_clustered_id = get_clu_array(DBP,array_B,array_B_surround);
    
    array_A_clustered = array_A(array_A_clustered_id,:);
    array_B_clustered = array_B(array_B_clustered_id,:);
    array_A_isolated = array_A(~array_A_clustered_id,:);
    array_B_isolated = array_B(~array_B_clustered_id,:);
    
    Dist_clu = DBP.Get_Dist_2_matrix_closest(array_B_clustered,array_A_clustered);
    Dist_iso = DBP.Get_Dist_2_matrix_closest(array_B_isolated,array_A_clustered);
    
    exp13_writer(outfile,name,"Neg_Pos","clu",Dist_clu);
    exp13_writer(outfile,name,"Neg_Pos","iso",Dist_iso);
end
%
for i = 1:18
    disp(i);
    name = char(name_list_Pos(i));
    indata = DBP.Neg_multi_DB;
    indata_surround = DBP.Neg_single_DB;
    indata_2 = DBP.Pos_multi_DB;
    indata_2_surround = DBP.Pos_single_DB;
    array_A = DBP.get_position_array(indata,i);
    array_A_surround = DBP.get_position_array(indata_surround,i);
    array_B = DBP.get_position_array(indata_2,i);
    array_B_surround = DBP.get_position_array(indata_2_surround,i);
    
    array_A_clustered_id = get_clu_array(DBP,array_A,array_A_surround);
    array_B_clustered_id = get_clu_array(DBP,array_B,array_B_surround);
    
    %if size(array_A_clustered,1) == 1
    %    arrary_A_clustered_id(1) = 1;
    %end
    
    array_A_clustered = array_A(array_A_clustered_id,:);
    array_B_clustered = array_B(array_B_clustered_id,:);
    array_A_isolated = array_A(~array_A_clustered_id,:);
    array_B_isolated = array_B(~array_B_clustered_id,:);
    
    
        
    
    Dist_clu = DBP.Get_Dist_2_matrix_closest(array_B_clustered,array_A_clustered);
    Dist_iso = DBP.Get_Dist_2_matrix_closest(array_B_isolated,array_A_clustered);
    
    exp13_writer(outfile,name,"Pos_Neg","clu",Dist_clu);
    exp13_writer(outfile,name,"Pos_Neg","iso",Dist_iso);
end
%
for i = 1:18
    disp(i);
    name = char(name_list_Pos(i));
    indata = DBP.Neg_multi_DB;
    indata_surround = DBP.Neg_single_DB;
    indata_2 = DBP.Neg_multi_DB;
    indata_2_surround = DBP.Neg_single_DB;
    array_A = DBP.get_position_array(indata,i);
    array_A_surround = DBP.get_position_array(indata_surround,i);
    array_B = DBP.get_position_array(indata_2,i);
    array_B_surround = DBP.get_position_array(indata_2_surround,i);
    
    array_A_clustered_id = get_clu_array(DBP,array_A,array_A_surround);
    array_B_clustered_id = get_clu_array(DBP,array_B,array_B_surround);
    
    array_A_clustered = array_A(array_A_clustered_id,:);
    array_B_clustered = array_B(array_B_clustered_id,:);
    array_A_isolated = array_A(~array_A_clustered_id,:);
    array_B_isolated = array_B(~array_B_clustered_id,:);
    
    Dist_clu = DBP.Get_Dist_2_matrix_closest(array_B_clustered,array_A_clustered);
    Dist_iso = DBP.Get_Dist_2_matrix_closest(array_B_isolated,array_A_clustered);
    
    exp13_writer(outfile,name,"Neg_Neg","clu",Dist_clu);
    exp13_writer(outfile,name,"Neg_Neg","iso",Dist_iso);
end
%% Exp13 function
function clustered_id = get_clu_array(DBP,array_A,array_A_surround)
    Dist_A = DBP.Get_Dist_2_matrix_closest(array_A,array_A_surround);
    clustered_id = (Dist_A < 1.5);
end
function exp13_head_writer(outfile)
    line = ["Name","No_sample","Genotype","Age","CTB","Sample","Type","Index","Distance"];
    writematrix(line,outfile,'WriteMode','append');
end
function exp13_writer(outfile,name,CTB,type,df)
    size_df = numel(df);
    No_sample = string([name(1:4),name(7:9)]);
    Genotype = string(name(1:2));
    Age = string(name(3:4));
    CTB = string(CTB);
    Sample = string(name(5));
    name = string(name);
    for i = 1:size_df
        line = [name,No_sample,Genotype,Age,CTB,Sample,type,string(i),string(df(i))];
        writematrix(line,outfile,'WriteMode','append');
    end
end