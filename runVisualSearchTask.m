%% runVisualSearchTask is the main script for operating the experiment
% Format of call runVisualSearchTask
% by Derek Chan and Hugo McGurran
% Created on MATLAB version R2016a/b

%% Please do not modify the following scripts %%   
%% Set up counters and randomisers
% Load the modifiable settings
settingsVisualSearchTask

% Generate all possible combinations of setsize and task type
for icounters = 1:4        
    counters(icounters,:) = {setsize(icounters), 'dsym', positiveTrials}; 
    counters(icounters+4,:) = {setsize(icounters), 'dcol', positiveTrials};         
    counters(icounters+8,:) = {setsize(icounters), 'c', positiveTrials};
end 

% Set up the target present/absent pool
target_pool = zeros(1,10);
target_pool(1:10*target_present) = 1;
target_pool = target_pool(randperm(10));

%% Set up the interface and the instruction screen
fig = figure('units','normalized',...
    'outerposition',[0 0 1 1]);

ax = axes(fig,'xcolor',get(gcf,'color'),...
    'position', [0 0 1 1],...
    'xtick',[],...
    'ycolor',get(gcf,'color'),...
    'ytick',[]);

ppn = str2double(inputdlg('Please enter your number: '));
validateattributes(ppn,{'numeric'},{'nonempty','positive', 'integer', 'scalar'},mfilename,'Participant Number',1)

% instruction screen
str = sprintf('Instruction: Press Q as quicky as possible when you see the target \n\nIf there is no target, press P \n\nPress any key to start');
tb1 = annotation(fig,'textbox',...
    'String', str,...
    'FontSize', 20,...
    'Position',[.3 .3 .4 .4],...
    'HorizontalAlignment', 'center',...
    'VerticalAlignment', 'middle');

% intertrial screen
str2 = sprintf('Press space bar to continue');
tb2 = annotation(fig,'textbox',...
    'Visible','off',...
    'String', str2,...
    'FontSize', 20,...
    'Position',[.3 .3 .4 .4],...
    'HorizontalAlignment', 'center',...
    'VerticalAlignment', 'middle');

% break screen
str3 = sprintf('Please have a break, \n\nPress any key to resume');
tb3 = annotation(fig,'textbox',...
    'Visible','off',...
    'String', str3,...
    'FontSize', 20,...
    'Position',[.3 .3 .4 .4],...
    'HorizontalAlignment', 'center',...
    'VerticalAlignment', 'middle');

pause
delete(tb1)

%% Set up variables for later 
reload = target_pool;
ntrial = 0;
check = 1;
break_counter = 0;

%% Run the experiment
rng('shuffle')

while check %check == 1 is redundant 
    ntrial = ntrial + 1;    
    break_counter = break_counter + 1;
    target = target_pool(1);
    
    %% Generate a random setsize, a type of task and if the target is present from the counters
    while 1
        % Re-generate a new combination if the old one has already completed  
        [n, sort, c] = counters{randi(12),:};    
        if c ~= 0;
            break
        end
    end
    
    %% Generate a single stimulus
    [reactionTime, correct, buttonPress] = do_experiment(n ,sort, target);    
    
    %% Save the results of the trial   
    data(ntrial).ParticipantNumber = ppn;
    data(ntrial).Target = target;
    data(ntrial).ButtonPressed = buttonPress;
    data(ntrial).ReactionTime = reactionTime;
    data(ntrial).Correct = correct;
    data(ntrial).Type = sort;
    data(ntrial).Setsize = n;
    
    %% Clear current trial symbols   
    delete(findall(gcf,'String', 'O'))
    delete(findall(gcf,'String', 'X')) 

    %% Operate the counters according to the subject's response  
    if target == 1 && correct == 1
        if strcmp(sort, 'dsym') == 1
            counters{setsize == n, 3} = counters{setsize == n, 3} - 1;
        elseif strcmp(sort, 'dcol') == 1
            counters{(find(setsize == n)+4), 3} = counters{(find(setsize == n)+4), 3} - 1;
        elseif strcmp(sort, 'c') == 1
            counters{(find(setsize == n)+8), 3} = counters{(find(setsize == n)+8), 3} - 1;
        end
        
        % Check if all combinations are fulfilled
        check = counters(:,3)';
        check = any(cell2mat(check));   
    end
    
    %% Randomise target present/absent and reset target_pool every 10 trials
    target_pool(1) = [];
    
    if length(target_pool) < 1
        target_pool = reload;
        target_pool = target_pool(randperm(10));
    end
    
    %%  Halt the experiment after a set number of trials
    if break_counter == breakAfter;
        set(tb3, 'Visible', 'on')
        pause
        set(tb3, 'Visible', 'off')
       break_counter = 0;
    end
    
    %% Move on to the next trial 
    if check == 1
          set(tb2, 'Visible', 'on')
          pause
          set(tb2, 'Visible', 'off')
    end
end
close all

%% save the data 
filename = int2str(ppn);
save(filename, 'data')
msgbox('Thank you for your participation!')

%% Reorganise data and plot data (optional)
% call dataAnalysis.m to plot the result




