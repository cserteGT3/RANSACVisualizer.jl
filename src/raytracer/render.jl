## Max length of array is 2^16
## A sharder is (currenty) (subject to change due to unhandled reflections) a function that takes a RayResults struct and returns a RGB value
# DefaultShaderArray[1] = background
const DefaultShaderArray = [
    (x::RayResults)->RGB(0.35,0.35,0.35),
    #(x::RayResults)->(RGB(0.8,0.8,0.8)*10*SignedDistanceFields.clamp01(1/norm(x.Position))),
    (x::RayResults)->(RGB(x.Grad[1]/2+0.5,x.Grad[2]/2+0.5,x.Grad[3]/2+0.5)),
    (x::RayResults)->RGB(0.22,0.545,0.133)*(abs(x.Position[1]/(5*sqrt(2)))),
    (x::RayResults)->RGB(0.584,0.345,0.689)*(abs(x.Position[1]/(5*sqrt(2)))),
    (x::RayResults)->RGB(0.796,0.235,0.2)*(abs(x.Position[1]/(5*sqrt(2)))),
    (x::RayResults)->RGB(0.35,0.35,0.55)]


## CSGBuilding

function render!(frame, node::CSGNode, cam, x, y, shaders)
    for i=1:x ## loop able to produce more than 1 gigapixel per hour per core on my laptop if fed correctly
        for j=1:y
            a = los(cam, i, j)
            temp = raymarch(a[1], a[2], node, 1000.0)
            frame[i,j] = shaders[temp.Shader](temp)
        end
    end
    frame
end

function render(node::CSGNode, sizet, camf::Function, shaders)
    @unpack x, y = sizet
    #Höhe Breite - x
    #Heigth Width - y
    cam = camf(x, y)
    #frame = Array{RayResults}(undef,x,y);
    myPic = Array{RGB}(undef,x,y);

    render!(myPic, node, cam, x, y, shaders)
    return myPic
end

## SignedDistanceFields

function render!(frame, scene, cam, x, y, shaders)
    for i=1:x ## loop able to produce more than 1 gigapixel per hour per core on my laptop if fed correctly
        for j=1:y
            a = los(cam, i, j)
            #frame[i,j]
            temp = raymarch(a[1], a[2], scene, 1000.0)
            ## upto 3x over head due to excessive copying
            ## Stencils on this ^ would be fun :)
            frame[i,j] = shaders[temp.Shader](temp)
            ##TODO:reflections have no place in this model
            ## some improvement possible with the shader
        end
    end
    frame
end

function render(scene, sizet, camf::Function, shaders)
    @unpack x, y = sizet
    #Höhe Breite - x
    #Heigth Width - y
    cam = camf(x, y)
    frame = Array{RGB}(undef,x,y);
    ## render
    render!(frame, scene, cam, x, y, shaders)
    return frame
end
