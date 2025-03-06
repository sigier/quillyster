/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  images: {
    domains: ["s.gravatar.com", "lh3.googleusercontent.com"],
  },
  productionBrowserSourceMaps: false,
  swcMinify: true,
};

module.exports = nextConfig;
