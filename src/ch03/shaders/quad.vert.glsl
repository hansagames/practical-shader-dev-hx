#version 300 es
precision highp float;

layout (location = 0) in vec3 position; 
layout (location = 1) in vec4 color; 
layout (location = 3) in vec2 uv; 

out vec4 fragColor;
out vec2 fragUV;

void main()
{
	fragColor = color;
	fragUV = uv;
   	gl_Position = vec4(position, 1.0); 
}