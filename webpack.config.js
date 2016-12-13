const path = require('path');
const webpack = require('webpack');
const merge = require('webpack-merge');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const autoprefixer = require('autoprefixer');
const ExtractTextPlugin = require('extract-text-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');

console.log('WEBPACK GO!');

const pages = ['home', 'about'];

// Each page has some common core stuff
const allChunks = ['core', ...pages];

// Gather up the entry points, including core
const entry = allChunks.reduce((dict, p) => {
    dict[p] = `./src/static/${p}.js`;
    return dict;
}, {});

// And make an html page for each PAGE (excluding the core module)
const HtmlPlugins = pages.map(p =>
    new HtmlWebpackPlugin({
        template: './src/static/index.html',
        inject: 'body',
        chunks: ['core', p],
        filename: `${p}.html`
    }));


// detemine build env
const TARGET_ENV = process.env.npm_lifecycle_event === 'build' ? 'production' : 'development';

// common webpack config
const commonConfig = {

    entry,

    output: {
        path: path.resolve(__dirname, 'dist/'),
        filename: '[name].js',
    },

    resolve: {
        modulesDirectories: ['node_modules', 'bower_components'],
        extensions: ['', '.js', '.elm', '.styl']
    },

    module: {
        noParse: /\.elm$/,
        loaders: [{
            test: /\.(eot|ttf|woff|woff2|svg)$/,
            loader: 'file-loader'
        }]
    },

    plugins: [...HtmlPlugins],

    postcss: [autoprefixer({
        browsers: ['last 2 versions']
    })],

}

// additional webpack settings for local env (when invoked by 'npm start')
if (TARGET_ENV === 'development') {
    console.log('Serving locally...');

    module.exports = merge(commonConfig, {

        devServer: {
            inline: true,
            progress: true,
            host: '0.0.0.0',
            port: '8080'
        },

        module: {
            loaders: [{
                test: /\.elm$/,
                exclude: [/elm-stuff/, /node_modules/],
                loader: 'elm-hot!elm-webpack?verbose=true&warn=true&debug=true'
            }, {
                test: /\.css$/,
                loaders: [
                    'style-loader',
                    'css-loader',
                ]
            }, {
                test: /\.styl$/,
                loaders: [
                    'style-loader',
                    'css-loader',
                    'stylus-loader'
                ]
            }]
        }

    });
}

// additional webpack settings for prod env (when invoked via 'npm run build')
if (TARGET_ENV === 'production') {
    console.log('Building for prod...');

    module.exports = merge(commonConfig, {

        module: {
            loaders: [{
                test: /\.elm$/,
                exclude: [/elm-stuff/, /node_modules/],
                loader: 'elm-webpack'
            }, {
                test: /\.(css)$/,
                loader: ExtractTextPlugin.extract('style-loader', [
                    'css-loader',
                    'postcss-loader',
                ])
            }]
        },

        plugins: [
            new CopyWebpackPlugin([{
                from: 'src/static/img/',
                to: 'static/img/'
            }, {
                from: 'src/favicon.ico'
            }, {
                from: 'bower_components',
                to: 'bower_components'
            }]),

            new webpack.optimize.OccurenceOrderPlugin(),

            // extract CSS into a separate file
            new ExtractTextPlugin('./[hash].css', {
                allChunks: true
            }),

            // minify & mangle JS/CSS
            new webpack.optimize.UglifyJsPlugin({
                minimize: true,
                compressor: {
                    warnings: false
                }
                // mangle:  true
            })
        ]

    });
}
