classdef Cluster_DB
    %Get basic synaptic cluster data base
    %Offer methods to files likes "Vwater_sn_001.mat". 
    
    properties
        Inpath char; %Store the input path of all VGLuT2 stats file. 
        Sample_name_list cell; %name of all experiments
        Basic_DB_file char; %Output data file
    end
    
    methods
        function obj = Cluster_DB(inpath)
            %Init. inpath contain a list of .mat files. 
            obj.Inpath = inpath;
            obj.Sample_name_list = {'WTP2_A','WTP2_B','WTP2_C','WTP4_A','WTP4_B','WTP4_C',...
                'WTP8_A','WTP8_B','WTP8_C','B2P2_A','B2P2_B','B2P2_C',...
                'B2P4_A','B2P4_B','B2P4_C','B2P8_A','B2P8_B','B2P8_C'};
        end
        
        function Write_basic_DB(obj,outfile)
            %Write AZ number and WC of each cluster. 
            obj.Basic_DB_file = outfile;
            Total_ID = 1;
            Head_line = ["Sample","Total_ID","Sample_CTB_ID","CTB","AZ#","X","Y","Z"];
            writematrix(Head_line,outfile,"WriteMode","append");
            for i = 1:18
                disp(obj.Sample_name_list{i});
                load([obj.Inpath,'Vwater_ss_',sprintf('%03d',i),'.mat']);
                load([obj.Inpath,'Vwater_sn_',sprintf('%03d',i),'.mat']);
                for j = 1:numel(statsVwater_ss)
                    AZ_number = statsVwater_ss(j).B_ID;
                    AZ_number = numel(AZ_number) - 1;
                    if AZ_number < 1
                        AZ_number = 1;
                    end
                    WC = statsVwater_ss(j).WeightedCentroid;
                    Writing_line = [string(obj.Sample_name_list{i}),string(Total_ID),...
                        string(j),'Pos',string(AZ_number),string(WC(2)),...
                        string(WC(1)),string(WC(3))];
                        Total_ID = Total_ID + 1;
                        writematrix(Writing_line,outfile,"WriteMode","append");
                end
                for j = 1:numel(statsVwater_sn)
                    AZ_number = statsVwater_sn(j).B_ID;
                    AZ_number = numel(AZ_number) - 1;
                    if AZ_number < 1
                        AZ_number = 1;
                    end
                    WC = statsVwater_sn(j).WeightedCentroid;
                    Writing_line = [string(obj.Sample_name_list{i}),string(Total_ID),...
                        string(j),'Neg',string(AZ_number),string(WC(2)),...
                        string(WC(1)),string(WC(3))];
                    Total_ID = Total_ID + 1;
                    writematrix(Writing_line,outfile,"WriteMode","append");
                end
            end
        end

        function get_typical_linear_size(obj)
            %Write AZ number and WC of each cluster. 
            multi_AZ = [];
            single_AZ = [];
            for i = 1:18
                disp(obj.Sample_name_list{i});
                load([obj.Inpath,'Vwater_ss_',sprintf('%03d',i),'.mat']);
                load([obj.Inpath,'Vwater_sn_',sprintf('%03d',i),'.mat']);
                for j = 1:numel(statsVwater_ss)
                    AZ_number = statsVwater_ss(j).B_ID;
                    AZ_number = numel(AZ_number) - 1;
                    if AZ_number < 1
                        AZ_number = 1;
                    end
                    if AZ_number == 1
                        single_AZ = cat(1,single_AZ,statsVwater_ss(j).Volume2_0);
                    else
                        multi_AZ = cat(1,multi_AZ,statsVwater_ss(j).Volume2_0);
                    end
                end
                for j = 1:numel(statsVwater_sn)
                    AZ_number = statsVwater_sn(j).B_ID;
                    AZ_number = numel(AZ_number) - 1;
                    if AZ_number < 1
                        AZ_number = 1;
                    end
                    if AZ_number == 1
                        single_AZ = cat(1,single_AZ,statsVwater_sn(j).Volume2_0);
                    else
                        multi_AZ = cat(1,multi_AZ,statsVwater_sn(j).Volume2_0);
                    end
                end
            end
            disp(['Multi_AZ linear size:' num2str(nthroot((median(multi_AZ)*0.0155*0.0155*0.07),3))]);
            disp(['Single_AZ linear size:' num2str(nthroot((median(single_AZ)*0.0155*0.0155*0.07),3))]);
        end
    end
end

