# RANSACVisualizer.jl

![Lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)<!--
![Lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-stable-green.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-retired-orange.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-archived-red.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-dormant-blue.svg) -->
[![](https://img.shields.io/badge/docs-stable-blue.svg)](https://cserteGT3.github.io/RANSACVisualizer.jl/stable)
[![](https://img.shields.io/badge/docs-dev-blue.svg)](https://cserteGT3.github.io/RANSACVisualizer.jl/dev)

This package provides a couple of functions to visualize the result of the RANSAC algorithm.
It is built top of [Makie.jl](https://github.com/JuliaPlots/Makie.jl) and [RANSAC.jl](https://github.com/cserteGT3/RANSAC.jl).
Check out the [docs](https://csertegt3.github.io/RANSACVisualizer.jl/dev/) for more.

If it's hard to rotate the screen, because the mouse is too sensitive, use this command (from [issue comment](https://github.com/JuliaPlots/Makie.jl/issues/33#issuecomment-564329940)):
```julia
cameracontrols(scene).rotationspeed[] = 0.01f0
```
