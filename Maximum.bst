:: n, read()
:: vals, |[n] : () => read()|
:: max, [vals][1]
|[n] : (i) => (([vals][i] > [max]) ? [vals][i] -> [max] : [0])|
write([max])
