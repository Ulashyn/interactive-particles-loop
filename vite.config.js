import { defineConfig } from "vite";
import glsl from 'vite-plugin-glsl';

export default defineConfig({
  base: '/',
  plugins: [
    glsl({
      warnDuplicatedImports: false,
    }),
  ],
  server: {
    port: 3000,
    open: true,
  },
  build: {
    outDir: 'dist',
  },
});