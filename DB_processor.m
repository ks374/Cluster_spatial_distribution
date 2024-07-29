classdef DB_processor
    %Offer methods to deal with cluster DB .csv/,xlsx files. 
    
    properties
        All_DB table; 
        Pos_DB table;
        Neg_DB table;
        Pos_multi_DB table;
        Pos_single_DB table;
        Neg_multi_DB table;
        Neg_single_DB table;

        All_DB_rand table; 
        Pos_DB_rand table;
        Neg_DB_rand table;
        Pos_multi_DB_rand table;
        Pos_single_DB_rand table;
        Neg_multi_DB_rand table;
        Neg_single_DB_rand table;

        Sample_name_list = {'WTP2_A','WTP2_B','WTP2_C','WTP4_A','WTP4_B','WTP4_C',...
                'WTP8_A','WTP8_B','WTP8_C','B2P2_A','B2P2_B','B2P2_C',...
                'B2P4_A','B2P4_B','B2P4_C','B2P8_A','B2P8_B','B2P8_C'};
        Image_folder_list = {'Y:\Chenghang\Backup_Raw_Data\1.2.2021_P2EA_B\',...
            'Y:\Chenghang\Backup_Raw_Data\1.4.2021_P2EB_B\',...
            'Y:\Chenghang\4_Color\Raw\1.6.2021_P2EC_B\',...
            'Y:\Chenghang\Backup_Raw_Data\7.29.2020_P4EB\',...
            'Y:\Chenghang\Backup_Raw_Data\9.25.2020_P4EC_B\',...
            'Y:\Chenghang\Backup_Raw_Data\12.5.2020_P4ED_B\',...
            'Y:\Chenghang\Backup_Raw_Data\12.21.2020_P8EA_B\',...
            'Y:\Chenghang\4_Color\Raw\12.23.2020_P8EB_B\',...
            'Y:\Chenghang\4_Color\Raw\1.12.2021_P8EC_B\',...
            'Y:\Chenghang\Backup_Raw_Data\9.29.2020_B2P2A_B\',...
            'Y:\Chenghang\4_Color\Raw\12.13.2020_B2P2B_B\',...
            'Y:\Chenghang\Backup_Raw_Data\12.18.2020_B2P2C_B\',...
            'Y:\Chenghang\Backup_Raw_Data\10.3.2020_B2P4A_B\',...
            'Y:\Chenghang\Backup_Raw_Data\10.27.2020_B2P4B_B\',...
            'Y:\Chenghang\Backup_Raw_Data\12.8.2020_B2P4C_B\',...
            'Y:\Chenghang\Backup_Raw_Data\12.12.2020_B2P8A_B\',...
            'Y:\Chenghang\4_Color\Raw\1.13.2021_B2P8B_B\',...
            'Y:\Chenghang\4_Color\Raw\1.11.2021_B2P8C_B\'
            };
        typical_linear_size double; %To save .mat files for experiments. 
    end
    
    methods
        %Initialize the class by reading the .csv file from Cluster_DB.m. 
        function obj = DB_processor(infile)
            obj.All_DB = obj.get_indata(infile);
            obj.typical_linear_size = [0.3379,0.22508] / 2;
        end
        function indata = get_indata(~,infile)
            opts = detectImportOptions(infile);
            indata = readtable(infile,opts);
        end
        %-----------------------------------------------------------------
        %Following section is used to initialize all DBs. 
        function obj = splitter(obj)
            obj.Pos_DB = obj.All_DB(obj.get_pos(obj.All_DB),:);
            obj.Neg_DB = obj.All_DB(obj.get_neg(obj.All_DB),:);
            obj.Pos_multi_DB = obj.Pos_DB(obj.get_multi(obj.Pos_DB),:);
            obj.Pos_single_DB = obj.Pos_DB(obj.get_single(obj.Pos_DB),:);
            obj.Neg_multi_DB = obj.Neg_DB(obj.get_multi(obj.Neg_DB),:);
            obj.Neg_single_DB = obj.Neg_DB(obj.get_single(obj.Neg_DB),:);
        end
        function out_IDs = get_multi(~,indata)
            out_IDs = indata.('AZ_') > 1;
        end
        function out_IDs = get_single(~,indata)
            out_IDs = indata.('AZ_') <= 1;
        end
        function out_IDs = get_pos(~,indata)
            out_IDs = string(cell2mat(indata.('CTB'))) == "Pos";
        end
        function out_IDs = get_neg(~,indata)
            out_IDs = string(cell2mat(indata.('CTB'))) == "Neg";
        end

        %-----------------------------------------------------------------
        %Utility functions for DB or array processing. 
        function the_array = get_position_array(obj,indata,i)
            %i stands for experiment ID, range 1-18. 
            Cur_name = obj.Sample_name_list{i};
            Cur_ID = string(cell2mat(indata.('Sample'))) == string(Cur_name);
            the_array = table2array(indata(Cur_ID,6:8));
        end
        function Dist_mat = Get_Dist_2_matrix(~,Matrix_A,Matrix_B)
            %Get distance from matrix A to matrix B. 
            Dist_mat = zeros(size(Matrix_A,1),10);
            for i = 1:size(Matrix_A,1)
                dist = sqrt(((Matrix_B(:,1)-Matrix_A(i,1))*0.0155).^2 +...
                        ((Matrix_B(:,2)-Matrix_A(i,2))*0.0155).^2 +...
                        ((Matrix_B(:,3)-Matrix_A(i,3))*0.07).^2);
                dist = sort(dist);
                dist = dist(1:10);
                Dist_mat(i,:) = dist;
            end
        end
        function Dist = Get_Dist_2_matrix_closest(obj,array_A,array_B)
            Dist_mat = obj.Get_Dist_2_matrix(array_A,array_B);
            Dist_mat = obj.delete_0_from_distmat(Dist_mat);
            Dist = Dist_mat(:,1);
        end
        function array_out = delete_0_from_distmat(~,array_in)
            array_out = array_in;
            for i = 1:size(array_in,1)
                content_index = find(array_in(i,:));
                if numel(content_index) == 0
                    array_out(i,1) = 999999;
                else
                    content_index = content_index(1);
                    array_out(i,1) = array_in(i,content_index);
                end
            end
        end
        function Logical_list = close_check_ID(obj,Matrix_A,Matrix_B,thre)
            %Get logical ID of cluster As that are close to cluster Bs. 
            Dist_mat = obj.Get_Dist_2_matrix(Matrix_A,Matrix_B);
            Dist_mat = obj.delete_0_from_distmat(Dist_mat);
            Logical_list = Dist_mat(:,1)<thre;
        end
        function num = get_curr_sample_pl_length(obj,DB_name,i)
            Cur_name = obj.Sample_name_list{i};
            Cur_ID = string(cell2mat(obj.(DB_name).('Sample'))) == string(Cur_name);
            num = numel(find(Cur_ID));
        end

        %-----------------------------------------------------------------
        %Utility function specific to a target image set. 
        function [num_images,Height,Width] = get_stack_info(obj,i)
            inpath = obj.Image_folder_list{i};
            inpath = [inpath 'analysis\Result\1_soma\'];
            files = dir([inpath '*.tif']);
            infos = imfinfo([inpath files(1).name]);
            num_images = numel(files);
            Height = infos.Height;
            Width = infos.Width;
        end
        function soma_images = get_soma_mask(obj,i)
            inpath = obj.Image_folder_list{i};
            inpath = [inpath 'analysis\Result\1_soma\'];
            files = dir([inpath '*.tif']);
            [num_images,Height,Width] = obj.get_stack_info(i);
            soma_images = zeros(Height,Width,num_images,'uint8');
            parfor j = 1:num_images
                soma_images(:,:,j) = imread([inpath,files(j).name]);
            end
            soma_images = logical(soma_images);
        end
        function pix_list = get_neuropile_pix_list(~,soma_images)
            soma_images = ~soma_images;
            [x,y,z] = ind2sub(size(soma_images),find(soma_images));
            pix_list = cat(2,x,y,z);
        end

        %-----------------------------------------------------------------
        %Utility functions to generate randomized data. 
        function rand_position_list = get_rand_positions(obj,i,num)
            [num_images,Height,Width] = obj.get_stack_info(i);
            image_matrix = [Height,0,0;0,Width,0;0,0,num_images];
            rand_position_list = rand(num,3) * image_matrix;
        end
        function rand_position_list_somaout = rand_position_checker(obj,i,rpl)
            num = size(rpl,1);
            soma_images = obj.get_soma_mask(i);
            [num_images,Height,Width] = obj.get_stack_info(i);
            for j = 1:num
                while soma_images(ceil(rpl(j,1)),ceil(rpl(j,2)),ceil(rpl(j,3))) == 1
                    new_pos = rand(1,3).*[Height,Width,num_images];
                    rpl(j,:) = new_pos;
                end
            end
            rand_position_list_somaout = rpl;
        end
        function obj = init_rand_DB(obj)
            obj.All_DB_rand = obj.All_DB;
            obj.Pos_DB_rand = obj.Pos_DB;
            obj.Neg_DB_rand = obj.Neg_DB;
            obj.Pos_multi_DB_rand = obj.Pos_multi_DB;
            obj.Pos_single_DB_rand = obj.Pos_single_DB;
            obj.Neg_multi_DB_rand = obj.Neg_multi_DB;
            obj.Neg_single_DB_rand = obj.Neg_single_DB;
        end
        function obj = push_to_randDB(obj,i,DB_name,rpl)
            new_DB_name = [DB_name,'_rand'];
            new_DB = obj.(new_DB_name);
            Cur_name = obj.Sample_name_list{i};
            Cur_ID = string(cell2mat(new_DB.('Sample'))) == string(Cur_name);
            new_DB{Cur_ID,6:8} = rpl;
            obj.(new_DB_name) = new_DB;
        end
        function obj = rpl_generator(obj,type)
            for i = 1:18
                num = obj.get_curr_sample_pl_length('All_DB',i);
                All_DB_rpl = get_rand_positions(obj,i,num);
                num = obj.get_curr_sample_pl_length('Pos_DB',i);
                Pos_DB_rpl = get_rand_positions(obj,i,num);
                num = obj.get_curr_sample_pl_length('Neg_DB',i);
                Neg_DB_rpl = get_rand_positions(obj,i,num);
                num = obj.get_curr_sample_pl_length('Pos_multi_DB',i);
                Pos_multi_DB_rpl = get_rand_positions(obj,i,num);
                num = obj.get_curr_sample_pl_length('Pos_single_DB',i);
                Pos_single_DB_rpl = get_rand_positions(obj,i,num);
                num = obj.get_curr_sample_pl_length('Neg_multi_DB',i);
                Neg_multi_DB_rpl = get_rand_positions(obj,i,num);
                num = obj.get_curr_sample_pl_length('Neg_single_DB',i);
                Neg_single_DB_rpl = get_rand_positions(obj,i,num);
                if type==2
                    %do soma exclusive
                    All_DB_rpl = obj.rand_position_checker(i,All_DB_rpl);
                    Pos_DB_rpl = obj.rand_position_checker(i,Pos_DB_rpl);
                    Neg_DB_rpl = obj.rand_position_checker(i,Neg_DB_rpl);
                    Pos_multi_DB_rpl = obj.rand_position_checker(i,Pos_multi_DB_rpl);
                    Pos_single_DB_rpl = obj.rand_position_checker(i,Pos_single_DB_rpl);
                    Neg_multi_DB_rpl = obj.rand_position_checker(i,Neg_multi_DB_rpl);
                    Neg_single_DB_rpl = obj.rand_position_checker(i,Neg_single_DB_rpl);
                end
                obj = obj.push_to_randDB(i,'All_DB',All_DB_rpl);
                obj = obj.push_to_randDB(i,'Pos_DB',Pos_DB_rpl);
                obj = obj.push_to_randDB(i,'Neg_DB',Neg_DB_rpl);
                obj = obj.push_to_randDB(i,'Pos_multi_DB',Pos_multi_DB_rpl);
                obj = obj.push_to_randDB(i,'Pos_single_DB',Pos_single_DB_rpl);
                obj = obj.push_to_randDB(i,'Neg_multi_DB',Neg_multi_DB_rpl);
                obj = obj.push_to_randDB(i,'Neg_single_DB',Neg_single_DB_rpl);
            end
        end
        function batch_rpl_generater_and_save(obj,outpath,n)
            DBP_rand = [];
            for i = 1:n
                DBP = obj.rpl_generator(2);
                DBP_rand = cat(1,DBP_rand,DBP);
                save([outpath 'DBP_rand.mat'],'DBP_rand','-v7.3');
            end
        end

        %Experiment 4minus1, a new strategy for randomization through
        %rotation. 
        function array_B = get_4_1_random_list(obj,array_A,i,displacement)
            %For a given array_A, return it's randomization based on
            %displacement on the canvas. A 180 degree rotation will always
            %be done around one axis. 
            if nargin == 3
                displacement = [0.5,0.5,0.5];
            end
            if nargin == 4
                if numel(displacement)~=3
                    error('Displacement parameter should contain 3 values ranging 0~1');
                end
            end
            [num_images,Height,Width] = obj.get_stack_info(i);
            H_disp = Height*displacement(1);
            W_disp = Width*displacement(2);
            N_disp = num_images * displacement(3);
            array_A(:,1) = array_A(:,1) + H_disp;
            array_A(array_A(:,1) > Height,1) = array_A(array_A(:,1) > Height,1) - Height;
            array_A(:,2) = array_A(:,2) + W_disp;
            array_A(array_A(:,2) > Width,2) = array_A(array_A(:,2) > Width,2) - Width;
            array_A(:,3) = array_A(:,3) + N_disp;
            array_A(array_A(:,3) > num_images,3) = array_A(array_A(:,3) > num_images,3) - num_images;
            rot_mat = [1,0,0;0,-1,0;0,0,-1];
            array_A = array_A';
            array_A(2,:) = array_A(2,:) - Width/2 - 0.5;
            array_A(3,:) = array_A(3,:) - num_images/2 + 0.5;
            array_B = rot_mat * array_A;
            array_B(2,:) = array_B(2,:) + Width/2 - 0.5;
            array_B(3,:) = array_B(3,:) + num_images/2 + 0.5;
            array_B = array_B';
        end
        function obj = batch_experiment4minus1_randomization(obj,displacement)
            if nargin == 1
                displacement = [0.5,0.5,0.5];
            end
            for i = 1:18
                array_A = obj.get_position_array(obj.('All_DB'),i);
                rand_B = obj.get_4_1_random_list(array_A,i,displacement);
                obj = obj.push_to_randDB(i,'All_DB',rand_B);
                array_A = obj.get_position_array(obj.('Pos_DB'),i);
                rand_B = obj.get_4_1_random_list(array_A,i,displacement);
                obj = obj.push_to_randDB(i,'Pos_DB',rand_B);
                array_A = obj.get_position_array(obj.('Neg_DB'),i);
                rand_B = obj.get_4_1_random_list(array_A,i,displacement);
                obj = obj.push_to_randDB(i,'Neg_DB',rand_B);
                array_A = obj.get_position_array(obj.('Pos_multi_DB'),i);
                rand_B = obj.get_4_1_random_list(array_A,i,displacement);
                obj = obj.push_to_randDB(i,'Pos_multi_DB',rand_B);
                array_A = obj.get_position_array(obj.('Pos_single_DB'),i);
                rand_B = obj.get_4_1_random_list(array_A,i,displacement);
                obj = obj.push_to_randDB(i,'Pos_single_DB',rand_B);
                array_A = obj.get_position_array(obj.('Neg_multi_DB'),i);
                rand_B = obj.get_4_1_random_list(array_A,i,displacement);
                obj = obj.push_to_randDB(i,'Neg_multi_DB',rand_B);
                array_A = obj.get_position_array(obj.('Neg_single_DB'),i);
                rand_B = obj.get_4_1_random_list(array_A,i,displacement);
                obj = obj.push_to_randDB(i,'Neg_single_DB',rand_B);
            end
        end
        %-----------------------------------------------------------------
        %Experiment 1/2. 
        function ratio = close_check(obj,Matrix_A,Matrix_B,thre)
            %Ratio of cluster A that are close to cluster B. 
            count_all = size(Matrix_A,1);
            Logical_list = obj.close_check_ID(Matrix_A,Matrix_B,thre);
            ratio = sum(Logical_list) / count_all;
        end
        function ratios = batch_close_check(obj,indata_A,indata_B,thre)
            ratios = zeros(18,1);
            for i = 1:18
                array_A = obj.get_position_array(obj.(indata_A),i);
                array_B = obj.get_position_array(obj.(indata_B),i);
                ratios(i) = obj.close_check(array_A,array_B,thre);
            end
        end
        function ratios = batch_close_check_rand(~,DBP_rand,indata_A,indata_B,thre)
            %Get the close_ratio from a batch of randomized data. DBP_rand
            %should contain multiple DBP variables. 
            rand_size = numel(DBP_rand);
            ratios = zeros(18,rand_size);
            parfor i = 1:rand_size
                cur = DBP_rand(i);
                cur_ratio = cur.batch_close_check(indata_A,indata_B,thre);
                ratios(:,i) = cur_ratio;
            end
            %ratios = mean(ratios,2);
        end
        function ratios_writer(obj,ratios,outfile,num_rand)
            %This function is specifically used to write ratios with 18*11
            %size, where the last 10 columns are randomized data. 
            %num_rand: used when there is not 10 columns. 
            ratios = ratios(:);
            Sname_list = string(obj.Sample_name_list)';
            Sample_name_list_char = char(Sname_list);
            No_sample_list = string(Sample_name_list_char(:,1:4));
            Genotype_list = string(Sample_name_list_char(:,1:2));
            Age_list = string(Sample_name_list_char(:,3:4));
            Sample_list = string(Sample_name_list_char(:,6));
            type_1(1:18,1) = "Orig";
            type_2(1:18,1) = "Rand";
            headline = ["Name","No_sample","Genotype","Age","Sample","Type","Index","Ratio"];
            writematrix(headline,outfile,"WriteMode","append");
            for i = 0:num_rand
                ratio_temp = ratios((i*18+1):(i*18)+18);
                Index_list(1:18,1) = i;
                if i == 0
                    Matrix_to_write = cat(2,Sname_list,No_sample_list,...
                        Genotype_list,Age_list,Sample_list,type_1,...
                        Index_list,ratio_temp);
                else
                    Matrix_to_write = cat(2,Sname_list,No_sample_list,...
                        Genotype_list,Age_list,Sample_list,type_2,...
                        Index_list,ratio_temp);
                end
                writematrix(Matrix_to_write,outfile,"WriteMode","append");
            end
        end
        %-----------------------------------------------------------------
        %Experiment 4. 
        function norm_den = batch_get_norm_syn_density(obj,indata_A)
            %Read the target area region from XXX.mat files with pix_list
            %and calculate the indata_A synapse density on that region. 
            norm_den = zeros(18,1);
            for i = 1:18
                array_A = obj.get_position_array(obj.(indata_A),i);
                soma_images = obj.get_soma_mask(i);
                norm_den(i) = size(array_A,1) / obj.get_area(soma_images);
            end
        end
        function area = get_area(~,images)
            images = logical(images);
            area = sum(images(:)) / 0.0155/0.0155/0.07;
        end
        function array_new = pl_refine(obj,array_A,array_B,thre,far_logical)
            %Refine a list, where only far/close clusters are kept
            %far_logical=0: keep close; far_logical=1: keep far. 
            Logical_list = obj.close_check_ID(array_A,array_B,thre);
            if far_logical == 0
                array_new = array_A(Logical_list,:);
            else
                array_new = array_A(~Logical_list,:);
            end
        end
        function resampled_array = resampling_once(~,array,sampling_size)
            %For a given positionlist, resample it at sampling size (integer). 
            rand_index = randi(size(array,1),[sampling_size,1]);
            resampled_array = array(rand_index,:);
        end
        function sampling_num = get_sampling_size(~,images,norm_den)
            %For a given neuropil size and target normalized density, give
            %how many clusters should be found. 
            temp = logical(images);
            sampling_num = ceil(sum(temp(:))*0.0155*0.0155*0.07*norm_den);
        end
        function [ratio,stdev] = resampled_close_check(obj,array_A,array_B,resampling_size_A,resampling_size_B,resampling_times,thre)
            ratios = zeros(resampling_times,1);
            parfor i = 1:resampling_times
                resampled_array_A = obj.resampling_once(array_A,resampling_size_A);
                resampled_array_B = obj.resampling_once(array_B,resampling_size_B);
                ratios(i) = obj.close_check(resampled_array_A,resampled_array_B,thre); 
            end
            ratio = mean(ratios);
            stdev = std(ratios);
        end
        function [ratios,ratios_std] = batch_experiment_4_2(obj,norm_den_A,norm_den_B,resampling_times,thre,far_logical,indata_A,indata_B)
            ratios = zeros(18,1);
            ratios_std = zeros(18,1);
            for i = 1:18
                soma_images = obj.get_soma_mask(i);
                resampling_size_A = obj.get_sampling_size(~soma_images,norm_den_A);
                resampling_size_B = obj.get_sampling_size(~soma_images,norm_den_B);
                array_A = obj.get_position_array(obj.(indata_A),i);
                array_B = obj.get_position_array(obj.(indata_B),i);
                array_new = obj.pl_refine(array_A,array_B,thre+obj.typical_linear_size(2),far_logical);
                indata_C = [indata_A '_rand'];
                array_C = obj.get_position_array(obj.(indata_C),i);
                [ratios(i),ratios_std(i)] = obj.resampled_close_check(...
                    array_C,array_new,resampling_size_A,resampling_size_B,...
                    resampling_times,thre+obj.typical_linear_size(2));
            end
        end
        
        function [ratios,ratios_std] = batch_experiment_4_3(obj,norm_den_A,norm_den_B,resampling_times,thre,indata_A,indata_B)
            %Randomization for A and resampling for B. 
            ratios = zeros(18,1);
            ratios_std = zeros(18,1);
            for i = 1:18
                soma_images = obj.get_soma_mask(i);
                resampling_size_A = obj.get_sampling_size(~soma_images,norm_den_A);
                resampling_size_B = obj.get_sampling_size(~soma_images,norm_den_B);
                array_A = obj.get_position_array(obj.(indata_A),i);
                array_B = obj.get_position_array(obj.(indata_B),i);
                [ratios(i),ratios_std(i)] = obj.resampled_close_check(array_A,...
                    array_B,resampling_size_A,resampling_size_B,...
                    resampling_times,thre);
            end
        end
        %-----------------------------------------------------------------
        %Experiment 2.3, shuffle single-AZ, multi-AZ identities. 
        function [Mat_multi_out,Mat_single_out] = shuffle_identities(~,Mat_multi,Mat_single)
            num_multi = size(Mat_multi,1);
            %num_single = size(Mat_single,1);
            Mat_all = cat(1,Mat_multi,Mat_single);
            Mat_all = Mat_all(randperm(size(Mat_all,1)),:);
            Mat_multi_out = Mat_all(1:num_multi,:);
            Mat_single_out = Mat_all((num_multi+1):end,:);
        end
        function DBP_out = Exp2_3_rand_generator_for1(obj)
            DBP_out = obj;
            for i = 1:18
                %Pos_DB:
                array_A = obj.get_position_array(obj.Pos_multi_DB,i);
                array_B = obj.get_position_array(obj.Pos_single_DB,i);
                [array_A,array_B] = obj.shuffle_identities(array_A,array_B);
                DBP_out = DBP_out.push_to_randDB(i,'Pos_multi_DB',array_A);
                DBP_out = DBP_out.push_to_randDB(i,'Pos_single_DB',array_B);
                %Neg_DB:
                array_A = obj.get_position_array(obj.Neg_multi_DB,i);
                array_B = obj.get_position_array(obj.Neg_single_DB,i);
                [array_A,array_B] = obj.shuffle_identities(array_A,array_B);
                DBP_out = DBP_out.push_to_randDB(i,'Neg_multi_DB',array_A);
                DBP_out = DBP_out.push_to_randDB(i,'Neg_single_DB',array_B);
            end
        end
        function Exp2_3_rand_generator(obj,outpath,rand_size)
            DBP_rand = [];
            for i = 1:rand_size
                DBP = obj.Exp2_3_rand_generator_for1();
                DBP_rand = cat(1,DBP_rand,DBP);
            end
            save([outpath 'DBP_rand.mat'],'DBP_rand','-v7.3');
        end
        function ratios = Generate_rand_2_3(obj,indata_A,indata_B,thre)
            ratios = zeros(18,1);
            for i = 1:18
                array_A = obj.get_position_array(obj.(indata_A),i);
                array_B = obj.get_position_array(obj.(indata_B),i);
                ratios(i) = obj.close_check(array_A,array_B,thre);
            end
        end
        %-----------------------------------------------------------------
        %Experiment 7: 
        %Most functions here is used for distance measuremnet for Figure 4
        %in the manuscript. 
        %Generated randomzied data in:
        %Y:\Chenghang\4_Color_Continue\Database\Experiment_2.3\DBP_rand_10.mat.
        %Important: experiment 7.1 and 7.2 require manually change multi to
        %single. 
        function Is_clusterd_list = Is_clustered(obj,i,Is_CTB_pos,thre)
            %Check whethere there is single-AZ synaspe nearby. Return
            %whether the multi-AZ list is clustered or isolated. 
            %Is_CTB_pos = 1 or 0. 
            if nargin < 4
                thre = 1.5;
            end
            if Is_CTB_pos == 1
                Multi_DB_name = 'Pos_multi_DB';
                Single_DB_name = 'Pos_single_DB';
            elseif Is_CTB_pos == 0
                Multi_DB_name = 'Neg_multi_DB';
                Single_DB_name = 'Neg_single_DB';
            end
            multi_array = obj.get_position_array(obj.(Multi_DB_name),i);
            single_array = obj.get_position_array(obj.(Single_DB_name),i);
            Dist = obj.Get_Dist_2_matrix_closest(multi_array,single_array);
            Is_clusterd_list = (Dist < thre);
        end
        function [Clustered_dist,Isolated_dist] =Get_closest_distance_exp7(obj,i,A_Is_Pos,B_Is_Pos,Is_clustered_list)
            %Quantify distance from A to B. A has same size as
            %"Is_clustered_list";
            if A_Is_Pos == 1
                Matrix_A = 'Pos_multi_DB';
            elseif A_Is_Pos == 0
                Matrix_A = 'Neg_multi_DB';
            end
            if B_Is_Pos == 1
                Matrix_B = 'Pos_multi_DB';
            elseif B_Is_Pos == 0
                Matrix_B = 'Neg_multi_DB';
            end
            Array_A = obj.get_position_array(obj.(Matrix_A),i);
            Array_B = obj.get_position_array(obj.(Matrix_B),i);
            Clustered_list_A = Array_A(Is_clustered_list,:);
            Isolated_list_A = Array_A(~Is_clustered_list,:);
            Clustered_dist = obj.Get_Dist_2_matrix_closest(Clustered_list_A,Array_B);
            Isolated_dist = obj.Get_Dist_2_matrix_closest(Isolated_list_A,Array_B);
        end

        function exp7_get_distances(~,obj_rand,outfile,thre,A_Is_Pos,B_Is_Pos)
            %Only randomzied data. Out put pulled from 10 randomizations. 
            temp_obj = obj_rand(1);
            Sname_list = string(temp_obj.Sample_name_list)';
            Sample_name_list_char = char(Sname_list);
            No_sample_list = string(Sample_name_list_char(:,1:4));
            Genotype_list = string(Sample_name_list_char(:,1:2));
            Age_list = string(Sample_name_list_char(:,3:4));
            Sample_list = string(Sample_name_list_char(:,6));
            type_1 = "Clustred";
            type_2 = "Isolated";
            headline = ["Name","No_sample","Genotype","Age","Sample","Type","Distance"];
            writematrix(headline,outfile);
            for i = 1:18
                Clustered_dist_all = [];
                Isolated_dist_all = [];
                for j = 1:10
                    target_obj = obj_rand(j);
                    Is_clustered_list = target_obj.Is_clustered(i,A_Is_Pos,thre);
                    [Clustered_dist,Isolated_dist] = target_obj.Get_closest_distance_exp7(i,A_Is_Pos,B_Is_Pos,Is_clustered_list);
                    Clustered_dist_all = cat(1,Clustered_dist_all,Clustered_dist);
                    Isolated_dist_all = cat(1,Isolated_dist_all,Isolated_dist);
                end
                Clustered_dist_all = Clustered_dist_all';
                Isolated_dist_all = Isolated_dist_all';
                Matrix_to_write_clustered = cat(2,Sname_list(i),No_sample_list(i),...
                                    Genotype_list(i),Age_list(i),Sample_list(i),type_1,...
                                    Clustered_dist_all);
                Matrix_to_write_isolated = cat(2,Sname_list(i),No_sample_list(i),...
                                    Genotype_list(i),Age_list(i),Sample_list(i),type_2,...
                                    Isolated_dist_all);
                writematrix(Matrix_to_write_clustered,outfile,'WriteMode','append');
                writematrix(Matrix_to_write_isolated,outfile,'WriteMode','append');
            end
        end
        %-----------------------------------------------------------------
        %WIP. 
        function cor_mat = get_position_correlation(obj,DB_A,DB_B,DB_C)
            cor_mat = cell(1,18);
            for i = 1:18
                array_A = obj.get_position_array(obj.(DB_A),i);
                array_B = obj.get_position_array(obj.(DB_B),i);
                array_C = obj.get_position_array(obj.(DB_C),i);
                Dist_mat_AB = obj.Get_Dist_2_matrix(array_A,array_B);
                Dist_mat_AC = obj.Get_Dist_2_matrix(array_A,array_C);
                Dist_mat_AB = obj.delete_0_from_distmat(Dist_mat_AB);
                Dist_mat_AC = obj.delete_0_from_distmat(Dist_mat_AC);
                cor_mat{i} = cat(2,Dist_mat_AB(:,1),Dist_mat_AC(:,1));
            end
        end
        function check_postion_correlation_one(~,cor_mat,i)
            cor_mat_1 = cor_mat{i};
            figure;plot(cor_mat_1(:,1),cor_mat_1(:,2),'.');
            xlabel('Distance to closest signle-AZ synapse');
            ylabel('Distance to closest multi-AZ synapse');
            xlim([0,8]);
            ylim([0,8]);
            hold on;
            line([0,8],[1.5,1.5],'Color','r','LineWidth',1);
            line([1.5,1.5],[0,8],'Color','r','LineWidth',1);
            hold off;
        end
        function check_position_correlation_one_histogram(~,cor_mat,i)
            cor_mat_1 = cor_mat{i};
            target_list = cor_mat_1(cor_mat_1(:,1) < 1.5,2);
            figure;histogram(target_list,40);
        end

        
        
        
    end
end

