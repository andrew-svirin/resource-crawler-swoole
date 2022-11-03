// Plugins
import vue from '@vitejs/plugin-vue';
import vuetify from 'vite-plugin-vuetify';

// Utilities
import { fileURLToPath, URL } from 'node:url';
import { defineConfig } from 'vite';

// https://vitejs.dev/config/
export default defineConfig({
  server: {
    port: 9000,
    host: '0.0.0.0',
    proxy: {
      '/api': 'http://localhost:80/api',
    }
  },
  plugins: [
    vue(),
    // https://github.com/vuetifyjs/vuetify-loader/tree/next/packages/vite-plugin
    vuetify({
      autoImport: true,
    }),
  ],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url))
    },
    extensions: [
      '.js',
      '.json',
      '.jsx',
      '.mjs',
      '.ts',
      '.tsx',
      '.vue',
    ],
  },
  build: {
    outDir: '../server/public/resources'
  },
  define: {'process.env': {}},
});
