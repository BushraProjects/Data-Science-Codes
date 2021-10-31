f = readtable('fuelEconomy.txt','HeaderLine',4);

cmpg = f.CombinedMPG;


levels ={'low','medium','high'};

MPGClass = discretize(cmpg, [0 20 30 70],'Categorical',levels);
f.MPGClass = MPGClass
fuel.MPGClass = MPGClass;
city = f.CityMPG(fuel.MPGClass =='low')
highway = f.HighwayMPG(fuel.MPGClass == 'low')

plot(city,highway,'o');


