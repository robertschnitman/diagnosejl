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

  ### Type-checking ###  
  modeltype = string(typeof(model))
  
  typeof(conf) == String && error("Confidence level must be numeric, 0.00-1.00")
  contains(modeltype, "GLM") || error("This function only accepts GLM classes for now. Sorry!")

  ### Define certain variables for the final dataframe for easier referencing ###
  vnm       = coeftable(model).rownms        
  b         = coef(model)
  test_stat = coeftable(model).cols[3]
  p         = coeftable(model).cols[4]
  cil       = confint(model, conf)[1:end, 1]
  ciu       = confint(model, conf)[1:end, end]    

  ### Set up dataframe ###
  mdf = DataFrame(terms = vnm, beta = b, se = stderr(model), moe = ciu .- b,  ci_lower = cil, ci_upper = ciu, test = test_stat, p = p)
  # beta + moe = ciu --> moe = ciu - beta.

  # Rename test statistic to match test used in model.
  mdf = rename(mdf, [:test], [Symbol(string(coeftable(model).colnms[3])[1])])
    
end
  
##### === END === #####
