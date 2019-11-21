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
