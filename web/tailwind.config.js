/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ['./components/*.tsx', './layouts/*.tsx', './pages/**/*.tsx'],
  daisyui: {},
  theme: {
    extend: {},
  },
  plugins: [require('daisyui')],
}
