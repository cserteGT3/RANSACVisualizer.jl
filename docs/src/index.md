# RANSACVisualizer.jl

The goal of RANSACVisualizer.jl  is to provide some basic methods to visualize point clouds and the results of the RANSAC algorithm runs, based on [RANSAC.jl](https://github.com/cserteGT3/RANSAC.jl).
See its [docs](https://csertegt3.github.io/RANSAC.jl/stable/) for examples.

## Plot a point cloud with surface normals

`showgeometry()` plots he points and also the surface normals.

```@docs
showgeometry
showgeometry!
```

## Plot the result of a RANSAC run

Based on a `PointCloud` and an array of `ScoredShape`s, plot the points and color them according to their type.

```@docs
showbytype
showbytype!
```

Plot the result of a run, but color every primitive differently.

```@docs
showshapes
showshapes!
```
