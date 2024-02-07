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
%%
DB_A = "Pos_single_DB";
DB_B = "Pos_multi_DB";
cor_mat = DBP.get_position_correlation(DB_A,DB_A,DB_B);
%%
DB_A = "Pos_single_DB_rand";
DB_B = "Pos_multi_DB";
cor_mat_rand = DBP.get_position_correlation(DB_A,DB_A,DB_B);
%%
DBP.check_postion_correlation_one(cor_mat,1);
DBP.check_postion_correlation_one(cor_mat_rand,1);
DBP.check_postion_correlation_one(cor_mat,4);
DBP.check_postion_correlation_one(cor_mat_rand,4);
DBP.check_postion_correlation_one(cor_mat,7);
DBP.check_postion_correlation_one(cor_mat_rand,7);
DBP.check_postion_correlation_one(cor_mat,13);
DBP.check_postion_correlation_one(cor_mat_rand,13);
DBP.check_position_correlation_one_histogram(cor_mat,4);
DBP.check_position_correlation_one_histogram(cor_mat_rand,4);
%%
[ratios_orig,kept_ratios_orig] = DBP.Batch_modified_close_check('Pos_single_DB','Pos_multi_DB',1.5);
%%
[ratios_rand,kept_ratios_rand] = DBP.Batch_modified_close_check('Pos_single_DB_rand','Pos_multi_DB_rand',1.5);