#version 300 es
precision highp float;

layout (location = 0) in vec3 position; 
layout (location = 3) in vec2 uv; 

out vec2 fragUV;

uniform vec2 size;
uniform vec2 frame;
uniform vec3 positionOffset;

void main()
{
	fragUV = vec2(uv.x, 1.0 - uv.y) * size + (frame * size);
   	gl_Position = vec4(position + positionOffset, 1.0); 
}