clear
clc
x = readtable("medalcount.txt","Delimiter",'\t','headerline',4);
x
asia={'China  ','Korea ','Japan '};
europe={'Germany ','France ','Netherlands '};
africa={'Kenya ','Ethiopia ','Hungary '};


totalmedal = x.TotalMedals;
indextotalmedal=find(isnan(totalmedal) == false);
indexrecords = x(indextotalmedal, :);
for i = 1:length(asia)
    
    asiaselected = any(strcmp(indexrecords.Country, asia{i}),2);
    filtertableAsia(i,:) = indexrecords(asiaselected, :)
    
end

for i = 2:length(africa)
    
    africaselected = any(strcmp(indexrecords.Country, africa{i}),2);
    filtertableAfrica(i,:) = indexrecords(africaselected, :)
    
end



for i = 3:length(europe)
    
    europeselected = any(strcmp(indexrecords.Country, europe{i}),2);
    filtertableEurope(i,:) = indexrecords(europeselected, :)
    
end

asiaMedals=filtertableAsia.TotalMedals
africaMedals=filtertableAfrica.TotalMedals
europeMedals=filtertableEurope.TotalMedals

totalmedalasia=filtertableAsia.TotalMedals
totalmedalafrica=filtertableAfrica.TotalMedals
totalmedaleurope=filtertableEurope.TotalMedals

data = [totalmedalasia, totalmedalafrica, totalmedaleurope];
Alldata=data(1:3)
Alldata=data(4:6)
Alldata=data(7:9)
Alldata=Alldata'
figure;

HDataSeries = bar(Alldata, 'stacked')
set(gca, 'XTickLabel', {'asia','europe','africa',})
h1=xlabel("Country");
h2=ylabel("Medals");
set(h1, 'FontWeight','Bold','FontSize',11);
set(h2, 'FontWeight','Bold','FontSize',11);
h=gca
set(h, 'FontWeight','Bold','FontSize',11);
legend('asia','europe','africa')






