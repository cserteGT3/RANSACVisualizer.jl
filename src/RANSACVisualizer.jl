module RANSACVisualizer

using LinearAlgebra

using AbstractPlotting: Point3f0, legend
# using AbstractPlotting: Face
# using AbstractPlotting
using Makie: scatter, linesegments!, Scene, scatter!, lines, arrows!, wireframe, lines!
using Makie: mesh!, cam3d!, Sphere, Point
using GeometryTypes: Cylinder, Circle, HomogenousMesh, vertices, normals
using RANSAC
using StaticArrays
using ColorSchemes
using Parameters: @unpack

# for cone
# using Makie
# using GeometryTypes

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
        drawcircles!,
        wframe,
        plotspantree!,
        givelargest

# export  ConeMesh

include("visualizations.jl")
#include("cone3.jl")

end # module
