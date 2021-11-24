## Makie recipes

Makie.plottype(::RANSAC.ExtractedShape) = Visualize{<:Tuple{RANSAC.ExtractedShape{T}, RANSACCloud{A,B,C}}} where {T,A,B,C}

function Makie.plot!(plot::Visualize{<:Tuple{RANSAC.ExtractedShape{T}, RANSAC.RANSACCloud{A,B,C}}}) where {T,A,B,C}
    # retrieve plotted object
    shape = plot[:shape][]
    rcloud = plot[:ransaccloud][]

    # RANSACVisualizer.jl attributes
    pointsize    = plot[:pointsize][]
    showlegend   = plot[:showlegend][]
    legendtext   = plot[:legendtext][]
    colourtype   = plot[:colourtype][]

    color = colourtype === :bytype ? getcolour(shape) : get(colorschemes[:rainbow], rand())

    ind = shape.inpoints
    Makie.meshscatter!(plot, rcloud.vertices[ind], markersize=pointsize, color=color)
end

## Old, but working utilities

"""
    normalsforplot(verts, norms, arrowsize = 0.5)

Create an array of pair of points for plotting the normals with Makie.
Only the direction of the normals is presented, their size not.

# Arguments:
- `arrowsize`: scaling factor for the size of the lines.
"""
function normalsforplot(verts, norms, arrowsize = 0.5)
    @assert size(verts) == size(norms) "They should have the same size."
    as = arrowsize
    return [verts[i] => verts[i] + as .*normalize(norms[i]) for i in 1:length(verts) ]
end

function showcandlength(ck)
    for c in ck
        println("candidate length: $(length(c.inpoints))")
    end
end

function getrest(pc)
    return findall(pc.isenabled)
end

function showtype(l)
    for t in l
        println(t.shape)
    end
end

function givelargest(scoredshapes)
    sizes = [size(s.inpoints, 1) for s in scoredshapes]
    mind = argmax(sizes)
    println("Best: $mind. - $(scoredshapes[mind])")
    return scoredshapes[mind]
end

#=
"""
    showshapes!(s, pointcloud, candidateA; plotleg=true, texts=nothing, kwargs...)

Plot the candidates and color each one differently.

# Arguments
- `s::Scene`: Makie scene.
- `pointcloud::RANSACCloud`: a pointcloud from RANSAC.jl
- `candidateA::Vector{ExtractedShape}`: an array of primitives.
- `plotleg::Bool`: plot a legend?
- `texts::Union{nothing,Vector{String}}`: when `nothing` is passed (and `plotleg==true`), a default legend is generated.
- `kwargs...`: any keyword argument can be passed to `scatter()` in the function.
"""
function showshapes!(s, pointcloud, candidateA; plotleg=true, texts=nothing, kwargs...)
    colA = get.(Ref(colorschemes[:hsv]), range(0, stop=1, length=(size(candidateA,1)+1)))
    colA = deleteat!(colA, 1)
    texts_ = []
    for i in 1:length(candidateA)
        ind = candidateA[i].inpoints
        push!(texts_, RANSAC.strt(candidateA[i].shape)*"$i")
        scatter!(s, pointcloud.vertices[ind], color = colA[i]; kwargs...)
    end

    usetexts = texts === nothing ? texts_ : texts
    if plotleg
        if s.attributes[:show_axis][]
            sl = legend(s.plots[2:end], usetexts)
        else
            sl = legend(s.plots, usetexts)
        end
        sn = Scene(clear=false, show_axis = false)
        sn.center=false
        return vbox(s, sl, parent=sn)
    else
        return s
    end
end

"""
    showshapes(pointcloud, candidateA; plotleg=true, kwargs...)

Plot to a new scene. See [`showshapes!`](@ref).
"""
function showshapes(pointcloud, candidateA; plotleg=true, kwargs...)
    sc = Scene()
    showshapes!(sc, pointcloud, candidateA; plotleg=plotleg, kwargs...)
end


