module RANSACVisualizer

using LinearAlgebra

using AbstractPlotting: Point3f0, legend, Face
using AbstractPlotting
using Makie: scatter, linesegments!, Scene, scatter!, lines, arrows!, wireframe, lines!
using Makie: mesh!, cam3d!, Sphere, Point
using GeometryTypes: Cylinder, Circle, HomogenousMesh
using RANSAC
using RANSAC: midpoint, contournormal, outwardsnormal, segmentnormal
using RANSAC: AbstractTranslationalSurface
using StaticArrays
using CSGBuilding
using ColorSchemes
using Parameters: @unpack

# for cone
using Makie
# using AbstractPlotting
# using FileIO
using GeometryTypes
#using Reactive

#=
# for raytracer
#using ImageView
using Images
using ColorVectorSpace
using Colors
#using Dates
using SignedDistanceFields
=#

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
        drawcircles!,
        wframe,
        plotspantree!,
        givelargest

export  ConeMesh

#=
export  AbstractCamera,
        IsometricCamera,
        PinholeCamera,
        RayResults,
        raymarch,
        los,
        DefIsoCam,
        DefPinCam

export  render,
        DefaultShaderArray
=#
export  plotcontour,
        compandcenter,
        translheatmap,
        translheatmap!

include("visualizations.jl")
include("cone3.jl")
include("translational.jl")
#include("raytracer/raymarching.jl")
#include("raytracer/camera.jl");
#include("raytracer/render.jl");

end # module
