const defaultTheme = require("tailwindcss/defaultTheme");

module.exports = {
	darkMode: 'class',
	content: [
		"./public/*.html",
		"./app/helpers/*.rb",
		"./app/javascript/**/*.js",
		"./app/javascript/*.js",
		"./app/views/**/*",
		"./node_modules/flowbite/**/*.js",
	],
	theme: {
		extend: {
			fontFamily: {
				sans: ["Inter var", ...defaultTheme.fontFamily.sans],
			},
		},
	},
	plugins: [
		require("@tailwindcss/forms"),
		require("@tailwindcss/aspect-ratio"),
		require("@tailwindcss/typography"),
		require("@tailwindcss/container-queries"),
		require("flowbite/plugin"),
	],
};
