float diffuse(vec3 lightDir, vec3 normal) {
    return max(0.0, dot(normal, lightDir));
}
float specular(vec3 lightDir, vec3 viewDir, vec3 normal, float shininess) {
    vec3 halfVec = normalize(viewDir + lightDir);
    float specAmt = max(0.0, dot(halfVec, normal));
    return pow(specAmt, shininess);
}