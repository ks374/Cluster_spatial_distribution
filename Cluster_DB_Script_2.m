%For publication data/figure generation
clear;clc;
infile = 'Y:\Chenghang\4_Color_Continue\Database\DB_all.csv';
DBP = DB_processor(infile);
DBP = DBP.splitter();
%
%Generate a batch of randomzed data
DBP = DBP.init_rand_DB();
DBP_rand = [];
for i = 1:100
    DBP = DBP.batch_experiment4minus1_randomization(rand(3,1));
    DBP_rand = cat(1,DBP_rand,DBP);
end
%%
%Experiment 2a
outpath_2a = 'Y:\Chenghang\4_Color_Continue\Database\Experiment_2.1\';
n=10;
DBP.batch_rpl_generater_and_save(outpath_2a,n);
%%
clc;
outfile = [outpath_2a,'Pos_single.csv'];
DB_A = "Pos_single_DB";
DB_B = "Pos_single_DB";
ratios_temp = DBP.batch_close_check(DB_A,DB_B,1.5);
DB_A = "Pos_single_DB";
DB_B = "Pos_single_DB_rand";
ratios = DBP.batch_close_check_rand(DBP_rand,DB_A,DB_B,1.5);
ratios = cat(2,ratios_temp,ratios);
DBP.ratios_writer(ratios,outfile);
%%
clc
outfile = [outpath_2a,'Neg_single.csv'];
DB_A = "Neg_single_DB";
DB_B = "Neg_single_DB";
ratios_temp = DBP.batch_close_check(DB_A,DB_B,1.5);
DB_A = "Neg_single_DB";
DB_B = "Neg_single_DB_rand";
ratios = DBP.batch_close_check_rand(DBP_rand,DB_A,DB_B,1.5);
ratios = cat(2,ratios_temp,ratios);
DBP.ratios_writer(ratios,outfile);
%%
clc
outfile = [outpath_2a,'Pos_multi.csv'];
DB_A = "Pos_single_DB";
DB_B = "Pos_multi_DB";
ratios_temp = DBP.batch_close_check(DB_A,DB_B,1.5);
DB_A = "Pos_single_DB_rand";
DB_B = "Pos_multi_DB";
ratios = DBP.batch_close_check_rand(DBP_rand,DB_A,DB_B,1.5);
ratios = cat(2,ratios_temp,ratios);
DBP.ratios_writer(ratios,outfile);
%
outfile = [outpath_2a,'Neg_multi.csv'];
DB_A = "Neg_single_DB";
DB_B = "Neg_multi_DB";
ratios_temp = DBP.batch_close_check(DB_A,DB_B,1.5);
DB_A = "Neg_single_DB_rand";
DB_B = "Neg_multi_DB";
ratios = DBP.batch_close_check_rand(DBP_rand,DB_A,DB_B,1.5);
ratios = cat(2,ratios_temp,ratios);
DBP.ratios_writer(ratios,outfile);
%%
%Experiment 2.3
clc
outpath = 'Y:\Chenghang\4_Color_Continue\Database\Experiment_2.3\';
DBP.Exp2_3_rand_generator(outpath,100);
load([outpath,'DBP_rand.mat']);
%
%Experiment 2.3 data generation. 
clc
outfile = [outpath,'Pos_multi.csv'];
DB_A = "Pos_single_DB";
DB_B = "Pos_multi_DB";
ratios_temp = DBP.batch_close_check(DB_A,DB_B,1.5);
DB_A = "Pos_single_DB_rand";
DB_B = "Pos_multi_DB_rand";
ratios = DBP.batch_close_check_rand(DBP_rand,DB_A,DB_B,1.5);
ratios = cat(2,ratios_temp,ratios);
DBP.ratios_writer(ratios,outfile);
%
outfile = [outpath,'Neg_multi.csv'];
DB_A = "Neg_single_DB";
DB_B = "Neg_multi_DB";
ratios_temp = DBP.batch_close_check(DB_A,DB_B,1.5);
DB_A = "Neg_single_DB_rand";
DB_B = "Neg_multi_DB_rand";
ratios = DBP.batch_close_check_rand(DBP_rand,DB_A,DB_B,1.5);
ratios = cat(2,ratios_temp,ratios);
DBP.ratios_writer(ratios,outfile);