"""

    validate(model, false)
	
Produce common model statistics such as R^2, RMSE, and MPE in a vector. The model input is a GLM object, outputting to an array if dataframe = false.

# Definitions
  aer               = Apparent Error Rate, defined as the proportion of misclassifications relative to total number of cases.

  ar2               = Adjusted R-Squared.  
  
  deviance_residual = Residual Deviance, which uses deviance() from the GLM library.
  
  mad               = Median Absolute Deviation.  
  
  mae               = Mean Absolute Error.  
  
  medianpe          = Median Percent Error.
  
  mpe               = Mean Percentage Error.  
  
  n                 = Number of Observations (that are used in the model object).  
  
  residual_mean     = Mean Residual.  
  
  residual_median   = Median Residual.  
  
  residual_sd       = Standard Deviation of the Residual.  
  
  residual_se       = Standard Error of the Residual.  
  
  rmse              = Root Mean Square Error.  
  
  rsq               = R-Squared.  
  
  sdpe              = Standard Deviation of the Percentage Error.  
  
  sepe              = Standard Error of the Percentage Error.  
  
# Examples
See https://github.com/robertschnitman/diagnoserjl.
  
"""

########################################################################################
### Robert Schnitman
### 2018-03-16
###
### PURPOSE: Produce common model statistics such as R^2, RMSE, and MPE in a vector.
###
### RECOMMENDED CITATION:
###  Schnitman, Robert (2018). validate.jl. https://github.com/robertschnitman/diagnoserjl
########################################################################################

##### === BEGIN === #####
function validate(model, dataframe = false)

  ### 1. Type-checking ###
  modeltype = string(typeof(model))  
  contains(modeltype, "GLM") || error("This function only accepts GLM classes for now. Sorry!")  

  ### 2. Common Statistics ###
  #  # Need only on GLM models, not OLS.
  n      = nobs(model)
  depvar = model.mf.df[1]   # Same as above.
  yhat   = predict(model)

  # Need F-test and its p-value.

  
  ### 3. Print Output ###      
  
  if contains(modeltype, "GLM.LinearModel")
    r      = residuals(model) # Easier to read how the final statistics are computed.
  
	mad             = median(abs.(r .- median(r)))
	mae             = mean(abs.(r))
	medianpe        = median(r./depvar)
	mpe             = mean(r./depvar)
	sdpe            = std(r./depvar)
	sepe            = sdpe/sqrt(n)
	
	residual_median = median(r)
	residual_mean   = mean(r)
	residual_sd     = std(r)
	residual_se     = residual_sd/sqrt(n)
	rmse            = sqrt(mean(r.^2))
	rsq             = r2(model)
	ar2             = adjr2(model)
	
	output = DataFrame(n = n, ar2 = ar2, r2 = rsq, rmse = rmse, mad = mad, mae = mae, medianpe = medianpe, mpe = mpe, sdpe = sdpe, sepe = sepe, residual_mean = residual_mean, residual_median = residual_median, residual_sd = residual_sd, residual_se = residual_se)    
    
  elseif contains(modeltype, "Binomial")	
    aer = length(yhat[yhat != depvar])/length(depvar)
	
	output = DataFrame(n = n, deviance_residual = deviance(model), aer = aer) 
  
  end
  
  pivotdf = DataFrame(statistic = names(output), value = round.(output[1, :].columns, 6))
  
  if (dataframe == false)
    convert(Array, pivotdf) # statistic column otputs keys
  else
    pivotdf
  end
  
  # TO DO
  #   1. 2018-03-16 No residuals can be computed for GLM?
  
end

##### === END === #####
