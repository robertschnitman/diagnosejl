"""
    fitres(model, nothing)
	
Generate fitted values and residuals into one array (or merge with a DataFrame).

INPUT: GLM object.

OUTPUT: array (or DataFrame if dataframe is set to a DataFrame object)).

# Definitions
fit = Fitted Values based on model object.  

residual = Model residuals.  

residual_pct = Model residuals in percentage (proportion) form.

# Examples
See https://github.com/robertschnitman/diagnoserjl.

"""

#####################################################################################
### Robert Schnitman
### 2018-03-12
###
### PURPOSE: Generate fitted values and residuals into one array (or merge with a DataFrame).
###
### INPUT: GLM object.  
### OUTPUT: array (or DataFrame if dataframe is set to a DataFrame object).
###
### RECOMMENDED CITATION:
###  Schnitman, Robert (2018). fitres.jl. https://github.com/robertschnitman/diagnoserjl
#####################################################################################

##### === BEGIN === #####

function fitres(model, data = nothing)

### 1. Set up variables to include in the final output ###
  fit = predict(model)   # Fitted values.
  res = residuals(model) # Residuals.
  act = res + fit        # Actual values.
  rem = res./act         # Residuals Margin (Residuals %). The dot(.) vectorizes the division.

### 2. Return array or merged DataFrame ###  
  datatype = string(typeof(data))
  
  fitresm = DataFrame(fit = fit, residual = res, residual_pct = rem)

  if (data == nothing)  
  
    fitresm # Array was the original plan a la` the matrix output in its R equivalent, 
	    #   but unnamed column headers in base Julia was a problem (i.e. which 
	    #   column belongs to fitted values, etc?).
	    # NamedArrays.jl could be an option, but DataFrames has more user reach.
	    # Users can always use convert() to obtain an Array instead.
	
  elseif (datatype == "DataFrames.DataFrame")    
	
	return hcat(data, fitresm)
	
  end
  
end

##### === END === #####
