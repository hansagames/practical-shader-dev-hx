package utils;

import VectorMath.Mat4;

function inverse(m:Mat4):Mat4 {
	final out = new Mat4(
		1,0,0,0,
		0,1,0,0,
		0,0,1,0,
		0,0,0,1
	);
	final det = determinant(m, 4);
	for (row in 0...4) {
		for (column in 0...4) {
			out[column][row] = cofactor(m, row, column, 4) / det;
		}
	}
	return out;
}

function determinant(m:Mat4, length: Int):Float {
	var det:Float = 0;
	if (length == 2) {
		det = m[0][0] * m[1][1] - m[0][1] * m[1][0];
	} else {
		for (column in 0...length) {
			det += m[0][column] * cofactor(m, 0, column, length);
		}
	}
	return det;
}

function cofactor(m:Mat4, row:UInt, column:UInt, length: Int):Float {
	final minorValue = minor(m, row, column, length);

	return (row + column) % 2 == 0 ? minorValue : minorValue * -1;
}

function minor(m:Mat4, row:UInt, column:UInt, length: Int):Float {
	return determinant(submatrix(m, row, column, length - 1), length - 1);
}

function submatrix(m:Mat4, rowToRemove:UInt, columnToRemove:UInt, length: Int):Mat4 {
    final out = new Mat4(
		1,0,0,0,
		0,1,0,0,
		0,0,1,0,
		0,0,0,1
	);
    var rows: Int;
    var columns: Int;
    if (length == 4) {
        rows = 3;
        columns = 3;
    } else {
        rows = 2;
        columns = 2;
    }
	var currentRow = 0;
	var currentColumn = 0;
	for (row in 0...rows) {
		if (row != rowToRemove) {
			currentColumn = 0;
			for (column in 0...columns) {
				if (column != columnToRemove) {
					out[currentRow][currentColumn] = m[row][column];
					currentColumn++;
				}
			}
			currentRow++;
		}
	}
	return out;
}