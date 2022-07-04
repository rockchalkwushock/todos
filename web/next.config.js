/** @type {import('next').NextConfig} */
const nextConfig = {
  eslint: {
    dirs: ['components', 'hooks', 'layouts', 'pages', 'services', 'utils'],
  },
  reactStrictMode: true,
}

module.exports = nextConfig
