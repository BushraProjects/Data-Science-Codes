f = readtable('fuelEconomy.txt','HeaderLine',4);

cmpg = f.CombinedMPG;


levels ={'low','medium','high'};

MPGClass = discretize(cmpg, [0 20 30 70],'Categorical',levels);


f.CombinedMPG = MPGClass

cmpg = f.CityMPG (f.CombinedMPG =='High')

Hmpg = f.HighwayMPG (f.CombinedMPG == 'High')

city = cmpg([1:6], :)
high =  Hmpg([1:6], :)
y = [city,high]

barchart = bar([1:6], y, 'grouped')
set(gca,"XTickLabel",{'Record 1','Record 2','Record 3','Record 4','Record 5','Record 6'})
set(gca,"XTickLabelRotation",45)
x_shift = 0.15
text([1:6]-x_shift,y(:,1)+1, num2str(y(:,1)),'FontSize',12,'HorizontalAlignment','Center','Color',[0 0.447 0.7410])
text([1:6]+x_shift,y(:,2)+1, num2str(y(:,2)),'FontSize',12,'HorizontalAlignment','Center','Color',[0.85 0.325 0.098])
legend('City MPG','Highway MPG')
