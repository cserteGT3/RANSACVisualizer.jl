"""
    showgeometry!(scene, vs, ns; arrow = 0.5)

Show pointcloud with normals.
"""
function showgeometry!(scene, vs::Array{SVector{3,F},1}, ns::Array{SVector{3,F},1}; arrow = 0.5) where F
    plns = normalsforplot(vs, ns, arrow)
    scatter!(scene, vs)
    linesegments!(scene, plns, color = :blue)
    cam3d!(scene)
    scene
end

function showgeometry!(scene, vs, ns; arrow = 0.5)
    vsn = [SVector{3, Float64}(i) for i in vs]
    nsn = [SVector{3, Float64}(i) for i in ns]
    showgeometry(scene, vsn, nsn, arrow=arrow)
end

function showgeometry!(scene, m; arrow = 0.5)
    vsn = [SVector{3, Float64}(i) for i in m.vertices]
    nsn = [SVector{3, Float64}(i) for i in m.normals]
    showgeometry!(scene, vsn, nsn, arrow=arrow)
end

function showgeometry(m; arrow=0.5)
    s = Scene()
    showgeometry!(s, m, arrow=arrow)
end

function showgeometry(vs, ns; arrow=0.5)
    s = Scene()
    showgeometry!(s, vs, ns, arrow=arrow)
end

function showcandlength(ck)
    for c in ck
        println("candidate length: $(length(c.inpoints))")
    end
end

function showshapes!(s, pointcloud, candidateA; kwargs...)
    colscheme = ColorSchemes.gnuplot
    colA = get.(Ref(colscheme), range(0, stop=1, length=(size(candidateA,1)+1)))
    colA = deleteat!(colA, 1)
    for i in 1:length(candidateA)
        ind = candidateA[i].inpoints
        scatter!(s, pointcloud.vertices[ind], color = colA[i]; kwargs...)
    end
    s
end

function showshapes(pointcloud, candidateA; kwargs...)
    sc = Scene()
    showshapes!(sc, pointcloud, candidateA; kwargs...)
end

function getrest(pc)
    return findall(pc.isenabled)
end


function showtype(l)
    for t in l
        println(t.candidate.shape)
    end
end

function showbytype!(s, pointcloud, candidateA; kwargs...)
    colors_ = []
    texts_ = []
    for i in eachindex(candidateA)
        c = candidateA[i]
        ind = c.inpoints
        if c.candidate.shape isa FittedCylinder
            colour = :red
            push!(colors_, :red)
            push!(texts_, "cylinder")
        elseif c.candidate.shape isa FittedSphere
            colour = :green
            push!(colors_, :green)
            push!(texts_, "sphere")
        elseif c.candidate.shape isa FittedPlane
            colour = :orange
            push!(colors_, :orange)
            push!(texts_, "plane")
        elseif c.candidate.shape isa FittedCone
            colour = :blue
            push!(colors_, :blue)
            push!(texts_, "cone")
        elseif c.candidate.shape isa FittedTranslational
                colour = :purple
                push!(colors_, :purple)
                push!(texts_, "translational")
        end
        scatter!(s, pointcloud.vertices[ind], color = colour; kwargs...)
    end
    sl = legend(s.plots[2:end], texts_)
    vbox(s, sl)
end

function showbytype(pointcloud, candidateA; kwargs...)
    sc = Scene()
    showbytype!(sc, pointcloud, candidateA; kwargs...)
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

function plotimplshape!(sc, shape::ImplicitPlane; scale=(1.,1.), color=(:blue, 0.1))
    fp = FittedPlane(true, shape.point, shape.normal)
    plotshape!(sc, fp; scale=scale, color=color)
end

function plotimplshape!(sc, shape::ImplicitSphere; scale=(1.,1.), color=(:blue, 0.1))
    fs = FittedSphere(true, shape.center, shape.radius, true)
    plotshape!(sc, fs; scale=scale, color=color)
end

function plotimplshape!(sc, shape::ImplicitCylinder; scale=(1.,1.), color=(:blue, 0.1))
    fc = FittedCylinder(true, shape.axis, shape.center, shape.radius, true)
    plotshape!(sc, fc; scale=scale, color=color)
end

function plotimplshape(shape::CSGBuilding.AbstractImplicitSurface; scale=(1.,1.), color=(:blue, 0.1))
    s = Scene()
    plotimplshape!(s, shape; scale=scale, color=color)
end

function givelargest(scoredshapes)
    sizes = [size(s.inpoints, 1) for s in scoredshapes]
    mind = argmax(sizes)
    println("Best: $mind. - $(scoredshapes[mind])")
    return scoredshapes[mind]
end