"""
    showbytype!(s, pointcloud, candidateA, plotleg=true; kwargs...)

Plot the candidates and color them based on their type.

# Arguments
- `s::Scene`: Makie scene.
- `pointcloud::RANSACCloud`: a pointcloud from RANSAC.jl
- `candidateA::Vector{ExtractedShape}`: an array of primitives.
- `plotleg::Bool`: plot a legend?
- `kwargs...`: any keyword argument can be passed to `scatter()` in the function.
"""
function showbytype!(s, pointcloud, candidateA, plotleg=true; kwargs...)
    #colors_ = []
    texts_ = []
    for i in eachindex(candidateA)
        c = candidateA[i]
        ind = c.inpoints
        colour = getcolour(c.shape)
        #push!(colors_, colour)
        push!(texts_, "$(RANSAC.strt(c.shape))$i")
        scatter!(s, pointcloud.vertices[ind], color = colour; kwargs...)
    end
    if plotleg
        if s.attributes[:show_axis][]
            sl = legend(s.plots[2:end], texts_)
        else
            sl = legend(s.plots, texts_)
        end
        sn = Scene(clear=false, show_axis = false)
        sn.center=false
        return vbox(s, sl, parent=sn)
    else
        return s
    end
end

"""
    showbytype(pointcloud, candidateA, plotleg=true; kwargs...)

Plot to a new scene. See [`showbytype!`](@ref).
"""
function showbytype(pointcloud, candidateA, plotleg=true; kwargs...)
    sc = Scene()
    showbytype!(sc, pointcloud, candidateA, plotleg; kwargs...)
end

function plotshape(shape::FittedShape; kwargs...)
    plotshape!(Scene(), shape; kwargs...)
end

function plotshape!(sc, shape::FittedPlane; scale=(1.,1.), color=(:blue, 0.1))
    # see project2plane
    o_z = normalize(shape.normal)
    o_x = normalize(arbitrary_orthogonal2(o_z))
    o_y = normalize(cross(o_z, o_x))

    p1 = shape.point
    p2 = p1 + scale[1]*o_x
    p3 = p1 + scale[1]*o_x + scale[2]*o_y
    p4 = p1 + scale[2]*o_y

    mesh!(sc, [p1,p2,p3], color=color, transparency=true)
    mesh!(sc, [p1,p3,p4], color=color, transparency=true)
    sc
end

function plotshape!(sc, shape::FittedSphere; scale=(1.,), color=(:blue, 0.1))
    mesh!(sc, Sphere(Point(shape.center), scale[1]*shape.radius), color=color, transparency=true)
end

function plotshape!(sc, shape::FittedCylinder; scale=(1.,), color=(:blue, 0.1))
    o = Point(shape.center)
    extr = o+scale[1]*Point(normalize(shape.axis))
    mesh!(sc, Cylinder(o, extr, shape.radius), color=color, transparency=true)
end

function shiftplane!(sc, p::FittedPlane, dist; kwargs...)
    newo = p.point+dist*normalize(p.normal)
    newp = FittedPlane(true, newo, p.normal)
    plotshape!(sc, newp; kwargs...)
end


=#

#=

"""
    drawcircles!(sc, points, r; kwargs...)

Use `strokecolor=:blue` or what you want.
"""
function drawcircles!(sc, points, r; kwargs...)
    ps = [Makie.Point2f0(p) for p in points]
    poly!(sc, [Circle(p, Float32(r)) for p in ps], color = (:blue, 0.0), transparency = true, strokewidth=1; kwargs...)
    sc
end

function wframe(ps, trs; kwargs...)
	vrts = [Point3(i[1], i[2], 0.) for i in ps]
	fces = [Face{3,Int}(i) for i in trs]
	tm = HomogenousMesh(vrts, fces, [], [], [], [], [])
	Makie.wireframe(tm; kwargs...)
end

function plotspantree!(s, points, tree; kwargs...)
	for (i, obj) in enumerate(tree)
		p2 = points[obj]
		lines!(s, (x->x[1]).(p2), (x->x[2]).(p2); kwargs...)
	end
	s
end
=#
