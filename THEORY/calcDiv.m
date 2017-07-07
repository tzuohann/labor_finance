function dividends = calcDiv(Output,tax,wage)
  %Calculate post tax dividends taking output, taxes and wages as given
  dividends = (1-tax)*(Output -  wage);
end