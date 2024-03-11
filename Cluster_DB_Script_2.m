%For publication data/figure generation
clear;clc;
infile = 'Y:\Chenghang\4_Color_Continue\Database\DB_all.csv';
DBP = DB_processor(infile);
DBP = DBP.splitter();
%
%Generate a batch of randomzed data
DBP = DBP.init_rand_DB();
DBP_rand = [];
for i = 1:10
    DBP = DBP.batch_experiment4minus1_randomization(rand(3,1));
    DBP_rand = cat(1,DBP_rand,DBP);
end
%%
clc;
DB_A = "Pos_single_DB";
DB_B = "Pos_single_DB";
disp(DBP.batch_close_check(DB_A,DB_B,1.5));
DB_A = "Pos_single_DB_rand";
DB_B = "Pos_single_DB_rand";
disp(DBP.batch_close_check_rand(DBP_rand,DB_A,DB_B,1.5));
%
DB_A = "Neg_single_DB";
DB_B = "Neg_single_DB";
disp(DBP.batch_close_check(DB_A,DB_B,1.5));
DB_A = "Neg_single_DB_rand";
DB_B = "Neg_single_DB_rand";
disp(DBP.batch_close_check_rand(DBP_rand,DB_A,DB_B,1.5));