#!/usr/bin/env julia
if abspath(PROGRAM_FILE) == @__FILE__
    using Pkg
    Pkg.develop(PackageSpec(path = joinpath(@__DIR__, "..")))
    Pkg.activate(@__DIR__)
    Pkg.instantiate()
end

# This file was copied from Transducers.jl
# which is available under an MIT license (see LICENSE).
using PkgBenchmark
benchmarkpkg(
    dirname(@__DIR__),
    BenchmarkConfig(env = Dict("JULIA_NUM_THREADS" => "1")),
    resultfile = joinpath(@__DIR__, "result.json"),
)

include("pprintresult.jl")