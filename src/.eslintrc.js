module.exports = {
	root: true,
	extends: ["plugin:tailwindcss/recommended"],
	parserOptions: {
		sourceType: "module",
		ecmaVersion: "latest",
	},

	// flowbiteで独自のクラスを定義していることが多いのでこのルールはオフにする
	rules: {
		"tailwindcss/no-custom-classname": "off",
	},
};
