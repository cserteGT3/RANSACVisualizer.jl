function plotcontour(shape::FittedTranslational, plotnormals = false)
    segs = shape.contour
    tns = [contournormal(shape, i) for i in eachindex(segs)]
    tms = [midpoint(segs, i) for i in eachindex(segs)]

    sct = lines(segs, scale_plot=false)
    if plotnormals
        scatter!(sct, tms, color=:red, scale_plot=false)
        x_ = (x->x[1]).(tms)
        y_ = (x->x[2]).(tms)
        u_ = (x->x[1]).(tns)
        v_ = (x->x[2]).(tns)
        arrows!(sct, x_, y_, u_, v_, scale_plot=false)
    end
    sct
end
