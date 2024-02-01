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
        save_ID int16; %To save .mat files for experiments. 
    end
    
    methods
        function obj = DB_processor(infile)
            obj.All_DB = obj.get_indata(infile);
            obj.save_ID = 1;
        end
        
        function obj = splitter(obj)
            obj.Pos_DB = obj.All_DB(obj.get_pos(obj.All_DB),:);
            obj.Neg_DB = obj.All_DB(obj.get_neg(obj.All_DB),:);
            obj.Pos_multi_DB = obj.Pos_DB(obj.get_multi(obj.Pos_DB),:);
            obj.Pos_single_DB = obj.Pos_DB(obj.get_single(obj.Pos_DB),:);
            obj.Neg_multi_DB = obj.Neg_DB(obj.get_multi(obj.Neg_DB),:);
            obj.Neg_single_DB = obj.Neg_DB(obj.get_single(obj.Neg_DB),:);
        end

        function indata = get_indata(~,infile)
            opts = detectImportOptions(infile);
            indata = readtable(infile,opts);
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

        function the_array = get_position_array(obj,indata,i)
            %i stands for experiment ID, range 1-18. 
            Cur_name = obj.Sample_name_list{i};
            Cur_ID = string(cell2mat(indata.('Sample'))) == string(Cur_name);
            the_array = table2array(indata(Cur_ID,6:8));
        end

        function Dist_mat = Get_Dist_2_matrix(~,Matrix_A,Matrix_B)
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

        function ratio = close_check(obj,Matrix_A,Matrix_B,thre)
            count_all = size(Matrix_A,1);
            Dist_mat = obj.Get_Dist_2_matrix(Matrix_A,Matrix_B);
            if Dist_mat(1,1) == 0
                row_id = 2;
            else
                row_id = 1;
            end
            temp_logical = Dist_mat(:,row_id)<thre;
            ratio = sum(temp_logical) / count_all;
        end
        function ratios = batch_close_check(obj,indata_A,indata_B,thre)
            ratios = zeros(18,1);
            for i = 1:18
                array_A = obj.get_position_array(obj.(indata_A),i);
                array_B = obj.get_position_array(obj.(indata_B),i);
                ratios(i) = obj.close_check(array_A,array_B,thre);
            end
        end

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
        function num = get_curr_sample_pl_length(obj,DB_name,i)
            Cur_name = obj.Sample_name_list{i};
            Cur_ID = string(cell2mat(obj.(DB_name).('Sample'))) == string(Cur_name);
            num = numel(find(Cur_ID));
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
    end
end

