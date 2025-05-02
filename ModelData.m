function ModelData(A1, Model)
    global Global; 
    Global.MultiR(Global.t).R = Model;
    Global.MultiR(Global.t).TrainData= A1;
    Temp             = Global.Evaluated;
    Global.Evaluated = floor((Global.t-0.5)*Global.T); 
    %%
    [FrontNo,~] = NDSort(objs(A1),length(A1));    
    Next = FrontNo == 1;
    A1   = A1(Next);
    Global.IGD(Global.t) = CalIGD(A1);
    Global.MultiR(Global.t).A1 = A1; 
    Global.Evaluated = Temp;
    if length(Global.Problem) == 4 && all(Global.Problem == 'SDP1')
        eval([Global.Problem '.ChangeDec']);
    end
end