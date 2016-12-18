# Least five commodity prices from Yahoo Finance
# source: http://finance.yahoo.com/commodities?ltr=1
[
    { name: 'GC=X'},
    { name: 'ZG=X'},
    { name: 'ZG=F'},
    { name: 'SI=F'},
    { name: 'ZI=F'}
].each do |commodity_attributes|
  Commodity.create(commodity_attributes)
end