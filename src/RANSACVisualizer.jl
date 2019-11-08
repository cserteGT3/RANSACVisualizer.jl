module RANSACVisualizer

using LinearAlgebra

using AbstractPlotting: Point3f0, legend
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

# for raytracer
#using ImageView
using Images
using ColorVectorSpace
using Colors
#using Dates
using SignedDistanceFields

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

export  AbstractCamera,
        IsometricCamera,
        PinholeCamera,
        RayResults,
        raymarch,
        los

include("visualizations.jl")
include("cone3.jl")
include("raytracer/raymarching.jl")
include("raytracer/camera.jl");

end # module
