########################################################################################
### Robert Schnitman
### 2018-03-16
###
### PURPOSE: Produce common model statistics such as F, R^2, and RMSE in a vector.
###
### RECOMMENDED CITATION:
###  Schnitman, Robert (2018). validate.jl. https://github.com/robertschnitman/diagnoserjl
########################################################################################

##### === BEGIN === #####
function validate(model, dataframe = false)

  ### 1. Type-checking ###
  modeltype = string(typeof(model))  
  contains(modeltype, "GLM") || error("This function only accepts GLM classes for now. Sorry!")  

  ### 2. Statistics ###
  # deviance_residual = deviance(model) # Need only on GLM models, not OLS.
  
  r      = residuals(model) # Easier to read how the final statistics are computed.
  depvar = model.mf.df[1]   # Same as above.
  
  
  mae             = mean(abs.(r))
  medianpe        = median(r./depvar)
  mpe             = mean(r./depvar)
  sdpe            = std(r./depvar)
  n               = nobs(model)
  residual_median = median(r)
  residual_mean   = mean(r)
  residual_sd     = std(r)
  rmse            = sqrt(mean(r.^2))
  rsq             = r2(model)
  ar2             = adjr2(model)
  # Need F-test and its p-value.
  
  ### 3. Print Output ###  
  
  common = DataFrame(n = n, ar2 = ar2, r2 = rsq, rmse = rmse, mae = mae, medianpe = medianpe, mpe = mpe, sdpe = sdpe, residual_mean = residual_mean, residual_median = residual_median, residual_sd = residual_sd)
  
  pivotdf = DataFrame(statistic = names(common), value = round.(common[1, :].columns, 6))
  
  if (dataframe == false)
    convert(Array, pivotdf)
  else
    pivotdf
  end
  
  # TO DO
  #   1. 2018-03-16 No residuals can be computed for GLM?
  
end

##### === END === #####
