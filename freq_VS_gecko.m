freq_VS_single = readmatrix('freq_VS_single.csv');
freq = freq_VS_single(:,1);
inten = freq_VS_single(:,2);
s =scatter (freq, inten,15);
% s.XJitter ="rand";
% s.XJitterWidth=0.8 * min(diff(unique(freq)));
% s.YJitter="rand";
% s.YJitterWidth= 0.2 * min(diff(unique(inten)));
s.MarkerEdgeColor = 'k';
s.MarkerFaceColor = 'k';
% s.MarkerEdgeColor = [0, 0.75, 0.75];
% s.MarkerFaceColor = [0, 0.75, 0.75];
%s.MarkerFaceAlpha = 0.5;
s.Marker = "o";

xlim([0 310]);
ylim([0 1]);
yticks(0:0.2:1);
xticks(0:100:300);