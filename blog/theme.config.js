export default {
    github: 'https://github.com/nikitabarskov/dev',
    docsRepositoryBase: 'https://github.com/nikitabarskov/dev/blob/master',
    titleSuffix: '',
    nextLinks: true,
    prevLinks: true,
    logo: (
        <>
            <span className="mr-2 font-extrabold hidden md:inline">Nikita Barskov</span>
            <span className="text-gray-600 font-normal hidden md:inline">
        Data Engineer based in Oslo, Norway
      </span>
        </>
    ),
    search: true,
    darkMode: true,
    defaultMenuCollapsed: true,
    footer: true,
    footerText: `MIT ${new Date().getFullYear()} © Nikita Barskov.`,
    floatTOC: true,
    i18n: [
        {locale: 'en', text: 'English'},
        {locale: 'ru', text: 'Русский'},
    ]
}
