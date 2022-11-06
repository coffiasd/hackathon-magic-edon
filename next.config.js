/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  swcMinify: true,
  images: {
    remotePatterns: [
      {
        protocol: 'https',
        hostname: '**.ipfs.w3s.link',
      },
    ],
  },
  resolve: {
    extensions: ['', '.js', '.jsx']
  }
}

module.exports = nextConfig
