clear
clc
table = readtable('medalcount.txt', 'Delimiter','\t', 'Headerline', 4)

womanGold= find(isnan(table.WomenSilver) == false);

records = table(womanGold, :)

countriesSelected = {'Korea ', 'Germany ', 'Great Britain '}

for i = 1:length(countriesSelected)
    
    temp = any(strcmp(records.Country, countriesSelected{i}),2);
    
    filteredCountries(i,:) = records(temp, :);
end

filtered_Countries = filteredCountries.Country;
filtered_data = filteredCountries.WomenSilver;

figure
p1 = bar (filtered_data,  'hist')
set(gca, 'XTickLabel', filtered_Countries)
set(p1, 'FaceColor', 'blue')
legend('WomenMedal')
xlabel ('Countrie')
ylabel ('WomenGold')


