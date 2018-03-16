__precompile__()

module diagnoserjl
	using DataFrames
	# using Gadfly # don't import Gadfly until diagnose() has been developed.
	using GLM
	
	include("fitres.jl")
	include("modeldf.jl")
        include("validate.jl")
	
end # module
