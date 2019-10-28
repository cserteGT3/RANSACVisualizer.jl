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

export  showgeometry,
        showcandlength,
        showshapes,
        getrest,
        showtype,
        showbytype,
        plotshape,
        plotshape!,
        plotimplshape,
        plotimplshape!

include("visualizations.jl")

end # module
