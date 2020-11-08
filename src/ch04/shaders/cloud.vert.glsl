#version 300 es
precision highp float;

layout (location = 0) in vec3 position; 
layout (location = 3) in vec2 uv; 

out vec2 fragUV;

void main()
{
	fragUV = uv;
   	gl_Position = vec4(position, 1.0); 
}