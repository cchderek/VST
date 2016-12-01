%% dataAnalysis reorganises data obtained from runVisualSearchTask and plot the data
% Prompt user for the data file
uiopen('load')
settingsVisualSearchTask

% Prepare figure
result_plot = figure('units','normalized',...
    'outerposition',[0 0 1 1]);

title('Visual Search Task result', 'fontsize', 30);
xlabel('Set Size', 'fontsize', 20)
ylabel('Reaction Time (s)', 'fontsize', 20)
hold on

%% Data extraction
% Extract dsym data
dsymdata = data(:,find(strcmp({data.Type}, 'dsym') == 1));
dsymdata = dsymdata(intersect(find([dsymdata.Correct]),find([dsymdata.Target]))); 

%{
logical vector !!
log8 = [data(:).Setsize] == 8;
logc = strcmp({data(:).Type}, 'c');
logT = [data(:).Target]
logCor = [data(:).Correct]
log8cTCor = log8 & logc & logT & logCor
n8cTCor = [data(log8cTCor)]
%}
plot([dsymdata.Setsize], [dsymdata.ReactionTime],'rx')
 
% Extract 
dcol data
dcoldata = data(:,find(strcmp({data.Type}, 'dcol') == 1));
dcoldata = dcoldata(intersect(find([dcoldata.Correct]),find([dcoldata.Target])));
plot([dcoldata.Setsize], [dcoldata.ReactionTime],'go')

% Extract c data
cdata = data(:,find(strcmp({data.Type}, 'c') == 1));
cdata = cdata(intersect(find([cdata.Correct]),find([cdata.Target])));
plot([cdata.Setsize], [cdata.ReactionTime],'b*')


for isetsize = 1:4
    plotdata(isetsize).dsym = [dsymdata(find([dsymdata.Setsize] == setsize(isetsize))).ReactionTime];
    plotdata(isetsize).dcol = [dcoldata(find([dcoldata.Setsize] == setsize(isetsize))).ReactionTime];
    plotdata(isetsize).c = [cdata(find([cdata.Setsize] == setsize(isetsize))).ReactionTime];
end

%% Calculate mean values
meandsym = [];
meandcol = [];
meanc = [];

for isetsize2 = 1:4
   meandsym = [meandsym,mean(plotdata(isetsize2).dsym)];
   meandcol = [meandcol,mean(plotdata(isetsize2).dcol)];
   meanc = [meanc,mean(plotdata(isetsize2).c)];
end

%% Plot mean lines
line(setsize,meandsym,'color','r')

line(setsize,meandcol,'color','g')

line(setsize,meanc,'color','b')

legend('symbol pop-out','colour pop-out', 'conjunction search', 'Location','NorthWest')
