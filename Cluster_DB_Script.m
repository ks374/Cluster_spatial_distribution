clear;clc;
inpath = 'Y:\Chenghang\4_Color_Continue\Raw\';
DBfile = 'Y:\Chenghang\4_Color_Continue\Database\DB_all.csv';
CDB = Cluster_DB(inpath);
CDB.Write_basic_DB(DBfile);
%%
DBP = DB_processor(outfile);
DBP = DBP.splitter();
%%
DB_A = "Pos_single_DB";
DB_B = "Pos_multi_DB";
temp_ratios = DBP.batch_close_check(DB_A,DB_B,1.5);
%%
DB_A = "Pos_single_DB";
DB_B = "Pos_single_DB";
temp_ratios = DBP.batch_close_check(DB_A,DB_B,1.5);
disp(temp_ratios);
%%
DBP = DBP.init_rand_DB();
DBP = DBP.rpl_generator(1);
%%
DB_A = "Pos_single_DB_rand";
DB_B = "Pos_single_DB_rand";
temp_ratios = DBP.batch_close_check(DB_A,DB_B,1.5);
disp(temp_ratios);
%%
DBP = DBP.init_rand_DB();
DBP = DBP.rpl_generator(2);
DB_A = "Pos_single_DB_rand";
DB_B = "Pos_single_DB_rand";
temp_ratios = DBP.batch_close_check(DB_A,DB_B,1.5);
disp(temp_ratios);