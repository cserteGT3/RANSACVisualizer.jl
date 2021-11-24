module RANSACVisualizer

using LinearAlgebra

import Makie
import RANSAC
using StaticArrays
using ColorSchemes

export  showcandlength,
        getrest,
        showtype,
        givelargest

"""
    visualize(extractedshape)

Visualize RANSAC.jl `extractedshape` with various options:

* `pointsize`     - size of points in point set
* `showlegend`    - plot a legend? - to be implemented
* `legendtext`    - when `nothing` is passed (and `showlegend==true`), a default legend is generated. - to be implemented
* `colourtype`  - `:random` or `:bytype`
"""
@Makie.recipe(Visualize, shape, ransaccloud) do scene
    Makie.Attributes(;
    # RANSACVisualizer attributes
    pointsize     = Makie.theme(scene, :markersize),
    showlegend    = true,
    legendtext    = nothing,
    colourtype    = :bytype,
    )
end

include("visualizations.jl")
include("api.jl")
#include("cone3.jl")

end # module
