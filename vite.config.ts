import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vite.dev/config/
export default defineConfig({
  base: '/tasks_assets',
  plugins: [react()],
  server : {
    port: 8080
  }
})
