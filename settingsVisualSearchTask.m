%% settingsVisualSearchTask stores all modifiable settings for the experiment
% Change it to suit your experiment

% Number of symbols presenting on the screen (including one target and distractors)
% Enter any 4 positive even integers >= 8
setsize = [8 24 40 56]; 

% Number of positive trials required with the target present in each condition
% (setsize x type of search)
positiveTrials = 2;

% Number of trials to run before a break (for no breaks, choose a number
% greater than the number of trials in your experiment)
breakAfter = 50;

% Ratio of the target being present in the experiment
target_present = 0.8;