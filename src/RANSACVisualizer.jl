module RANSACVisualizer

using LinearAlgebra

using AbstractPlotting: Point3f0
using Makie: scatter, linesegments!, Scene, scatter!
using Makie: mesh!, cam3d!, Sphere, Point
using GeometryTypes: Cylinder
using RANSAC

export  showgeometry,
        showcandlength,
        showshapes,
        getrest,
        showtype,
        showbytype,
        plotshape,
        plotshape!

end # module
