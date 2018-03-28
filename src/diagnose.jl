"""
    diagnose(model)
	
Scatterplots of fit vs. residuals/residuals , as well as histograms of residuals and residuals %.

INPUT: GLM object.

OUTPUT: 2x2 graph.

# Examples
See https://github.com/robertschnitman/diagnoserjl.

"""


########################################################################################
### Robert Schnitman
### 2018-03-21
###
### PURPOSE: Scatterplots of fit vs. residuals/residuals , as well as histograms of residuals/residuals .
###
### INPUT: GLM object.
### OUTPUT: 2x2 graph.
###
### RECOMMENDED CITATION:
###  Schnitman, Robert (2018). diagnose.jl. https://github.com/robertschnitman/diagnoserjl
########################################################################################

##### === BEGIN === #####
function diagnose(model)

  ### 1. Type-checking ###
  modeltype = string(typeof(model))  
  contains(modeltype, "GLM") || error("This function only accepts GLM classes for now. Sorry!")  

  ### 2. Obtain residuals and fitted values ###
    
  fit = predict(model)      # Fitted values.
  res = residuals(model)    # Residuals.
  act = res + fit           # Actual values. 
  rem = (res./act).*100     # Residuals %.
  
  
  ### 3. Print Output ###
  rvf1 = scatter(fit, res, ylabel = "Residuals", title = "Residuals vs. Fitted Values")
				
  rvf2 = scatter(fit, rem, ylabel = "Residuals (%)", title = "Residuals (%) vs. Fitted Values")

  hist1 = histogram(res, xlabel = "Residuals", ylabel = "Frequency", bins = length(fit))
  hist2 = histogram(rem, xlabel = "Residuals (%)", ylabel = "", bins = length(fit))
  
  plot(rvf1, rvf2, hist1, hist2, layout = (2,2), legend = false)
  
end

##### === END === #####
