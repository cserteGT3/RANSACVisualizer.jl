"""
    plotcontour(shape::FittedTranslational, plotnormals = false, noutw=false)

Plot the contour of a `FittedTranslational`.
`noutw==false` means that the normals point outwards, otherwise they point where the were fitted.
"""
function plotcontour(shape::FittedTranslational, plotnormals = false, noutw=false)
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
