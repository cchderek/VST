function [ reactionTime, correct, buttonPress ] = do_experiment(n, sort, target)
%% do_experiment creates a single trial using Treisman_exp; it records the participant's button press and reaction time
% INPUT:
    % n = number of objects (target + distractors)
    % sort = 'c' or 'dcol' or 'dsym'
    % target = 0 or 1 (target is absent or present)   

    %% Input checks
    validateattributes(n,{'numeric'},{'nonempty','positive', 'integer', 'scalar'},mfilename,'Set Size',1)
    validateattributes(sort,{'char'},{'nonempty'},mfilename,'Type of Search',2)
    validateattributes(target,{'numeric'},{'nonempty', 'binary', 'scalar'},mfilename,'Target Present/Absent',3)
    
    %% Start the timer and running Treisman_exp when a single stimulus is called 
    tic
    Treisman_exp (n, sort, target)
   
    % Stop the timer and Recording the response of the participant
    pause
    
    buttonPress = get(gcf, 'CurrentCharacter');
    reactionTime = toc;
    
   
    % Check if the participant has got the right answer
    if (target == 1 && buttonPress == 'q')||(target == 0 && buttonPress == 'p')
        correct = 1;
    else
        correct = 0;
    end
    
end



