package utils;

import externs.Ogl.Vec2;
import externs.Ogl.Vec3;
import js.lib.Float32Array;
import externs.Ply.PlyModel;

function calculateTangents(model:PlyModel):Float32Array {
    final tangents:Array<Vec3> = [];
    final indexCount:Int = Std.int(model.indices.value.length / model.indices.size);
    final uvs = model.attributes.TEXCOORD_0.value;
    final vertices = model.attributes.POSITION.value;
    final indices = model.indices.value;
    for (i in 0...indexCount - 2) {
        if (i % 3 == 0) {
            final v0:Vec3 = new Vec3(vertices[indices[i]], vertices[indices[i + 1]], vertices[indices[i + 2]]);
            final v1:Vec3 = new Vec3(vertices[indices[i + 3]], vertices[indices[i + 4]], vertices[indices[i + 5]]);
            final v2:Vec3 = new Vec3(vertices[indices[i + 6]], vertices[indices[i + 7]], vertices[indices[i + 8]]);

            final uv0:Vec2 = new Vec2(uvs[indices[i]], uvs[indices[i + 1]]);
            final uv1:Vec2 = new Vec2(uvs[indices[i + 2]], uvs[indices[i + 3]]);
            final uv2:Vec2 = new Vec2(uvs[indices[i + 4]], uvs[indices[i + 5]]);

            final edge1 = v1.clone().sub(v0);
            final edge2 = v2.clone().sub(v0);
            final dUV1 = uv1.clone().sub(uv0);
            final dUV2 = uv2.clone().sub(uv0);

            final f = 1.0 / (dUV1.x * dUV2.y - dUV2.x * dUV1.y);

            final tan:Vec3 = new Vec3();
            tan.x = f * (dUV2.y * edge1.x - dUV1.y * edge2.x);
            tan.y = f * (dUV2.y * edge1.y - dUV1.y * edge2.y);
            tan.z = f * (dUV2.y * edge1.z - dUV1.y * edge2.z);
            tan.normalize();

            tangents[indices[i]] = tan.clone();
            tangents[indices[i + 1]] = tan.clone();
            tangents[indices[i + 2]] = tan.clone();
        }
    }
    final result = new Float32Array(tangents.length * 3);
    for (i in 0...tangents.length) {
        final t = tangents[i];
        result[i] = t.x;
        result[i + 1] = t.y;
        result[i + 2] = t.z;
    }
    return result;
}