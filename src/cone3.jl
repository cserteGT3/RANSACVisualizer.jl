# source:
# https://github.com/JuliaGeometry/GeometryTypes.jl/issues/71#issuecomment-302175458

"""
A `Cone3` is a 3D cylinder defined by its origin point, its extremity
and a radius. `origin`, `extremity` and `r`, must be specified.
"""
struct Cone3{T} <: GeometryPrimitive{3,T}
  origin::Point{3,T}
  extremity::Point{3,T}
  r::T
end

origin(c::Cone3) = c.origin
extremity(c::Cone3) = c.extremity
radius(c::Cone3) = c.r
height(c::Cone3) = norm(c.extremity-c.origin)
direction(c::Cone3) = (c.extremity .- c.origin)./height(c)
function rotation(c::Cone3)
  u = [direction(c)...];
  v = abs(u[1])>0 || abs(u[2])>0 ? [u[2],-u[1],0] : [0,-u[3],u[2]]
  v ./= norm(v)
  w = [u[2]*v[3]-u[3]*v[2],-u[1]*v[3]+u[3]*v[1],u[1]*v[2]-u[2]*v[1]]
  return hcat(v,w,u)
end

isdecomposable(::Type{T}, ::Type{C}) where {T<:Point, C<:Cone3} = true
isdecomposable(::Type{T}, ::Type{C}) where {T<:Face, C<:Cone3} = true

function decompose1(PT::Type{Point{3,T}},c::Cone3{T},facets=12) where {T}
  isodd(facets) ? facets = 2*div(facets,2) : nothing
  facets<8 ? facets = 8 : nothing
  nbv = Int(facets/2)
  M = rotation(c)
  h = height(c)
  position = 1
  vertices = Array{PT}(undef, 2*nbv)
  for j = 1:nbv
    phi                = T((2*pi*(j-1))/nbv)
    vertices[position] = PT(M*[c.r*cos(phi);c.r*sin(phi);0])+PT(c.origin)
    vertices[position+1] = PT([0;0;h])+PT(c.origin)
    position += 2
  end
  vertices
end

function decompose1(::Type{FT},c::Cone3{T},facets=12) where FT<:Face where T
  isodd(facets) ? facets = 2*div(facets,2) : nothing
  facets<8 ? facets = 8 : nothing
  nbv = Int(facets/2)
  indexes = Array{Face{3,Int}}(undef, facets)
  index = 1
  for j = 1:(nbv-1)
    indexes[index] = (index,index+1,index+2)
    indexes[index+1] = (index+2,index+1,index+3)
    index += 2
  end
  indexes[index] = (index,index+1,1)
  indexes[index+1] = (1,index+1,2)
  indexes
end


function ConeMesh(orig, extr, rad, nfacets)
  obj = Cone3(orig, extr, rad)
  vert = decompose1(Point3f0, obj, nfacets)
  fac = decompose1(GLTriangle, obj, nfacets)
  fovMesh = GLNormalMesh(vertices=vert, faces=fac)
end
