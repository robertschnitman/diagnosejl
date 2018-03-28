__precompile__()

module diagnoserjl

using DataFrames
using Plots
using GLM
	
include("diagnose.jl")
include("fitres.jl")
include("modeldf.jl")
include("validate.jl")
	
end # module
