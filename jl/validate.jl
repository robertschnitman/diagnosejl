########################################################################################
### Robert Schnitman
### 2018-03-16
###
### PURPOSE: Common model statistics such as F, R^2, and RMSE in a vector.
###
### RECOMMENDED CITATION:
###  Schnitman, Robert (2018). validate.jl. https://github.com/robertschnitman/diagnoserjl
########################################################################################

##### === BEGIN === #####
function validate(model, dataframe = false)

  ### Type-checking ###
  modeltype = string(typeof(model))  
  contains(modeltype, "GLM") || error("This function only accepts GLM classes for now. Sorry!")  

  ### Statistics ###
  # deviance_residual = deviance(model) # Need only on GLM models, not OLS.
  mae             = mean(abs.(residuals(model)))
  mpe             = mean(residuals(model)./model.mf.df[1])  
  n               = nobs(model)
  residual_median = median(residuals(model))
  residual_mean   = mean(residuals(model))
  residual_sd     = std(residuals(model))
  rmse            = sqrt(mean(residuals(model).^2))
  rsq             = r2(model)
  ar2             = adjr2(model)
  # Need F-test and its p-value.
  
  ### Print Output
  common = DataFrame(n = n, ar2 = ar2, r2 = rsq, rmse = rmse, mae = mae, mpe = mpe, residual_mean = residual_mean, residual_median = residual_median, residual_sd = residual_sd)
  
  pivotdf = DataFrame(statistics = names(common), value = round.(common[1, :].columns, 6))
  
  if (dataframe == false)
    convert(Array, pivotdf)
  else
    pivotdf
  end
  
  # TO DO
  #   1. 2018-03-16 No residuals can be computed for GLM?
  
end

##### === END === #####
