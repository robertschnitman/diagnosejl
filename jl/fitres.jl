#####################################################################################
### Robert Schnitman
### 2018-03-12
###
### PURPOSE: Generate fitted values and residuals into one array (or DataFrame).
###
### INPUT: model
### OUTPUT: array (or DataFrame).
###
### RECOMMENDED CITATION:
###  Schnitman, Robert (2018). fitres.jl. https://github.com/robertschnitman/diagnosejl
#####################################################################################

function fitres(model, dataframe = false)

### 1. Set up variables to include in the final output ###
  fit = predict(model)      # Fitted values.
  res = residuals(model_lm) # Residuals.
  act = res + fit           # Actual values.
  rem = res./act            # Residuals Margins (Residuals %). The dot(.) vectorizes the division.

### 2. Return array or DataFrame ###  
  if (dataframe == false)
    return hcat(fit, res, rem)
  else
    return DataFrame(fit = fit, residual = res, residual_margin = rem)
  end
  
end
