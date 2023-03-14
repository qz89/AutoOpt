function [output1, output2, output3] = CEC2005_f6(varargin)
% The Shifted Rosenbrock's Function from the benchmark for the CEC 2005
% Special Session on Real-Parameter Optimization.

switch varargin{end}
    case 'construct'
        type     = {'continuous','static','certain'};
        Problem  = varargin{1};
        instance = varargin{2};
        orgData  = load('rosenbrock_func_data');
        o        = orgData.o;
        Data     = struct('o',[]);
        for i = 1:length(instance)
            Problem(i).type = type;
            
            if instance(i) == 1
                D = 10;
            elseif instance(i) == 2
                D = 30;
            elseif instance(i) == 3
                D = 50;
            else
                error('Only instances 1, 2, and 3 are available.')
            end
            lower = zeros(1,D) - 100;
            upper = zeros(1,D) + 100;
            Problem(i).bound = [lower;upper];        
            
            if length(o) >= D
                curr_o = o(1:D);
            else
                curr_o = -90+180*rand(1,D);
            end
            Data(i).o = curr_o;
        end
        output1 = Problem;
        output2 = Data;
        
   case 'repair'
        Decs = varargin{2};
        output1 = Decs; 
    
    case 'evaluate'
        Data  = varargin{1};
        o     = Data.o;
        Decs  = varargin{2};
        
        [N,D] = size(Decs);
        Decs  = Decs-repmat(o,N,1)+1;
        
        fit = sum(100.*(Decs(:,1:D-1).^2-Decs(:,2:D)).^2+(Decs(:,1:D-1)-1).^2,2);
        output1 = fit+390;
end

if ~exist('output2','var')
    output2 = [];
end
if ~exist('output3','var')
    output3 = [];
end
end