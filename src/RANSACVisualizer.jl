module RANSACVisualizer

using LinearAlgebra

using AbstractPlotting: Point3f0
using Makie: scatter, linesegments!, Scene, scatter!
using Makie: mesh!, cam3d!, Sphere, Point
using GeometryTypes: Cylinder
using RANSAC
using StaticArrays

export  showgeometry,
        showcandlength,
        showshapes,
        getrest,
        showtype,
        showbytype,
        plotshape,
        plotshape!

include("visualizations.jl")

end # module
