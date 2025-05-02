function DKRVEA()
    global Global;
    cd(fileparts(mfilename('fullpath')));
    addpath(genpath(cd));
    %% Parameter setting
    ParameterInitial('F1');
    alpha = 2;
    wmax  = 20;
    mu    = 5;
    Global.SerNum = 10;
    %% Generate the reference points and population
    [V0,Global.N] = UniformPoint(Global.N,Global.M);
	V     = V0;
    NI    = 200;
    Global.PopObs    = LHS_sam(Global.D*2);
    Global.ObsDec    = decs(Global.PopObs); 
    Global.Rs        = 3;
    Global.t         = 1;
    Global.MultiR    = struct();
    Global.MultiR(Global.t).ObsObj = objs(Global.PopObs);
    A1               = Global.PopObs;
    THETA            = 5.*ones(Global.M,Global.D);
    Model            = cell(1,Global.M);
    PopDec           =  RandSamp(Global.N);
    PopObj           = zeros([Global.N, Global.M]);
    Population       = PopStruct(PopDec, PopObj);
    TransFlag        = zeros([1,Global.M]);
    Gen = 1; Rate = 0;
    %% PreTrain the Kriging Models
     A1Dec = decs(A1);
     A1Obj = objs(A1);
     for i = 1 : Global.M
        dmodel     = dacefit(A1Dec,A1Obj(:,i),'regpoly1','corrgauss',THETA(i,:),1e-5.*ones(1,Global.D),100.*ones(1,Global.D));
        Model{i}   = dmodel;
        THETA(i,:) = dmodel.theta;
     end
    %% Optimization
    disp(['---------Time step: ',num2str(Global.t),'-------']);
    while Terminate()
        if Global.Evaluated < (Global.t*Global.T) || Global.Evaluated==0
            [Population, Model, A1, THETA, V, Rate] = KOptimization(Model, decs(Population), V, V0, alpha, wmax, mu, NI, THETA, A1, TransFlag, Gen, Rate);            
            Gen = Gen+1;
        else
            Global.HisTrain = struct(); Global.AddData = struct(); Gen = 2; Rate = 0;
            Global = rmfield(Global,'HisTrain'); Global=rmfield(Global,'AddData');
            Global.Evaluated  = Global.t*Global.T;
            [V0,Global.N]     = UniformPoint(Global.N,Global.M);
            V                 = V0;
            ModelData(A1, Model);  
            Global.t          = Global.t+1;    
            THETA             = 5.*ones(Global.M,Global.D);
            [A1, Model, TransFlag] = KHisInitial(THETA, V);
            PopDec            = RandSamp(Global.N);
            PopObj            = zeros([Global.N, Global.M]);
            Population        = PopStruct(PopDec, PopObj);
            disp(['---------Time step: ',num2str(Global.t),'-------']);
        end
    end
    IGD      = Global.IGD;
    MIGD     = mean(Global.IGD);
end