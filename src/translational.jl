"""
    plotcontour(shape, plotnormals = false, noutw=false)

Plot the contour of a `ExtractedTranslational`.
`noutw==false` means that the normals point outwards, otherwise they point where the were fitted.
"""
function plotcontour(shape, plotnormals = false, noutw=false)
    segs = shape.contour

    sct = lines(segs, scale_plot=false)
    if plotnormals
        tms = [midpoint(segs, i) for i in eachindex(segs)]
        if noutw
            tns = [outwardsnormal(shape, i) for i in eachindex(segs)]
        else
            tns = [contournormal(shape, i) for i in eachindex(segs)]
        end
        scatter!(sct, tms, color=:red, scale_plot=false)
        x_ = (x->x[1]).(tms)
        y_ = (x->x[2]).(tms)
        u_ = (x->x[1]).(tns)
        v_ = (x->x[2]).(tns)
        arrows!(sct, x_, y_, u_, v_, scale_plot=false)
    end
    sct
end

function compandcenter(shap)
    c = shap.center
    segs = shap.contour
    mi1 = []
    mi2 = []
    cent1 = []
    cent2 = []
    cn1 = []
    cn2 = []
    for i in 1:size(segs,1)
        mi = midpoint(segs, i)
        push!(mi1, mi[1])
        push!(mi2, mi[2])

        to_cent = normalize(c-midpoint(segs, i))
        push!(cent1, to_cent[1])
        push!(cent2, to_cent[2])

        c_n = segmentnormal(segs, i)
        push!(cn1, c_n[1])
        push!(cn2, c_n[2])
    end
    sc = Scene()
    arrows!(sc, mi1, mi2, cent1, cent2, arrowcolor=:red, scale_plot=false)
    arrows!(sc, mi1, mi2, cn1, cn2, arrowcolor=:blue, scale_plot=false)
    sc
end

function translheatmap!(sc, shap, sidelength, dc=1; kwargs...)
    cont = shap.contour
    aabb = findAABB(cont)
    midp = sum(aabb)/2
    sidel = aabb[2]-aabb[1]

    xr = range(aabb[1][1]-sidel[1]/4, stop=aabb[2][1]+sidel[1]/4, length=sidelength)
    yr = range(aabb[1][2]-sidel[2]/4, stop=aabb[2][2]+sidel[2]/4, length=sidelength)
    if dc == 1
        mm = [RANSAC.impldistance2segment([i,j], shap)[1] for i in xr, j in yr]
    elseif dc == 2
        mm = [RANSAC.dist2segment([i,j], cont)[1] for i in xr, j in yr]
    elseif dc == 3
        mm = [RANSAC.impldistance2segment2([i,j], shap)[1] for i in xr, j in yr]
    elseif dc == 4
        mm = [RANSAC.impldistance2segment3([i,j], shap)[1] for i in xr, j in yr]
    end
    lines!(sc, cont, linewidth=1.5; kwargs...)
    heatmap!(sc, collect(xr), collect(yr), mm; kwargs...)
    leg = colorlegend(sc[end], raw=true, camera=campixel!)
    vbox(leg, sc)
end

function translheatmap(shap, sidelength, dc=1; kwargs...)
    sc = Scene()
    return translheatmap!(sc, shap, sidelength, dc; kwargs...)
end
