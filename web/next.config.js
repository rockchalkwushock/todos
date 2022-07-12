const endpointURL = process.env.NEXT_PUBLIC_API_ENDPOINT

const ContentSecurityPolicy = `
  default-src 'self' ${endpointURL};
  script-src 'self';
  child-src 'self';
  style-src 'self';
  font-src 'self';
`

const securityHeaders = [
  process.env.NODE_ENV === 'production'
    ? {
        key: 'Content-Security-Policy',
        value: ContentSecurityPolicy.replace(/\s{2,}/g, ' ').trim(),
      }
    : {
        key: 'Content-Security-Policy-Report-Only',
        value: ContentSecurityPolicy.replace(/\s{2,}/g, ' ').trim(),
      },
  {
    key: 'Permissions-Policy',
    value: 'camera=(), microphone=(), geolocation=(), interest-cohort=()',
  },
  {
    key: 'Referrer-Policy',
    value: 'origin-when-cross-origin',
  },
  {
    key: 'X-Content-Type-Options',
    value: 'nosniff',
  },

  {
    key: 'X-XSS-Protection',
    value: '1; mode=block',
  },
]

/** @type {import('next').NextConfig} */
const nextConfig = {
  async headers() {
    return [
      {
        headers: securityHeaders,
        source: '/(.*)',
      },
    ]
  },
  eslint: {
    dirs: ['components', 'hooks', 'layouts', 'pages', 'services', 'utils'],
  },
  reactStrictMode: true,
}

module.exports = nextConfig
