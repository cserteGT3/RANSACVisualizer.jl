# colouring the points

"""
    getcolour(s::RANSAC.FittedShape) = get(ColorSchemes.rainbow, rand())

Don't fail for any shape, just return a random value.
"""
getcolour(s::RANSAC.FittedShape) = get(colorschemes[:rainbow], rand())

"""
    getcolour(s::RANSAC.ExtractedShape)

Just get the colour of the wrapped `RANSAC.FittedShape`.
"""
getcolour(s::RANSAC.ExtractedShape) = getcolour(s.shape)


# plane orange
# cylinder red
# sphere green
# cone blue

getcolour(s::RANSAC.FittedPlane) = get(colorschemes[:seaborn_bright], 0.1)
getcolour(s::RANSAC.FittedCylinder) = get(colorschemes[:seaborn_bright], 0.33)
getcolour(s::RANSAC.FittedSphere) = get(colorschemes[:seaborn_bright], 0.2)
getcolour(s::RANSAC.FittedCone) = get(colorschemes[:seaborn_bright], 0.0)
