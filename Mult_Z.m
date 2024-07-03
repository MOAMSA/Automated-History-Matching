function y=Mult_Z(MULTz)
fReg=fopen('Region.txt','rt') ;
REG=textscan(fReg,'%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s','HeaderLines',13) ;
fclose(fReg) ;
% MULTz=0.5*ones(1,31) ;
for jj=1:17
    for kk=1:2244
    CELL=char(REG{jj}(kk)) ;
    ISstar=CELL(CELL=='*') ;
    if strcmp(ISstar,'*')==1
       Region_num=str2num(CELL(1+findstr(CELL,'*'):end)) ;
        CELL=[CELL(1:findstr(CELL,'*')) num2str(MULTz(Region_num),'%5.4f')] ;
    else
        CELL=num2str(MULTz(Region_num),'%5.4f') ;
    end
    MULT_CELL{jj,kk}=CELL ;
    end
end
MULT_CELL = MULT_CELL' ;
fMULT=fopen('MULTz.DATA','wt') ;
fprintf( fMULT,'MULTZ\n')
for zz=1:2244
Cell2char=char(MULT_CELL{zz:2244:17*2244}) ;
MainCell2char=[] ;
for hh=1:17
    MainCell2char=[MainCell2char '  '  Cell2char(hh,:)] ;
end
fprintf( fMULT,'%s\n',MainCell2char') ;
end
fprintf( fMULT,'/\n')
fclose(fMULT) ;