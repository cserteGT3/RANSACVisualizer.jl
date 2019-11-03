module RANSACVisualizer

using LinearAlgebra

using AbstractPlotting: Point3f0
using AbstractPlotting
using Makie: scatter, linesegments!, Scene, scatter!
using Makie: mesh!, cam3d!, Sphere, Point
using GeometryTypes: Cylinder
using RANSAC
using StaticArrays
using CSGBuilding
using ColorSchemes

# for cone
using Makie
# using AbstractPlotting
# using FileIO
using GeometryTypes
using Reactive

export  showgeometry,
        showgeometry!,
        showcandlength,
        showshapes,
        showshapes!,
        getrest,
        showtype,
        showbytype,
        showbytype!,
        plotshape,
        plotshape!,
        plotimplshape,
        plotimplshape!,
        givelargest

export  ConeMesh

include("visualizations.jl")
include("cone3.jl")

end # module
