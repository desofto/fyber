const path = require('path')

module.exports = {
  pages: {
    index: {
      entry: 'app/index.js',
      template: 'public/index.html',
      filename: 'index.html',
      title: 'Fyber',
      chunks: ['chunk-vendors', 'chunk-common', 'index']
    }
  },

  devServer: {
    port: 8000,
    historyApiFallback: true,
    noInfo: false,
    overlay: true,
    open: true,
    hot: true,
    proxy: {
      "/api/*": {
        target: `http://localhost:3333`
      },
      '/ws': {
        target: `ws://localhost:3333`,
        ws: true
      },
    }
  },

  configureWebpack: {
    resolve: {
      alias: {
        '@': path.resolve('app/')
      }
    }
  }
}