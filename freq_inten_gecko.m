freq_inten_single = readmatrix('freq_inten_single.csv');
freq = freq_inten_single(:,1);
inten = freq_inten_single(:,2);
s =scatter (freq, inten,'DisplayName','single unit');
s.XJitter ="rand";
s.XJitterWidth=0.8 * min(diff(unique(freq)));
s.YJitter="rand";
s.YJitterWidth= 0.2 * min(diff(unique(inten)));
s.MarkerEdgeColor = 'k';
s.MarkerFaceColor = [0.7 0.7 0.7];
% s.MarkerEdgeColor = [0, 0.75, 0.75];
% s.MarkerFaceColor = [0, 0.75, 0.75];
%s.MarkerFaceAlpha = 0.5;
s.Marker = "o";
legend;

hold on;
freq_inten_multi = readmatrix('freq_inten_multi.csv');
freq = freq_inten_multi(:,1);
inten = freq_inten_multi(:,2);
s =scatter (freq, inten,'DisplayName','multi unit');
s.XJitter ="rand";
s.XJitterWidth=0.8 * min(diff(unique(freq)));
s.YJitter="rand";
s.YJitterWidth= 0.2 * min(diff(unique(inten)));
s.MarkerEdgeColor = 'none';
s.MarkerFaceColor = 'b';
% s.MarkerEdgeColor = [0, 0.75, 0.75];
% s.MarkerFaceColor = [0, 0.75, 0.75];
s.MarkerFaceAlpha = 0.5;
s.Marker = "^";
legend;



xlim([0 310]);
ylim([-80 10]);
yticks(-80:20:0);
xticks(0:100:300);