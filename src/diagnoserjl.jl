__precompile__()

module diagnoserjl
	using DataFrames
	using Gadfly
	using GLM
	
	include("diagnose.jl")
	include("fitres.jl")
	include("modeldf.jl")
        include("validate.jl")
	
end # module
