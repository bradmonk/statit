function [] = redditPRAW_TD()
clc; close all; clear;

dirpath = '/path/to/directory/with/statit/bot/output/data/';
filepath = '/path/to/directory/with/statit/bot/output/data/The_Donald.mat';
csvpath = '/path/to/directory/with/statit/bot/output/data/The_Donald.csv';

cd(dirpath)

load(filepath); % loads SubmissionURL & SubmissionScore

TD_Score = SubmissionScore;
TD_URL = cellstr(SubmissionURL);

%---------------------------
Rx1 = '(\/\/.{1,3}\.)';
Tx1 = '';
S1 = regexprep(TD_URL,Rx1,Tx1);

%---------------------------
Rx1 = '(mobile\.)|(upload\.)';
Tx1 = '';
S1 = regexprep(S1,Rx1,Tx1);

%---------------------------
Rx1 = '(http:)|(https:)|(http:\/\/)|(https:\/\/)|(\/\/)|(mobile\.)';
Tx1 = '';
S1 = regexprep(S1,Rx1,Tx1);

%---------------------------
Rx1 = ['(\.com\/).+|(\.net\/).+|(\.org\/).+|(\.gov\/).+|(\.uk\/).+|(\.be\/).+|(\.it\/).+'...
       '|(\.is\/).+|(\.st\/).+|(\.us\/).+|(\.online\/).+|(\.pw\/).+|(\.info\/).+|(\.in\/).+'...
       '|(\.land\/).+|(\.edu\/).+|(\.ga\/).+|(\.rs\/).+|(\.kr\/).+|(\.tmz\/).+|(\.media\/).+'...
       '|(\.jp\/).+|(\.se\/).+|(\.ga\/).+|(\.rs\/).+|(\.kr\/).+|(\.tmz\/).+|(\.media\/).+'...
       '|(\.ca\/).+|(\.au\/).+|(\.gop\/).+|(\.co\/).+|(\.biz\/).+|(\.io\/).+|(\.nl\/).+'];
Tx1 = '';
S1 = regexprep(S1,Rx1,Tx1);

%---------------------------
Rx1 = ['(\.com\/).*|(\.net\/).*|(\.org\/).*|(\.gov\/).*|(\.uk\/).*|(\.be\/).*|(\.it\/).*'...
       '|(\.is\/).*|(\.st\/).*|(\.us\/).*|(\.online\/).*|(\.pw\/).*|(\.info\/).*|(\.in\/).*'...
       '|(\.land\/).*|(\.edu\/).*|(\.ga\/).*|(\.rs\/).*|(\.kr\/).*|(\.tmz\/).*|(\.media\/).*'...
       '|(\.jp\/).*|(\.se\/).*|(\.ga\/).*|(\.rs\/).*|(\.kr\/).*|(\.tmz\/).*|(\.media\/).*'...
       '|(\.ca\/).*|(\.au\/).*|(\.gop\/).*|(\.co\/).*|(\.biz\/).*|(\.io\/).*|(\.nl\/).*'];   
Tx1 = '';
S1 = regexprep(S1,Rx1,Tx1);

%---------------------------
Rx1 = '(\.com$)|(\.net$)|(\.co$)';
Tx1 = '';
S1 = regexprep(S1,Rx1,Tx1);


% %----
% Rx1 = '(\/).*';
% Tx1 = '';
% S1 = regexprep(S1,Rx1,Tx1);

S1(1:2) = [];
TD_Score(1:2) = [];

z = zeros(1,size(S1,1));
for nn = 1:size(S1,1)
    
    a = strcmp(S1(nn),'reddit');
    b = strcmp(S1(nn),'redd');
    c = strcmp(S1(nn),'twitter');
    d = strcmp(S1(nn),'youtube');
    e = strcmp(S1(nn),'youtu');
    f = strcmp(S1(nn),'facebook');
    g = strcmp(S1(nn),'imgur');
    h = strcmp(S1(nn),'reddituploads');
    
    z(nn) = any([a,b,c,d,e,f,g,h]);

end

z = z>0;

S1(z) = [];
TD_Score(z) = [];

[URL, indx] = sort(S1);

Karma = TD_Score(indx);

clearvars -except URL Karma csvpath



T = readtable(csvpath,'Format','%s','ReadVariableNames',false,'HeaderLines',2);
dateTime = T{end,1}{1};
clearvars -except URL dateTime Karma

save(['TD_' dateTime(1:10) '.mat'],'URL','Karma')
end
