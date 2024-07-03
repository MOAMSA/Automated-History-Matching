function Out_put=test(data)
% This program couples the softwares Eclipse and Matlab
%
% Reading the data file
%
fid1 = fopen('CASE.DATA','rt') ;
fid2 = fopen('Output.DATA','wt') ;
%fgetl selects the next line of the fid1
tline = fgetl(fid1) ;
%
% Editing the data file
%
%num2str converts the number intered in data to character in data file.(the input data)
I_I = num2str(data(1)) ;
I_J = num2str(data(2)) ;
INJ_RATE = num2str(data(3)) ;
Perf1=num2str(data(4));
% We have to write num2str(data(4)) instead of Perf1 ======================
% Because 7 is number and Perf1 is chareacter and they can't sum together so it's better to sum both in num2str type.
Perf2=num2str(data(4)+8);
if (data(1)==8 && data(2)==19) || (data(1)==22 && data(2)==14) || (data(1)==10 &&  data(2)==19)|| (data(1)==24 && data(2)==17) || (data(1)==27 && data(2)==14) || (data(1)==26 &&  data(2)==15)|| (data(1)==7 && data(2)==16) || (data(1)==25 && data(2)==16) || (data(1)==5 && data(2)==2)
    data(1)=17;
    data(2)=8;
    I_I=num2str(data(1));
    I_J=num2str(data(2));
end

%ischar means tline is character or not and its duty is taking all lines of the fid1 to the end when they are character.
while ischar(tline)
    str = fprintf(fid2,'%s\n',tline) ;
    % strtok  takes the 1st word of the line in tline.
    nline = strtok(tline) ;
    %strcmp  compares 2 characters with each other throughly (copmare whit our target for example --WELL_PLACEMENT)
    a1 = strcmp(nline,'--WELL_PLACEMENT') ;
    if a1 == 1
        tline1 = fgetl(fid1) ;
        %strrep  replace the input data instead of old data (ex: [I_I '  ' I_J] to 'XX  YY' in the tline1)
        rep_str = strrep(tline1,'XX  YY',[I_I '  ' I_J]) ;
        str = fprintf(fid2,'%s\n',rep_str) ;
    end
    a2 = strcmp(nline,'--COMP') ;
    if a2 == 1
        tline2 = fgetl(fid1) ;
        rep_str = strrep(tline2,'XX  YY  Z1  Z2',[I_I '  ' I_J '  ' Perf1 '  ' Perf2]) ;
        str = fprintf(fid2,'%s\n',rep_str) ;
    end
    a3 = strcmp(nline,'WCONINJ') ;
    if a3 == 1
        tline3 = fgetl(fid1) ;
        rep_str = strrep(tline3,'INJ_RATE',INJ_RATE) ;
        str = fprintf(fid2,'%s\n',rep_str) ;
    end
    tline = fgetl(fid1);
end
fclose(fid1) ;
fclose(fid2) ;
%
% Running the data file with ECLIPSE
%
a = system('coupling.bat') ;
%
% Reading the output data
%

fid = fopen('Output.RSM') ;
tline = fgetl(fid) ;
kk = 1 ;
jj = 0 ;
% Finde character SUMMARY==================================================
while kk == 1
    tline = strtok(tline) ;
    aa = strcmp(tline,'SUMMARY') ;
    if aa == 1
        kk = 0 ;
    end
    tline = fgetl(fid);
    jj = jj+1 ;
end
kk = 1 ;
% Finde zero (0) which means 1st line of the data from OUTPUT.RSM =========
% tline = zero (0)
while kk == 1
    tt = strtok(tline) ;
    aa = strcmp(tt,'0') ;
    if aa == 1
        kk = 0 ;
    else
        tline = fgetl(fid) ;
    end
    jj = jj+1 ;
end
% Define a empty Array ====================================================
M = [] ;
% Transfering the values after tline to Array  M  in row(we should use ;)==

while ischar(tline)
    %deblank removes any trailing space characters from string tline ======
    tline = deblank(tline) ;
    % str2num converts a string character to number =======================
    MM = str2num(tline);
    M =[M;MM];
    tline = fgetl(fid);
    jj = jj+1 ;
end
Out_put = -max(M(:,3));
fclose(fid) ;




