clear all;


IP = '169.254.104.220';
%PC IP = '
port = 14000;
numberOfSamples = 20000;
t = tcpclient(IP,port); 

dataReadIn = []; 
while(length(dataReadIn)<numberOfSamples)
    %t.BytesAvailable
    dataReadIn = [dataReadIn,read(t,t.BytesAvailable,'int16')];
end

%disconnect from server
clear t

dataReadIn = (dataReadIn/4)+161; %Divide by 4 and then 
x =  1:1:length(dataReadIn);

close all;

figure(1);
plot(x,dataReadIn);
axis([0 length(dataReadIn) -8192 8192])

voltageOut = (double(dataReadIn)/(8192))*1.35;

figure(2);
plot(x,voltageOut);
axis([0 length(voltageOut) -1.0 1.0]);
%Remove repeated values 
repeatedRemoved = dataReadIn(diff([0 dataReadIn])~=0);

