function TFlag = Terminate()
    global Global;
    if Global.Evaluated<=Global.Evaluation
        TFlag    = 1;
    else
        TFlag    = 0;

    end
end