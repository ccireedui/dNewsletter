import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
// import GlobalsPolyfills from '@esbuild-plugins/node-globals-polyfill'
// import NodeModulesPolyfills from '@esbuild-plugins/node-modules-polyfill'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  
  define: {
    global: 'globalThis',
  },

})
