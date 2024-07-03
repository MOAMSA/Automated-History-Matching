clear;
clc;
load('Address.mat')
output=zeros(length(Address),3);
for ii=1:length(Address)
    fRSM=fopen('ILAM_HIST.RSM');
    RSM_RESULT = fgetl(fRSM);
    RESULT=[];
    output(ii,1:2) = Address(ii,1:2);
while ischar(RSM_RESULT)
    if strcmp(cellstr(RSM_RESULT(2:5)),num2str(Address(ii,1)))==1
       
        RESULT=[RESULT RSM_RESULT];
    end
   RSM_RESULT = fgetl(fRSM);
end
RESULT=str2num(RESULT);
RESULT(21)=[];
RESULT(11)=[];
RESULT(1:2)=[];
output(ii,3) = RESULT(1,Address(ii,4)) ;
fclose(fRSM);
end
