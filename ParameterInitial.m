function ParameterInitial(Pro)

    %% Relative Parameter Setting
    global Global
    Global.Problem   = Pro;  
    Global.D         = 10;                             %%%Decision Dimension
    Global.N         = 100;                            %%%Popualtion number 
    Global.nt = 10;   Global.T = 7*Global.D;           %%%T is the 
    Global.Evaluation= Global.T*100;
    Global.Nr        = 10000;                          %%%Reference points number
    Global.IGD       = zeros(1, Global.Evaluation/Global.T);  
    Global.Gened = 0;  Global.Evaluated = 0;

    %% Problem Set
    switch Global.Problem
        case 'F1'
            Global.M     = 2;
            Global.Lower = [0 -ones(1,Global.D-1)];
            Global.Upper = [1 ones(1,Global.D-1)];
        case 'F2'
            Global.M     = 2;
            Global.Lower = [0 -ones(1,Global.D-1)];
            Global.Upper = [1 ones(1,Global.D-1)];  
        case 'F3'
            Global.M     = 2;
            Global.Lower = [0 -ones(1,Global.D-1)];
            Global.Upper = [1 ones(1,Global.D-1)];
        case 'F4'
            Global.M     = 3;
            Global.Lower = zeros(1, Global.D);
            Global.Upper = ones(1, Global.D);
        case 'F5'
            Global.M     = 2;
            Global.Lower = zeros(1,Global.D);
            Global.Upper = 5*ones(1,Global.D);
        case 'F6'
            Global.M     = 2;
            Global.Lower = zeros(1,Global.D);
            Global.Upper = 5*ones(1, Global.D);
        case 'F7'
            Global.M     = 2;
            Global.Lower = zeros(1,Global.D);
            Global.Upper = 5*ones(1, Global.D);
        case 'F8'
            Global.M     = 3;
            Global.Lower = [0,0, ones(1,Global.D-2)*-1];
            Global.Upper = [1,1, ones(1, Global.D-2)*2];
        case 'F9'
            Global.M     = 2;
            Global.Lower = zeros(1, Global.D);
            Global.Upper = 5*ones(1, Global.D);
        case 'F10'
            Global.M     = 2;
            Global.Lower = zeros(1, Global.D);
            Global.Upper = 5*ones(1, Global.D);
        case 'SDP1'
            Global.M = 2;
            y_t = repmat(linspace(1,Global.D,Global.D),100,1)/Global.D;
            Global.y(Global.NR).yy = y_t;
            Global.Lower = [ones([1,Global.M]), zeros([1,Global.D-Global.M])];
            Global.Upper = [4*ones([1,Global.M]), ones([1,Global.D-Global.M])];
        case 'SDP3'
            Global.M = 2;
            Global.Lower = [zeros([1,Global.M-1]),-1*ones([1,Global.D-Global.M+1])];
            Global.Upper = [ones([1,Global.M-1]), ones([1,Global.D-Global.M+1])];
        case 'SDP4'
            Global.M = 2;
            Global.Lower = [zeros([1,Global.M-1]),-1*ones([1,Global.D-Global.M+1])];
            Global.Upper = [ones([1,Global.M-1]), ones([1,Global.D-Global.M+1])];
        case 'SDP5'
            Global.M = 2;
            Global.Lower = zeros([1,Global.D]);
            Global.Upper = ones([1,Global.D]);
        case 'SDP10'
            Global.M = 2;
            Global.Lower = [zeros([1,Global.M-1]),-1*ones([1,Global.D-Global.M+1])];
            Global.Upper = [ones([1,Global.M-1]), ones([1,Global.D-Global.M+1])];
        case 'FDA2'
            Global.M = 2;
            Global.D = 31;
            Global.Lower = [0,-1*ones([1,Global.D-1])];
            Global.Upper = ones([1,Global.D]);
        case 'FDA3'
            Global.M = 2;
            Global.D = 30;
            Global.Lower = [zeros([1,5]), -1*ones([1,25])];
            Global.Upper = ones([1,Global.D]);
    end
    %Global.b = waitbar(0, 'Algorirthm Start');
end