package utils;

import utils.CalculateTangents.calculateTangents;
import externs.Ogl.CreateGeometryProps;
import externs.Ogl.GL;
import externs.Ply.PlyModel;
import externs.Ogl.Geometry;

function createPLYGeometry(gl: GL, model: PlyModel): Geometry {
    final props: CreateGeometryProps = {
        position: { size: model.attributes.POSITION.size, data: model.attributes.POSITION.value },
    };
    if (model.attributes.NORMAL != null) {
        props.normal = { size: model.attributes.NORMAL.size, data: model.attributes.NORMAL.value };
        if (model.attributes.TEXCOORD_0 != null && model.indices != null) {
            props.tangent = { size: model.attributes.NORMAL.size, data: calculateTangents(model) };
        }
    }
    if (model.attributes.TEXCOORD_0 != null) {
        props.uv = { size: model.attributes.TEXCOORD_0.size, data: model.attributes.TEXCOORD_0.value };
    }
    if (model.indices != null) {
        props.index = { size: model.indices.size, data: model.indices.value };
    }
    return new Geometry(gl, props);
}