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

export  showgeometry,
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

include("visualizations.jl")

end # module
