# RANSACVisualizer.jl

The goal of RANSACVisualizer.jl is to provide some basic methods to visualize point clouds and the results of the RANSAC algorithm runs, based on [RANSAC.jl](https://github.com/cserteGT3/RANSAC.jl), while separating dependencies that have impact on loading times.
[Makie.jl](https://github.com/JuliaPlots/Makie.jl) recipes are used to achieve these goals.
See its [docs](https://csertegt3.github.io/RANSAC.jl/stable/) for [examples](https://csertegt3.github.io/RANSAC.jl/stable/example/).

## Visualize extracted result

Based on a `PointCloud` and an `ExtractedShape`, plot the points and color them according to their type or randomly.

```@docs
visualize
```
