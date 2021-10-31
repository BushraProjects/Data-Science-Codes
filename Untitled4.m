 f = readtable('fuelEconomy','HeaderLines',4)
 f
 c = f.CombinedMPG
 nan = find(isnan(c) == false)
 f1 = f(nan,:)
 ft =f1. CombinedMPG
 array = {'Low','Medium','High'}
 md = discretize(ft,[0,20,30,70],'Categorical', array)
 class = f1.Class
 clca = categorical( class)
 f1.Class = []
 f1.Class = clca
 f1.CombinedMPG = []
 f1.CombinedMPG = md
 f1
 citympg = f1.CityMPG(f1.CombinedMPG =='Low')
 highwaympg =f1.HighwayMPG(f1.CombinedMPG == 'Low')
  citympg2 = f1.CityMPG(f1.CombinedMPG =='Medium')
 highwaympg2 =f1.HighwayMPG(f1.CombinedMPG == 'Medium')
  citympg3 = f1.CityMPG(f1.CombinedMPG =='High')
 highwaympg3 =f1.HighwayMPG(f1.CombinedMPG == 'High')
 figure
 scatter(citympg,highwaympg,35,'rd','filled')
 hold on
 scatter(citympg2,highwaympg2,35,'bd','filled')
 hold on
 scatter(citympg3,highwaympg3,35,'kd','filled')
 grid on
grid('minor')
axis('tight')
legend('Low','Medium','High')
xlabel('City MPG')
ylabel('Highway MPG')


