########################################################################################
### Robert Schnitman
### 2018-03-21
###
### PURPOSE: Scatterplots of fit vs. residuals/residuals margin, as well as histograms of residuals/residuals margin
###
### INPUT: GLM object.
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
  rem = res./act             # Residuals Margin
  
  
  ### 3. Print Output ###
  rvf1 = plot(x = fit, y = res, 
              Geom.point, Geom.smooth,
			  Guide.xlabel("Fitted Values"), Guide.ylabel(""), 
			  Guide.title("Residuals vs. Fitted Values"))
			  
  rvf2 = plot(x = fit, y = rem, 
              Geom.point, Geom.smooth,
			  Guide.xlabel("Fitted Values"), Guide.ylabel(""),
			   Guide.title("Residuals (%) vs. Fitted Values"))

  hist1 = plot(x = res, Geom.histogram, Guide.xlabel("Residuals"))
  hist2 = plot(x = rem, Geom.histogram, Guide.xlabel("Residuals (%)"))	 
  
  gridstack([rvf1 rvf2; hist1 hist2])
  
end

##### === END === #####