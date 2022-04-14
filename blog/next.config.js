// next.config.js
const withNextra = require('nextra')({
    theme: 'nextra-theme-docs',
    themeConfig: 'theme.config.js'
})

const next = {
    experimental: {
        outputStandalone: true
    }
}

module.exports = Object.assign({}, withNextra({
    i18n: {
        locales: ['en', 'ru'],
        defaultLocale: 'en'
    }
}), next);
