clc; close all; clear;

dirpath = '/path/to/directory/with/statit/bot/output/data/';
cd(dirpath)

for tt = 1:2
clearvars -except tt dirpath

Y1 = [2017 2017 2017 2017 2017 2017 2017 2017 2017 2017 2017 2017 2017 2017 2017 ...
      2017 2017 2017 2017 2017 2017 2017 2017 2017 2017 2017 2017 2017 2017 2017];
Y2 = [2017 2017 2017 2017 2017 2017 2017 2017 2017 2017 2017 2017 2017 2017 2017 ...
      2017 2017 2017 2017 2017 2017 2017 2017 2017 2017 2017 2017 2017 2017 2017];
M1 = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]+0;
M2 = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]+0;
D1 = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30];
D2 = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30];
H1 = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]+0;
H2 = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]+4;


pycom = ['python statitbot.py ' ...
    num2str(Y1(tt)) ' ' num2str(M1(tt)) ' ' num2str(D1(tt)) ' ' num2str(H1(tt)) ...
' ' num2str(Y2(tt)) ' ' num2str(M2(tt)) ' ' num2str(D2(tt)) ' ' num2str(H2(tt))];


[status,cmdout] = system(pycom,'-echo');

redditPRAW_TD()
pause(1)

TDFiles = dir([dirpath,'/TD_*']);
TDFileNames = {TDFiles(:).name}';
TDFullPaths = strcat(repmat([dirpath '/'],length(TDFileNames),1), TDFileNames);

clearvars -except TDFullPaths dirpath

for nn = 1:size(TDFullPaths,1)
    
    load(TDFullPaths{nn})
    
    TDURL{nn} = URL;
    TDKarma{nn} = Karma;
    
end

TD_URL = TDURL{1};
TD_Karma = TDKarma{1};

for nn = 2:size(TDFullPaths,1)
    
    TD_URL = [TD_URL; TDURL{nn}];
    TD_Karma = [TD_Karma; TDKarma{nn}];
    
end

clearvars -except TD_URL TD_Karma dirpath

[URL, indx] = sort(TD_URL);

Karma = TD_Karma(indx);

clearvars -except URL Karma dirpath



% DELETE THESE
DEL1 = strcmp(URL,'s-media-cache-ak0.pinimg');
DEL2 = strcmp(URL,'imgtc');
DEL3 = strcmp(URL,'wikimedia');
DEL4 = strcmp(URL,'google');
DEL5 = strcmp(URL,'twimg');
DEL6 = strcmp(URL,'redditmedia');
DEL7 = strcmp(URL,'wikipedia');
DEL = [DEL1 DEL2 DEL3 DEL4 DEL5 DEL6 DEL7];
D = any(DEL,2);
URL(D,:) = [];
Karma(D) = [];


lowKarma = Karma < 25;
Karma(lowKarma) = [];
URL(lowKarma) = [];


% GET SOME SUMMARY STATS
sites = char(URL);
[cURL,ia,ic] = unique(sites,'rows');
csURL = cellstr(cURL);

nURL = nominal(URL,csURL);

summary(nURL)

URLcounts = levelcounts(nURL);

csURL(URLcounts<25,:) = [];
URLcounts(URLcounts<25,:) = [];

Website = csURL;
Submissions = URLcounts;

clearvars -except Website Submissions dirpath


T = table(Website,Submissions,'RowNames',Website);
disp(T)

[TD,index] = sortrows(T,{'Submissions','Website'},{'descend','ascend'});
disp(TD)

% TD.Website = categorical(TD.Website);

fh1=figure('Units','normalized','OuterPosition',[.1 .06 .8 .9],'Color','w'); % ,'MenuBar','none'
hax1 = axes('Position',[.08 .23 .88 .72],'Color','none');
ph1 = superbar(TD.Submissions);
hax1.XTick = .8:numel(TD.Submissions)-.2;
hax1.XTickLabels = TD.Website;
hax1.XTickLabelRotation = 45;
hax1.FontSize = 22;


pause(80)
end

