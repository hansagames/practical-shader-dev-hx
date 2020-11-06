#version 300 es
precision highp float;

layout (location = 0) in vec3 position; 
layout (location = 3) in vec2 uv; 

uniform float time;

out vec2 fragUV;

void main()
{
	fragUV = vec2(uv.x, uv.y) + vec2(1.0, 0.0) * time;
   	gl_Position = vec4(position, 1.0); 
}