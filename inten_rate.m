c= readmatrix('inten_rate.csv');

%%
plot (c(:,1),c(:,2), 'o-','MarkerFaceColor',[1 0 0],'MarkerEdgeColor',[1 0 0],'Color', [1 0 0], 'DisplayName','60 Hz');
hold on;
plot (c(:,1), c(:,3), 'o-','MarkerFaceColor',[0.9 0.4 0],'MarkerEdgeColor',[0.9 0.4 0],'Color', [0.9 0.4 0],'DisplayName','100 Hz');
legend;

hold on;
plot (c(:,1), c(:,4), 'o-','MarkerFaceColor',[1 0.87 0],'MarkerEdgeColor',[1 0.87 0],'Color', [1 0.87 0], 'DisplayName','200 Hz');

plot (c(:,1), c(:,5), 'o-','MarkerFaceColor',[0.4 1 0],'MarkerEdgeColor',[0.4 1 0],'Color', [0.4 1 0], 'DisplayName','400 Hz');
% plot (c(:,1), c(:,6), 'o-','MarkerFaceColor',[0 0.6 1],'MarkerEdgeColor',[0 0.6 1],'Color', [0 0.6 1], 'DisplayName','400 Hz');

set(gca, 'box', 'off');
xlim([-40 0]);
ylim([0 40]);
xticks(-40:20:0);
yticks(0:40:40);
%% for gecko paper
% plot (c(:,1), c(:,2), 'k-o','MarkerFaceColor','k');
% % hold on;
% % plot (c(:,1), c(:,3), 'k-square','MarkerFaceColor','k');
% % hold on;
% % plot (c(:,1), c(:,4), 'k-^', 'MarkerFaceColor','k');
% set(gca, 'box', 'off');
% xlim([-60 10]);
% xticks(-60:20:10);
% ylim([0 60])
% yticks(0:60:60);
