// Example webpack configuration with asset fingerprinting in production.
'use strict';

var path = require('path');
var webpack = require('webpack');
var StatsPlugin = require('stats-webpack-plugin');

// must match config.webpack.dev_server.port
var devServerPort = 3808;

// set TARGET=production on the environment to add asset fingerprints
var production = process.env.TARGET === 'production';

var config = {
  entry: {
    // Sources are expected to live in $app_root/webpack
    'application': './webpack/application.js'
  },
  module: {
    loaders: [
      { test: /\.coffee$/, loader: 'coffee-loader' },
      { test: /jquery\.js$/, loader: 'expose?$' },
      { test: /jquery\.js$/, loader: 'expose?jQuery' },
      { test: /\.css$/, loaders: ["style", "css"] },
      { test: /\.scss$/, loaders: ["style", "css", "sass"] },
      { test: /\.less$/, loaders: ["style", "css", "less"] },
      { test: /\.woff(\?v=\d+\.\d+\.\d+)?$/, loader: "file" },
      { test: /\.woff2(\?v=\d+\.\d+\.\d+)?$/, loader: "file" },
      { test: /\.ttf(\?v=\d+\.\d+\.\d+)?$/, loader: "file" },
      { test: /\.eot(\?v=\d+\.\d+\.\d+)?$/, loader: "file" },
      { test: /\.svg(\?v=\d+\.\d+\.\d+)?$/, loader: "file" }
    ]
  },

  output: {
    // Build assets directly in to public/webpack/, let webpack know
    // that all webpacked assets start with webpack/

    // must match config.webpack.output_dir
    path: path.join(__dirname, '..', 'public', 'webpack'),
    publicPath: '/webpack/',

    filename: production ? '[name]-[chunkhash].js' : '[name].js'
  },

  resolve: {
    root: path.join(__dirname, '..', 'webpack'),
    extensions: ['', '.js', '.coffee', '.css', '.scss', '.less']
  },

  plugins: [
    // must match config.webpack.manifest_filename
    new StatsPlugin('manifest.json', {
      // We only need assetsByChunkName
      chunkModules: false,
      source: false,
      chunks: false,
      modules: false,
      assets: true
    }),
    new webpack.ProvidePlugin({
      $: 'jquery',
      jQuery: 'jquery',
      "window.jQuery": "jquery"
    })
  ]
};

if (production) {
  config.plugins.push(
    new webpack.NoErrorsPlugin(),
    new webpack.optimize.UglifyJsPlugin({
      compressor: { warnings: false },
      sourceMap: false
    }),
    new webpack.DefinePlugin({
      'process.env': { NODE_ENV: JSON.stringify('production') }
    }),
    new webpack.optimize.DedupePlugin(),
    new webpack.optimize.OccurenceOrderPlugin()
  );
} else {
  config.devServer = {
    port: devServerPort,
    headers: { 'Access-Control-Allow-Origin': '*' }
  };
  config.output.publicPath = '//localhost:' + devServerPort + '/webpack/';
  // Source maps
  config.devtool = 'cheap-module-eval-source-map';
}

module.exports = config;
