# RANSACVisualizer.jl

![Lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)<!--
![Lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-stable-green.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-retired-orange.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-archived-red.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-dormant-blue.svg) -->

This package provides a couple of functions to visualize the result of the RANSAC algorithm.
It is built top of [Makie.jl](https://github.com/JuliaPlots/Makie.jl) and [RANSAC.jl](https://github.com/cserteGT3/RANSAC.jl).
Check out the [docs](https://csertegt3.github.io/RANSACVisualizer.jl/dev/) for more.

~~## Disclaimer~~

~~The raytracer is written by @freemin7, author of the [SignedDistanceFields.jl](https://github.com/freemin7/SignedDistanceFields.jl) package.
Original source is the [example folder of that package](https://github.com/freemin7/SignedDistanceFields.jl/tree/master/example/raytracer).
I only changed things to get it work with `CSGNode`s (defined in [`CSGBuilding.jl`](https://github.com/cserteGT3/CSGBuilding.jl)).~~
