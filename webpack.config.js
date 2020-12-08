const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
    mode: 'development',
    devtool: 'source-map',
    entry: './build.hxml',
    output: {
      filename: 'main.js',
      path: path.resolve(__dirname, 'bin'),
    },
    module: {
      rules: [
        {
          test: /\.hxml$/,
          loader: 'haxe-loader',
          options: {
            debug: true
          }
        },
        {
          test: /\.glsl$/,
          loader: 'webpack-glsl-loader'
        },
        {
          test: /\.(png|jpe?g|gif|ply)$/i,
          use: [
            {
              loader: 'file-loader',
                options: {
                  esModule: false,
                },
            },
          ],
        },
      ]
    },
    plugins: [
      new HtmlWebpackPlugin({
        template: './bin/index.html'
      })
    ],
    devServer: {
        compress: true,
        port: 4444,
        overlay: true,
        hot: true,
        disableHostCheck: true
    }
  }