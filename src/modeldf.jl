"""
    modeldf(model, conf = 0.95)
	
Save model coefficients as a formatted data frame, along with margin of error and confidence intervals (MOE and CI level can be set between 0.00 and 1.00 with the conf input).

INPUT: GLM object.

OUTPUT: DataFrame.

# Definitions

b = Beta (coefficients).  

ci_lower = Lower bound of Confidence Interval.  

ci_upper = Upper bound of Confidence Interval.  

moe = Margin of Error.  

p = p value.  

se = Standard error.  

t (z, etc) = Test statistic value.  

terms = Intercept and independent variable names.

# Examples

See https://github.com/robertschnitman/diagnoserjl.

"""


######################################################################################
### Robert Schnitman
### 2018-03-16
###
### PURPOSE:
###   1. Save model coefficients as a formatted data frame.
###   2. Add/rename statistics for model results.
###
### OUTPUT = data frame.
###
### RECOMMENDED CITATION:
###  Schnitman, Robert (2018). modeldf.jl. https://github.com/robertschnitman/diagnoserjl
######################################################################################

##### === BEGIN === #####

function modeldf(model, conf = 0.95)

  ### 1. Type-checking ###  
  modeltype = string(typeof(model))
  
  typeof(conf) == String && error("Confidence level must be numeric, 0.00-1.00")
  contains(modeltype, "GLM") || error("This function only accepts GLM classes for now. Sorry!")

  ### 2. Define certain variables for the final dataframe for easier referencing ###
  vnm       = coeftable(model).rownms        
  b         = coef(model)
  test_stat = coeftable(model).cols[3]
  p         = coeftable(model).cols[4]
  cil       = confint(model, conf)[1:end, 1]
  ciu       = confint(model, conf)[1:end, end]    

  ### 3. Set up dataframe ###
  mdf = DataFrame(terms = vnm, beta = b, se = stderr(model), moe = ciu .- b,  ci_lower = cil, ci_upper = ciu, test = test_stat, p = p)
  # beta + moe = ciu --> moe = ciu - beta.

  # Rename test statistic to match test used in model.
  mdf = rename(mdf, [:test], [Symbol(string(coeftable(model).colnms[3])[1])])
    
end
  
##### === END === #####
