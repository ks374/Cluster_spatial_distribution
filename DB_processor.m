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

        Sample_name_list = {'WTP2_A','WTP2_B','WTP2_C','WTP4_A','WTP4_B','WTP4_C',...
                'WTP8_A','WTP8_B','WTP8_C','B2P2_A','B2P2_B','B2P2_C',...
                'B2P4_A','B2P4_B','B2P4_C','B2P8_A','B2P8_B','B2P8_C'};
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

        function DoC = get_DoC(obj,Matrix_A,Matrix_B,thre,save_logical,outpath)
            %Get DoC from two centeroid matrixes
            Dist_mat = obj.Get_Dist_2_matrix(Matrix_A,Matrix_B,save_logical,outpath);
            Dist_mat = Dist_mat < thre;
            DoC = zeros(1,size(Dist_mat,1));
            for i = 1:size(Dist_mat,1)
                DoC(i) = numel(find(Dist_mat(i,:)));
            end
        end
        function Batch_DoCs(obj,indata_A,indata_B,thre,outpath)
            obj.save_ID = 1;
            for i = 1:18
                array_A = obj.get_array(indata_A,i,6:8);
                array_B = obj.get_array(indata_B,i,6:8);
                Cur_DoC = obj.get_DoC(array_A,array_B,thre,1,outpath);
                writematrix(Cur_DoC,[outpath,'DoC.csv'],'WriteMode','append');
                obj.save_ID = obj.save_ID + 1;
            end
        end

        


        function ratio = get_ratio(obj,Matrix_A,Matrix_B,thre,save_logical,outpath)
            Dist_mat = obj.Get_Dist_2_matrix(Matrix_A,Matrix_B,save_logical,outpath);
            Dist_mat = Dist_mat < thre;
            count_all = size(Dist_mat,1);
            count_nearby = 0;
            for i = 1:size(Dist_mat,1)
                if Dist_mat(i,1) == 1
                    count_nearby = count_nearby + 1;
                end
            end
            ratio = count_nearby/count_all;
        end
        
        function ratios = get_paired_ratio(obj,infile,thre)
            indata = obj.get_indata(infile);
            ratios = zeros(18,1);
            for i = 1:18
                the_array = obj.get_array(indata,i,4:13);
                ratios(i) = obj.check_paired_ratio(the_array,thre);
            end
        end
    end
end

