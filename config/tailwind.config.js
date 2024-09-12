const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
    './node_modules/flowbite/**/*.js'
  ],
  theme: {
    extend: {
      colors: {
        primary: '#e1f4f0',
        secondary: '#f19992',
        tertiary: '#a62759',
      },
      fontFamily: {
        sans: ['Prompt', ...defaultTheme.fontFamily.sans],
        // heading: ['Yellowtail', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
    require('flowbite/plugin')
  ]
}

// MAIN COLOR: #e1f4f0
// SECONDARY COLOR: #f19992
// TERTIARY COLOR: #a62759
