function [Te,Final,Final2]=EstimateElectronTemperature_Reverse(shot_location,cal_location,shot_seq_port,where_to_look,row,col1,FilterFileName,FilterFileName2,t1,t2,one_or_two)


smoothing_type='movmean'; 
params=GrabParams_v2(shot_seq_port); %arg(GrabParams)=(ShotDate_ShotSeq,port) 
Range=RealUnits2Pixels(1.35,params);
Z=(1.35/Range)*[0:1:Range]; 
Avg_Range=RealUnits2Pixels((0.3)/2,params);
smooth_pixels=11;
T=logspace(2,4,1001); %Defining temperature range
Q=strsplit(shot_seq_port,'_');
H1=strsplit(FilterFileName,'_');
H2=strsplit(FilterFileName2,'_');

col2=col1+1;
[lineout,lineout2,S,Final,Final2,R,G,~]=PinholeAnalysis_WIP(shot_location,cal_location,shot_seq_port,row,col2,col1,smoothing_type,smooth_pixels,where_to_look,Avg_Range,FilterFileName,FilterFileName2,t1,t2);
%S=1./S;
final_lineout_error=lineout_error(S);

% [Te1,~]=FindTemp(R(:,1),mean(S(:,2))+final_lineout_error,T,params);
% [Te,~]=FindTemp(R(:,2),mean(S(:,2)),T,params);
% [Te2,~]=FindTemp(R(:,2),mean(S(:,2))-final_lineout_error,T,params);

[Te1,~]=FindTemp(G(:,1),(mean(S(:,2)))+(final_lineout_error),T,params);
[TeN,~]=FindTemp((R(:,2)),(mean(S(:,2))),T,params);
[Te2,~]=FindTemp(G(:,2),(mean(S(:,2)))-(final_lineout_error),T,params);


Te=[Te1 TeN Te2];

T_Error_High=Te1-TeN;
T_Error_Low=TeN-Te2;

 figure() %%%%%%%%%%%%%%%%%%%%%
plot(Z,lineout,'b','LineWidth',2)
hold on
plot(Z,lineout2,'r','LineWidth',2)
set(gca, 'YScale', 'log')
ylim([0.0001 10])
xlabel('Z(mm)')
ylabel('Signal (Arb.)')
set(gca,'FontSize',35)
set(gca,'LineWidth',2)
legend('Low filter','High filter')
% if isequal(FilterFileName2,'Be_10um.txt')==1
% eval(['title("N' char(Q(1)) '/' char(Q(2)) '/' char(Q(3)) ' | Filters: (' char(H1(1)) ', [' char(H1(1)) '|' char(H2(1)) ']) = (' num2str(t1) 'mm, [' num2str(t1) 'mm/' num2str(t2) 'mm])")'])
% else
% eval(['title("N' char(Q(1)) '/' char(Q(2)) '/' char(Q(3)) ' | Filters: [' char(H1(1)) ',' char(H2(1)) '] = [' num2str(t1) 'mm,' num2str(t2) 'mm]")'])
% end


% 
% 
figure()%%%%%%%%%%%%%%%%%%%%%%%%
plot(Z,S(:,2),'r','LineWidth',2)
hold on
plot(Z,mean(S(:,2))*((zeros(size(Z,2),1))+1),'--b','LineWidth',2)
xlabel('Z(mm)')
ylabel('Signal Ratio')
set(gca,'FontSize',35)
set(gca,'LineWidth',2)
eval(['legend("Signal Ratio","Mean ~ ' num2str(mean(S(:,2))) '")'])
Q=strsplit(shot_seq_port,'_');
H1=strsplit(FilterFileName,'_');
H2=strsplit(FilterFileName2,'_');
% if isequal(FilterFileName2,'Be_10um.txt')==1
% eval(['title("N' char(Q(1)) '/' char(Q(2)) '/' char(Q(3)) ' | Filters: (' char(H1(1)) ', [' char(H1(1)) '|' char(H2(1)) ']) = (' num2str(t1) 'mm, [' num2str(t1) 'mm/' num2str(t2) 'mm])")'])
% else
% eval(['title("N' char(Q(1)) '/' char(Q(2)) '/' char(Q(3)) ' | Filters: [' char(H1(1)) ',' char(H2(1)) '] = [' num2str(t1) 'mm,' num2str(t2) 'mm]")'])
% end
%eval(['title("Shot/Seq/Port = ' char(Q(1)) ', Seq = ' char(Q(2)) ', Port = ' char(Q(3)) ',")'])

% figure()
% plot(T,R)
% ylabel('Ratio')
% xlabel('T')
% xlim([100 1000])
% set(gca, 'YScale', 'log')
% set(gca, 'XScale', 'log')
% ylim([0.005 1])

% S_O=0.182;
% T_S_O=359.7493;
% 
% F_O=0.1145;
% T_F_O=274.1574;
% 
% T2P=[T_S_O T_F_O];
% S2P=[S_O F_O];

figure()
curve1 = (G(:,1))';
curve2 = (R(:,2))';
curve3 = (G(:,2))';
plot(T, curve2, 'w', 'LineWidth', 1);
x1 = [T, fliplr(T)];
inBetween = [curve1, fliplr(curve3)];
fill(x1, inBetween,[0.5 0.5 0.5]);
hold on
plot(T, curve2, 'k', 'LineWidth', 1);
hold on
% plot(T_S_O,S_O,'sr','MarkerSize',8)
% hold on
% plot(T_F_O,F_O,'sg','MarkerSize',8)
errorbar(TeN,mean(S(:,2)),final_lineout_error,final_lineout_error,T_Error_Low,T_Error_High,'s','MarkerSize',3.5,'MarkerEdgeColor','blue','MarkerFaceColor','blue','Color','b','LineWidth',1)
xlim([100 1600])
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
eval(['legend("","","T_{e} ~ ' num2str(round(TeN)) ' eV")'])
min_R=min(R(:,2));
ylim([min_R 1])
ylabel('Ratio')
xlabel('T_{e} (eV)')
set(gca,'FontSize',35)
set(gca,'LineWidth',2)
% if isequal(FilterFileName2,'Be_10um.txt')==1
% eval(['title("N' char(Q(1)) '/' char(Q(2)) '/' char(Q(3)) ' | Filters: (' char(H1(1)) ', [' char(H1(1)) '|' char(H2(1)) ']) = (' num2str(t1) 'mm, [' num2str(t1) 'mm/' num2str(t2) 'mm])")'])
% else
% eval(['title("N' char(Q(1)) '/' char(Q(2)) '/' char(Q(3)) ' | Filters: [' char(H1(1)) ',' char(H2(1)) '] = [' num2str(t1) 'mm,' num2str(t2) 'mm]")'])
% end



end


