using Finch
using Pigeon
using Test
using MacroTools

using Finch: VirtualAbstractArray, Run, Spike, Extent, Scalar, Cases, Stepper, AcceptRun, AcceptSpike, Thunk, execute_code_lowered
using Pigeon: getname

@testset "Finch.jl" begin

    include("fibers.jl")
    include("parse.jl")
    include("simplevectors.jl")

end