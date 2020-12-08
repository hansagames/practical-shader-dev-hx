#version 300 es
precision highp float;

layout (location = 0) in vec3 position; 
layout (location = 3) in vec2 uv; 

out vec2 fragUV;

uniform mat4 model;
uniform mat4 view;

void main()
{
	fragUV = uv;
   	gl_Position = view * model * vec4(position, 1.0);  
}