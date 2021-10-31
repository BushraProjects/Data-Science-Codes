
x = readtable("medalcount.txt","Delimiter",'\t','headerline',4);
TF = (x.TotalGold > 16)
upDate = x(TF,:)

menGoldFiltered = upDate.TotalGold
menGoldCountries = upDate.Country

%%figure
bar(menGoldFiltered, 'hist')
set(gca, 'XTicklabel',menGoldCountries)
%%Legend ('Golden Medal')
xlabel('Countries')
ylabel('Medals')